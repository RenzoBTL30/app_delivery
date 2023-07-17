
import 'package:app_delivery/src/pages/delivery/ordenes/map/delivery_orden_map_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryOrdenesMapPage extends StatelessWidget {

  DeliveryOrdenMapController con = Get.put(DeliveryOrdenMapController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliveryOrdenMapController> (
      builder: (value) => Scaffold(
      backgroundColor: Colors.grey[900],
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55,
              child: _googleMaps()
            )
          ),
          SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buttonBack(),
                  ],
                ),
                Spacer(),
                _cardOrderInfo(context),
              ],
            ),
          ),
          // _buttonAccept(context)
        ],
      ),
    ));
  }

  Widget _buttonBack() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20),
      child: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          size: 30,
        ),
      ),
    );
  }

  Widget _cardOrderInfo(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 4,
            blurRadius: 6,
            offset: Offset(0, 3)
          )
        ]
      ),
      child: Column(
        children: [
          _listTileAddress(
              'Lugar', con.orden.direccion?.lugar ?? '',
              Icons.my_location
          ),
          _listTileAddress(
              'Direccion', con.orden.direccion?.direccion ?? '',
              Icons.location_on
          ),
          Divider(color: Colors.grey, endIndent: 30, indent: 30),
          _clientInfo(),
          _clientCelular()
        ],
      ),
    );
  }

  Widget _clientInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
      child: Row(
        children: [
          Text(
            'Cliente: ${con.orden.cliente?.nombre ?? ''} ${con.orden.cliente?.apellidos ?? ''}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget _clientCelular() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35, vertical: 5),
      child: Row(
        children: [
          Text(
            'Celular: ${con.orden.cliente?.celular ?? ''}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget _listTileAddress(String title, String subtitle, IconData iconData) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 13,
            color: Colors.white
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
              color: Colors.white
          ),
        ),
        trailing: Icon(iconData, color: Colors.white,),
      ),
    );
  }

  /*Widget _iconCenterMyLocation() {
    return GestureDetector(
      onTap: () => con.centerPosition(),
      child: Container(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          shape: CircleBorder(),
          color: Colors.white,
          elevation: 4,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.location_searching,
              color: Colors.grey[600],
              size: 20,
            ),
          ),
        ),
      ),
    );
  }*/

  
  Widget _googleMaps() {
    return GoogleMap(
      initialCameraPosition: con.initialPosition,
      mapType: MapType.normal,
      onMapCreated: con.onMapCreate,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      markers: Set<Marker>.of(con.markers.values),
      polylines: con.polylines,
    );
  }
}