import 'package:app_delivery/src/pages/admin/admin_inicio/admin_inicio_page.dart';
import 'package:app_delivery/src/pages/admin/menu_principal/admin_menu_principal.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminMenuPrincipalPage extends StatelessWidget {

  AdminMenuPrincipalController cont = Get.put(AdminMenuPrincipalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: cont.indexTab.value,
        children: [
          AdminInicioPage(),
        ],
      ))
    );
  }

}