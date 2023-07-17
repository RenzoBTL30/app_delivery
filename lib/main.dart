import 'package:app_delivery/src/models/usuario.dart';
import 'package:app_delivery/src/pages/admin/menu_principal/admin_menu_principal_page.dart';
import 'package:app_delivery/src/pages/admin/ordenes/detalle/admin_orden_detalle_page.dart';
import 'package:app_delivery/src/pages/admin/ordenes/list/admin_orden_list_page.dart';
import 'package:app_delivery/src/pages/cliente/descuentos/descuentos_page.dart';
import 'package:app_delivery/src/pages/cliente/direcciones/create/direcciones_create_page.dart';
import 'package:app_delivery/src/pages/cliente/direcciones/lista/direcciones_lista_page.dart';
import 'package:app_delivery/src/pages/cliente/direcciones_solo_lista/create/direcciones_solo_lista_create_page.dart';
import 'package:app_delivery/src/pages/cliente/direcciones_solo_lista/lista/direcciones_solo_lista_lista_page.dart';
import 'package:app_delivery/src/pages/cliente/forma_entrega/cliente_forma_entrega_page.dart';
import 'package:app_delivery/src/pages/cliente/menu_principal/cliente_menu_principal_page.dart';
import 'package:app_delivery/src/pages/cliente/bolsa/create/cliente_ordenes_create_page.dart';
import 'package:app_delivery/src/pages/cliente/menu_principal_ordenes/menu_principal_ordenes_page.dart';
import 'package:app_delivery/src/pages/cliente/ordenes/ordenes_delivery/detalle/cliente_ordenes_delivery_detalle_page.dart';
import 'package:app_delivery/src/pages/cliente/ordenes/ordenes_delivery/list/cliente_ordenes_delivery_list_page.dart';
import 'package:app_delivery/src/pages/cliente/ordenes/ordenes_recojo_tienda/detalle/cliente_ordenes_recojo_detalle_page.dart';
import 'package:app_delivery/src/pages/cliente/ordenes/ordenes_recojo_tienda/list/cliente_ordenes_recojo_list_page.dart';
import 'package:app_delivery/src/pages/cliente/pagos/pagos.page.dart';
import 'package:app_delivery/src/pages/cliente/perfil/info/cliente_perfil_page.dart';
import 'package:app_delivery/src/pages/cliente/perfil/update_contra/cliente_perfil_update_contra_page.dart';
import 'package:app_delivery/src/pages/cliente/perfil/update_datos/cliente_perfil_update_page.dart';
import 'package:app_delivery/src/pages/cliente/productos_lista/lista/cliente_productos_lista_page.dart';
import 'package:app_delivery/src/pages/cliente/registro_pedido_completado/registro_pedido_completado_page.dart';
import 'package:app_delivery/src/pages/cliente/resumen_pago/resumen_pago_page.dart';
import 'package:app_delivery/src/pages/delivery/ordenes/detalle/delivery_ordenes_detalle_page.dart';
import 'package:app_delivery/src/pages/delivery/ordenes/list/delivery_ordenes_list_page.dart';
import 'package:app_delivery/src/pages/delivery/ordenes/map/delivery_orden_map_page.dart';
import 'package:app_delivery/src/pages/delivery/perfil/info/delivery_perfil_page.dart';
import 'package:app_delivery/src/pages/delivery/perfil/update_contra/delivery_perfil_update_contra_page.dart';
import 'package:app_delivery/src/pages/delivery/perfil/update_datos/delivery_perfil_update_page.dart';
import 'package:app_delivery/src/pages/home.cliente/home_cliente_page.dart';
import 'package:app_delivery/src/pages/login/login.dart';
import 'package:app_delivery/src/pages/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;


Usuario usuarioSession = Usuario.fromJson(GetStorage().read('usuario') ?? {});

