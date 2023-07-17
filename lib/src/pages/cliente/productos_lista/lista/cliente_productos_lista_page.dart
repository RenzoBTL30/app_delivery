import 'package:app_delivery/src/models/categoria.dart';
import 'package:app_delivery/src/models/producto.dart';
import 'package:app_delivery/src/pages/cliente/productos_lista/lista/cliente_productos_lista_controller.dart';
import 'package:app_delivery/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClienteProductosListaPage extends StatelessWidget {

  ClienteProductosListaController con = Get.put(ClienteProductosListaController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => DefaultTabController(
      length: con.categorias.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(130),
          child: AppBar(
            flexibleSpace: Container(
              margin: EdgeInsets.only(top: 15),
              alignment: Alignment.topCenter,
              child: Wrap(
                direction: Axis.horizontal,
                children: [
                  _textFieldBuscador(context),
                  _iconBolsaCompras()
                ],
              ),
            ),
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              unselectedLabelColor: Color.fromARGB(255, 145, 143, 143),
              tabs: List<Widget>.generate(con.categorias.length, (index){
                return Tab(
                  child: Text(con.categorias[index].nombre ?? ''),
                );
              })
            ),
          ),
        ),
        body: TabBarView(
          children: con.categorias.map((Categoria categoria){
            return FutureBuilder(
              future: con.getProductos(categoria.idCategoria ?? '1'),
              builder: (context, AsyncSnapshot<List<Producto>> snapshot) {
                if (snapshot.hasData) {

                  if (snapshot.data!.length > 0) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (_,index) {
                        return _cardProducto(context, snapshot.data![index]); //Retorna un producto o varios
                      }
                    );
                  }
                  else {
                    return NoDataWidget(text: 'No hay productos',);
                  }
                } else {
                  return NoDataWidget(text: 'No hay productos',);
                }
              }
            );
          }).toList(),
        )
      )
    ));
  }

  Widget _iconBolsaCompras () {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: IconButton(
          onPressed: () => con.goToOrdenesCreate(), 
          icon: Icon(
            Icons.shopping_bag_outlined,
            size: 30,
          )
        ),
      ),
    );
  }

  Widget _textFieldBuscador(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Buscar producto o promoción',
            suffixIcon: Icon(Icons.search, color: Colors.grey),
            hintStyle: TextStyle(
              fontSize: 17,
              color: Colors.grey
            ),
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.grey
              )
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.grey
              )
            ),
            contentPadding: EdgeInsets.all(15)
          ),
        ),
      ),
    );
  }

  Widget _cardProducto(BuildContext context, producto) {
    return GestureDetector(
      onTap: () => con.openBottomSheet(context, producto),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15, left: 5, right: 5),
            child: ListTile(
              title: Text(
                producto.nombre ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text(
                    producto.descripcion ?? '',
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 13
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'S/${producto.precio?.toStringAsFixed(2).toString()}',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 13
                    ),
                  ),
                  SizedBox(height: 20),
                ]
              ),
              leading: SizedBox(
                child: Container(
                  height: double.infinity,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: FadeInImage(
                      height: 120,
                      image: producto.imagen != null 
                      ? NetworkImage(producto.imagen!) 
                      : AssetImage('assets/images/no-image.png') as ImageProvider,
                      fit: BoxFit.cover,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/images/no-image.png'),
                    ),
                  ),     
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey[400],
            indent: 37,
            endIndent: 37,
          ),
        ],
      ),
    );
  }
}