
import 'package:almacen_android/packages/almacen/bloc/bloc_almacen_nuevoPedido_bloc.dart';
import 'package:almacen_android/packages/almacen/model/pojo/articulo_nvopedido.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class NuevoPedido extends StatelessWidget{
  final bool admn;

  String nombreArticulo;
  String cantidad;

  NuevoPedido({Key key, @required this.admn}):super(key: key);
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NuevoPedidoBloc>(context).add(NuevoPedidoInitialize());
    return BlocBuilder<NuevoPedidoBloc,NuevoPedidoState>(
        builder: (context,state){
          if(state.listaArticulos != null && state.listaUsuarios != null){
            EasyLoading.dismiss();
            return Container(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      Center(
                          child: Text("Nuevo Pedido",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold))
                      ),
                      SizedBox(height: 10.0,),
                      Divider(height: 0.5,color: Colors.orange,),
                      SizedBox(height: 10.0,),
                      _crearVista(context, admn, state),
                      FloatingActionButton.extended(
                        onPressed: () => {},
                        icon: const Icon(Icons.save_alt),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        backgroundColor: Theme.of(context).accentColor,
                        elevation: 5,

                        label: const Text('Aceptar',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }else{
            EasyLoading.show();
            return Container();
          }
        }
    );
  }

  Widget _crearVista (BuildContext context, bool adm, NuevoPedidoState state){
    if(adm){
      return Column(
        children: [
          Text("Usuario",style: TextStyle(color: Colors.grey)),
          DropdownButton<String>(
            value: state.nombreUsuario,
            items: state.listaUsuarios.map<DropdownMenuItem<String>>((String value){
              return DropdownMenuItem<String>(value : value,child: Text(value),);
            }).toList(),
            onChanged: (String newValue){
              BlocProvider.of<NuevoPedidoBloc>(context).add(NuevoPedidoEventSetUser(newValue));
            },
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10.0,),
          Container(
              height: 200,
              child: _listaArticulos(context, state)
          ),
          SizedBox(height: 10.0),
          TextField(maxLength: 140, maxLines: 4,decoration: const InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical:5.0, horizontal: 10.0),
            hintStyle: TextStyle(color: Colors.grey),
            hintText: "Observaciones",
          ),
          ),
        ],
      );
    }
    else{
      return Column(
        children: [
          Container(
              height: 200,
              child: _listaArticulos(context, state)
          ),
          SizedBox(height: 10.0),
          TextField(maxLength: 140, maxLines: 4,decoration: const InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical:5.0, horizontal: 10.0),
            hintStyle: TextStyle(color: Colors.grey),
            hintText: "Observaciones",
          ),
          )
        ],
      );
    }
  }



  Widget _listaArticulos(BuildContext context, NuevoPedidoState state){
    if(state.articulosAPedir != null){
      return ListView.builder(
        itemCount: state.articulosAPedir.length + 1,
        itemBuilder: (context, index) {
          if(index == state.articulosAPedir.length){
            return _rowNuevoArticulo(context);
          }else{
            return _rowArticulo(context, state.articulosAPedir[index]);
          }
        },
      );
    }else{
      return _rowNuevoArticulo(context);
    }

  }

  Widget _rowNuevoArticulo(BuildContext context){
    return
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: TextField(
                onChanged: (value) => nombreArticulo = value,
                decoration: const InputDecoration(hintText: "Artículo"),
                autofocus: true,
              )
          ),
          SizedBox(width: 25.0),
          Expanded(
            child: TextField(
              onChanged: (value) => cantidad = value,
              decoration: const InputDecoration(hintText: "Cantidad"),
              keyboardType: TextInputType.number,
              maxLength: 3,
            ),
          ),
          IconButton(icon: const Icon(Icons.add),
              onPressed: () {
                if(nombreArticulo!=null&&cantidad!=null){
                  _agregarArt(context, nombreArticulo, cantidad); }
                else EasyLoading.showToast("Por favor ingrese un artículo y cantidad válidos.");
              }
          )
        ],
      );
  }

  Widget _rowArticulo(BuildContext context, Artxcant articulo){
    return
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Text(articulo.nombreArt)
          ),
          SizedBox(width: 25.0),
          Expanded(
              child: Text(articulo.cantidad)
          ),
          IconButton(icon: const Icon(Icons.remove),
            onPressed: () { _quitarArt(context, nombreArticulo); },
          )
        ],
      );
  }

  void _agregarArt (BuildContext context, String nombre, String cant){
    BlocProvider.of<NuevoPedidoBloc>(context).add(NuevoPedidoEventAddArt(nombre, cant));
  }

  void _quitarArt (BuildContext context, String nombre){
    BlocProvider.of<NuevoPedidoBloc>(context).add(NuevoPedidoEventDeleteArt(nombre));
  }
}