void main() async {
  await GetStorage.init();
  //tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'La Paycha',
      theme: ThemeData(
        // Tipografía por defecto de la app
        fontFamily: 'PoppinsRegular',
        primaryColor: Color(0xFFF2C447),
        colorScheme: const ColorScheme(
          brightness: Brightness.light, 
          primary: Color(0xFFF2C447), 
          onPrimary: Colors.grey, 
          secondary: Colors.amberAccent,
          onSecondary: Colors.grey,
          background: Colors.grey,
          onBackground: Colors.grey,
          error: Colors.grey,
          onError: Colors.grey,
          surface: Colors.grey, 
          onSurface: Colors.grey
        )
      ),
      initialRoute: usuarioSession.idUsuario != null && usuarioSession.rol == 'Cliente' ? '/cliente/menuprincipal' : (usuarioSession.idUsuario != null && usuarioSession.rol == 'Administrador' ? '/admin/menuprincipal' : (usuarioSession.idUsuario != null && usuarioSession.rol == 'Delivery' ? '/delivery/ordenes/list' : '/')),
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/homecliente', page: () => HomeClientePage()),
        GetPage(name: '/cliente/menuprincipal', page: () => ClienteMenuPrincipalPage()),
        GetPage(name: '/cliente/perfil/info', page: () => ClientePerfilPage()),
        GetPage(name: '/cliente/perfil/update', page: () => ClientePerfilUpdatePage()),
        GetPage(name: '/cliente/perfil/updatecontra', page: () => ClientePerfilUpdateContraPage()),
        GetPage(name: '/cliente/productos/lista', page: () => ClienteProductosListaPage()),
        GetPage(name: '/cliente/descuentos', page: () => ClienteDescuentosPage()),
        GetPage(name: '/cliente/direccion/create', page: () => ClienteDireccionesCreatePage()),
        GetPage(name: '/cliente/direccion/lista', page: () => ClienteDireccionesListaPage()),
        GetPage(name: '/cliente/direccion/sololista/create', page: () => ClienteDireccionesSoloListaCreatePage()),
        GetPage(name: '/cliente/direccion/sololista/lista', page: () => ClienteDireccionesSoloListaListaPage()),
        GetPage(name: '/cliente/pagos', page: () => ClientePagosPage()),
        GetPage(name: '/cliente/ordenes/create', page: () => ClienteOrdenesCreatePage()),
        GetPage(name: '/cliente/ordenes/menuprincipal', page: () => ClienteMenuPrincipalOrdenesPage()),
        GetPage(name: '/cliente/ordenes/delivery/list', page: () => ClienteOrdenesDeliveryListPage()),
        GetPage(name: '/cliente/ordenes/delivery/detalle', page: () => ClienteOrdenesDeliveryDetallePage()),
        GetPage(name: '/cliente/ordenes/recojo/list', page: () => ClienteOrdenesRecojoListPage()),
        GetPage(name: '/cliente/ordenes/recojo/detalle', page: () => ClienteOrdenesRecojoDetallePage()),
        GetPage(name: '/cliente/formaentrega', page: () => ClienteFormaEntregaPage()),
        GetPage(name: '/cliente/resumenpago', page: () => ClienteResumenPagoPage()),
        GetPage(name: '/cliente/registropedidocomplete', page: () => ClienteRegistroPedidoCompletadoPage()),
        GetPage(name: '/delivery/ordenes/list', page: () => DeliveryOrdenesListPage()),
        GetPage(name: '/delivery/ordenes/detalle', page: () => DeliveryOrdenesDetallePage()),
        GetPage(name: '/delivery/ordenes/map', page: () => DeliveryOrdenesMapPage()),
        GetPage(name: '/delivery/perfil/info', page: () => DeliveryPerfilPage()),
        GetPage(name: '/delivery/perfil/update', page: () => DeliveryPerfilUpdatePage()),
        GetPage(name: '/delivery/perfil/updatecontra', page: () => DeliveryPerfilUpdateContraPage()),
        GetPage(name: '/admin/menuprincipal', page: () => AdminMenuPrincipalPage()),
        GetPage(name: '/admin/ordenes/lista', page: () => AdminOrdenListPage()),
        GetPage(name: '/admin/ordenes/detalle', page: () => AdminOrdenDetallePage()),
        GetPage(name: '/admin/perfil/info', page: () => ClientePerfilPage()),
        GetPage(name: '/admin/perfil/update', page: () => ClientePerfilUpdatePage()),
        GetPage(name: '/admin/perfil/updatecontra', page: () => ClientePerfilUpdateContraPage()),
        //GetPage(name: '/admin/gestionar/productos', page: () => AdminMenuPrincipalPage()),

        
      ],
      
      navigatorKey: Get.key,
    );
  }
}