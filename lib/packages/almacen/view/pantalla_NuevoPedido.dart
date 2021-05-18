
import 'package:almacen_android/packages/almacen/bloc/bloc_almacen_nuevoPedido_bloc.dart';
import 'package:almacen_android/packages/almacen/data/api_calls.dart';
import 'package:almacen_android/packages/almacen/model/pojo/articulo_nvopedido.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class NuevoPedido extends StatelessWidget{
  final bool admn;

  String nombreArticulo;
  String cantidad;

  final TextEditingController _typeAheadController = TextEditingController();
  final TextEditingController _observacionesController = TextEditingController();


  NuevoPedido({Key key, @required this.admn, this.nombreArticulo}):super(key: key);
  @override
  Widget build(BuildContext context) {
  if(nombreArticulo != null){
    _typeAheadController.text = nombreArticulo;
  }
    BlocProvider.of<NuevoPedidoBloc>(context).add(NuevoPedidoInitialize(admn));
    return BlocBuilder<NuevoPedidoBloc,NuevoPedidoState>(
        builder: (context,state){
          if(state.listaArticulos != null && (!admn || state.listaUsuarios != null)){
            EasyLoading.dismiss();
            return Container(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      _crearVista(context, admn, state),
                      FloatingActionButton.extended(
                        onPressed: () => _clickNuevoPedido(context),
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
    Widget seccionElegirUsuario = null;

    if(adm){
      seccionElegirUsuario =
        Column(
          children: [
            Text("Usuario",style: TextStyle(color: Colors.grey)),
            DropdownButton<String>(
              value: state.nombreUsuario,
              items: state.listaUsuarios.map<DropdownMenuItem<String>>((String value){
                return DropdownMenuItem<String>(value : value,child: Text(value,style: TextStyle(color: Colors.black),),);
              }).toList(),
              onChanged: (String newValue){
                BlocProvider.of<NuevoPedidoBloc>(context).add(NuevoPedidoEventSetUser(newValue));
              },
              style: TextStyle(fontSize: 16),
            ),
            Divider(color: Colors.deepOrangeAccent,thickness: 1.0,),
            SizedBox(height: 10.0,),
          ],
        );
    }
    return Column(
      children: [
        seccionElegirUsuario ?? Container(),
        Container(
            height: 250,
            child: _listaArticulos(context, state)
        ),
        Divider(color: Colors.deepOrangeAccent,thickness: 1.0,),
        SizedBox(height: 10.0),
        TextField(
            maxLength: 140,
            maxLines: 4,
            decoration: const InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical:5.0, horizontal: 10.0),
              hintStyle: TextStyle(color: Colors.grey),
              hintText: "Observaciones",
            ),
            controller: _observacionesController
        ),
      ],
    );
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
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(
                    hintText: "Artículo",
                    hintStyle: TextStyle(
                      color: Colors.black26,
                    )
                  ),
                  controller: _typeAheadController,
                ),
                suggestionsCallback: (pattern) async{
                  if(pattern.length < 3){
                    return ["NO HAY"];
                  }
                  return Servidor().getArticulosLikeNombre(pattern);
                },
                noItemsFoundBuilder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("No se encontro", style: TextStyle(fontSize: 20, color: Colors.black26),),
                  );
                },
                hideOnError: true,
                itemBuilder: (context, itemData) {
                  if(itemData == "NO HAY"){
                    return Container();
                  }else{
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(itemData.nombre),
                    );
                  }
                },
                onSuggestionSelected: (suggestion) {
                  _typeAheadController.text = suggestion.nombre;
                  nombreArticulo = suggestion.nombre;
                },
              ),
          ),
          SizedBox(width: 25.0),
          Expanded(
            child: TextField(
              controller: TextEditingController(
                text: ""
              ),
              onChanged: (value) => cantidad = value,
              decoration: const InputDecoration(
                hintText: "Cantidad",
                hintStyle: TextStyle(
                    color: Colors.black26,
                ),
              ),
              keyboardType: TextInputType.number,
              maxLength: 3,
            ),
          ),
          IconButton(icon: const Icon(Icons.add),
              onPressed: () {
                if(nombreArticulo != null && nombreArticulo.isNotEmpty
                    && cantidad != null && cantidad.isNotEmpty && cantidad != "0"){
                  _agregarArt(context, nombreArticulo, cantidad);
                }else {
                  EasyLoading.showToast("Por favor ingrese un artículo y cantidad válidos.");
                }
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
            onPressed: () { _quitarArt(context, articulo.nombreArt); },
          )
        ],
      );
  }

  void _agregarArt (BuildContext context, String nombre, String cant){
    BlocProvider.of<NuevoPedidoBloc>(context).add(NuevoPedidoEventAddArt(nombre, cant));
    _typeAheadController.text = "";
    nombreArticulo = "";
    cantidad = null;
  }

  void _quitarArt (BuildContext context, String nombre){
    BlocProvider.of<NuevoPedidoBloc>(context).add(NuevoPedidoEventDeleteArt(nombre));
  }

  void _clickNuevoPedido(BuildContext context){
    BlocProvider.of<NuevoPedidoBloc>(context).add(NuevoPedidoEventSavePedido(_observacionesController.text));
    _observacionesController.text = "";
  }




}


