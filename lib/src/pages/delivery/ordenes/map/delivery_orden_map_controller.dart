import 'dart:async';

import 'package:app_delivery/src/environment/environment.dart';
import 'package:app_delivery/src/models/orden.dart';
import 'package:app_delivery/src/providers/orden.provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
//import 'package:socket_io_client/socket_io_client.dart';

class DeliveryOrdenMapController extends GetxController {

  /*Socket socket = io('${Environment.API_URL}orders/delivery', <String, dynamic> {
    'transports': ['websocket'],
    'autoConnect': false
  });*/

  Orden orden = Orden.fromJson(Get.arguments['orden'] ?? {});
  OrdenProvider ordenProvider = OrdenProvider();

  CameraPosition initialPosition = CameraPosition(
      target: LatLng(-11.987783, -76.838203),
      zoom: 14
  );

  LatLng? addressLatLng;
  var addressName = ''.obs;

  Completer<GoogleMapController> mapController = Completer();
  Position? position;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;
  BitmapDescriptor? deliveryMarker;
  BitmapDescriptor? homeMarker;

  StreamSubscription? positionSubscribe;

  Set<Polyline> polylines = <Polyline>{}.obs;
  List<LatLng> points = [];

  double distanceBetween = 0.0;
  bool isClose = false;

  DeliveryOrdenMapController() {
    print('Orden: ${orden.toJson()}');

    checkGPS(); // VERIFICAR SI EL GPS ESTA ACTIVO
    //connectAndListen();
  }

  void isCloseToDeliveryPosition() {

    if (position != null) {
      distanceBetween = Geolocator.distanceBetween(
          position!.latitude,
          position!.longitude,
          orden.direccion!.lat!,
          orden.direccion!.lng!
      );

      print('distanceBetween ${distanceBetween}');

      if (distanceBetween <= 200 && isClose == false) {
        isClose = true;
        update();
      }

    }

  }

/*
  void connectAndListen() {
    socket.connect();
    socket.onConnect((data) {
      print('ESTE DISPISITIVO SE CONECTO A SOCKET IO');
    });
  }

  void emitPosition() {
    if (position != null) {
      socket.emit('position', {
        'id_order': order.id,
        'lat': position!.latitude,
        'lng': position!.longitude,
      });
    }
  }

  void emitToDelivered() {
    socket.emit('delivered', {
      'id_order': order.id,
    });
  }
*/
  Future setLocationDraggableInfo() async {

    double lat = initialPosition.target.latitude;
    double lng = initialPosition.target.longitude;

    List<Placemark> address = await placemarkFromCoordinates(lat, lng);

    if (address.isNotEmpty) {
      String direction = address[0].thoroughfare ?? '';
      String street = address[0].subThoroughfare ?? '';
      String city = address[0].locality ?? '';
      String department = address[0].administrativeArea ?? '';
      String country = address[0].country ?? '';
      addressName.value = '$direction #$street, $city, $department';
      addressLatLng = LatLng(lat, lng);
      print('LAT Y LNG: ${addressLatLng?.latitude ?? 0} ${addressLatLng?.longitude ?? 0}');
    }

  }

  Future<BitmapDescriptor> createMarkerFromAssets(String path) async {
    ImageConfiguration configuration = ImageConfiguration();
    BitmapDescriptor descriptor = await BitmapDescriptor.fromAssetImage(
        configuration, path
    );

    return descriptor;
  }

  void addMarker(
    String markerId,
    double lat,
    double lng,
    String title,
    String content,
    BitmapDescriptor iconMarker
  ) {
    MarkerId id = MarkerId(markerId);
    Marker marker = Marker(
        markerId: id,
        icon: iconMarker,
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: title, snippet: content)
    );

    markers[id] = marker;

    update();
  }

  void checkGPS() async {
    //deliveryMarker = await createMarkerFromAssets('assets/images/delivery_little.png');
    homeMarker = await createMarkerFromAssets('assets/images/entrega-location.png');

    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (isLocationEnabled == true) {
      updateLocation();
    }
    else {
      bool locationGPS = await location.Location().requestService();
      if (locationGPS == true) {
        updateLocation();
      }
    }
  }

  /*
  Future<void> setPolylines(LatLng from, LatLng to) async {
    PointLatLng pointFrom = PointLatLng(from.latitude, from.longitude);
    PointLatLng pointTo = PointLatLng(to.latitude, to.longitude);
    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
        Environment.API_KEY_MAPS,
        pointFrom,
        pointTo
    );

    for (PointLatLng point in result.points) {
      points.add(LatLng(point.latitude, point.longitude));
    }

    Polyline polyline = Polyline(
        polylineId: PolylineId('poly'),
        color: Colors.amber,
        points: points,
        width: 5
    );

    polylines.add(polyline);
    update();
  }*/

  void updateLocation() async {
    try{
      await _determinePosition();
      position = await Geolocator.getLastKnownPosition(); // LAT Y LNG (ACTUAL)
      //saveLocation();
      animateCameraPosition(position?.latitude ?? -11.987783, position?.longitude ?? -76.838203);

      /*addMarker(
          'delivery',
          position?.latitude ?? -11.987783,
          position?.longitude ?? -76.838203,
          'Tu posicion',
          '',
          deliveryMarker!
      );*/

      addMarker(
          'home',
          orden.direccion?.lat ?? -11.987783,
          orden.direccion?.lng ?? -76.838203,
          'Lugar de entrega',
          '',
          homeMarker!
      );

      LatLng from = LatLng(position!.latitude, position!.longitude);
      LatLng to = LatLng(orden.direccion?.lat ?? -11.987783, orden.direccion?.lng ?? -76.838203);

      //setPolylines(from, to);

      LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 1
      );

      positionSubscribe = Geolocator.getPositionStream(
          locationSettings: locationSettings
      ).listen((Position pos ) { // POSICION EN TIEMPO REAL
        position = pos;
        /*addMarker(
            'delivery',
            position?.latitude ?? 1.2004567,
            position?.longitude ?? -77.2787444,
            'Tu posicion',
            '',
            deliveryMarker!
        );*/
        animateCameraPosition(position?.latitude ?? 1.2004567, position?.longitude ?? -77.2787444);
        //emitPosition();
        isCloseToDeliveryPosition();
      });

    } catch(e) {
      print('Error: ${e}');
    }
  }

  void centerPosition() {
    if (position != null) {
      animateCameraPosition(position!.latitude, position!.longitude);
    }
  }

/*
  void saveLocation() async {
    if (position != null) {
      orden.lat = position!.latitude;
      orden.lng = position!.longitude;
      await ordersProvider.updateLatLng(order);
    }
  }
*/

  Future animateCameraPosition(double lat, double lng) async {
    GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(lat, lng),
          zoom: 14,
          bearing: 0
      )
    ));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }


    return await Geolocator.getCurrentPosition();
  }

  void onMapCreate(GoogleMapController controller) {
    controller.setMapStyle('[]');
    mapController.complete(controller);
  }


  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    //socket.disconnect();
    positionSubscribe?.cancel();
  }
}
