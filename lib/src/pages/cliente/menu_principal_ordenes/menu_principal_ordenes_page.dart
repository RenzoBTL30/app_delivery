import 'package:app_delivery/src/pages/cliente/menu_principal/cliente_menu_principal_page.dart';
import 'package:app_delivery/src/pages/cliente/menu_principal_ordenes/menu_principal_ordenes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClienteMenuPrincipalOrdenesPage extends StatelessWidget {

  ClienteMenuPrincipalOrdenesController cont = Get.put(ClienteMenuPrincipalOrdenesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Mis Pedidos',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        /*leading: IconButton(
          icon: Icon(Icons.arrow_back),S
          onPressed: () => cont.goToMenuPrincipal()
        )*/
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            _titleAtencionCliente(),
            SizedBox(
              height: 15,
            ),
            _titleIndicacion(),
            SizedBox(
              height: 10,
            ),
            _btnListaDeliveryOrdenes(context),
            _btnListaRecojoOrdenes(context)
          ],
        ),
      ),
      
    );
  }

  Widget _titleIndicacion () {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        'Escoge la forma de entrega que seleccionaste para tu pedido:',
        style: TextStyle(
          color: Colors.black, 
          fontSize: 17, 
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _titleAtencionCliente () {
    return Row(
      children: [
        SizedBox(width: 20),
        Icon(
          Icons.phone_in_talk,
          color: const Color.fromARGB(255, 9, 139, 13),
        ),
        SizedBox(width: 10),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'WhatsApp: 952810392',
            style: TextStyle(
              color: const Color.fromARGB(255, 9, 139, 13),
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }


  Widget _btnListaDeliveryOrdenes(BuildContext context) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
    child: ElevatedButton(
      onPressed: () => cont.goToListaOrdenesDelivery(),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        backgroundColor: Color(0xFFF2C447),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10),
          FadeInImage(
            placeholder: AssetImage('assets/images/no-image.png'),
            image: AssetImage('assets/images/img-boton-delivery.png'),
            width: 115,
            height: 115,
          ),
          SizedBox(height: 10),
          Text(
            'Delivery',
            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
  }


  Widget _btnListaRecojoOrdenes(BuildContext context) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
    child: ElevatedButton(
      onPressed: () => cont.goToListaOrdenesRecojo(),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        backgroundColor: Color(0xFFF2C447),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10),
          FadeInImage(
            placeholder: AssetImage('assets/images/no-image.png'),
            image: AssetImage('assets/images/img-boton-recojo.png'),
            width: 115,
            height: 115,
          ),
          SizedBox(height: 10),
          Text(
            'Recojo en tienda',
            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
  }
  



  /*Widget _btnListaDeliveryOrdenes(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      child: ElevatedButton(
        onPressed: () => cont.goToListaOrdenesDelivery(),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          backgroundColor: Color(0xFFC42227),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Gestionar Pedidos',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget _btnListaRecojoOrdenes(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      child: ElevatedButton(
        onPressed: () => cont.goToListaOrdenesRecojo(),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          backgroundColor: Color(0xFFC42227),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Gestionar Productos',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }*/

}