
import 'dart:async';

import 'package:almacen_android/packages/almacen/bloc/bloc_almacen_nuevoPedido_bloc.dart';
import 'package:almacen_android/packages/common/bloc/bloc_navigator_bloc.dart';
import 'package:almacen_android/packages/almacen/data/api_calls.dart';
import 'package:almacen_android/packages/almacen/model/pojo/articulo_nvopedido.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:permission_handler/permission_handler.dart';


class NuevoPedido extends StatelessWidget{
  final bool admn;

  String nombreArticulo;
  String cantidad;
  BuildContext _context;

  final TextEditingController _typeAheadController = TextEditingController();
  final TextEditingController _observacionesController = TextEditingController();
  final TextEditingController _controller = TextEditingController();


  NuevoPedido({Key key, @required this.admn, this.nombreArticulo}):super(key: key);
  @override
  Widget build(BuildContext context) {
    _context = context;
    if(nombreArticulo != null){
      _typeAheadController.text = nombreArticulo;
    }
    BlocProvider.of<NuevoPedidoBloc>(context).add(NuevoPedidoInitialize(admn));
    return BlocListener<NuevoPedidoBloc, NuevoPedidoState>(
      listener: (context, state){
        if(state.nombresArticulosFromQr != null){
          _abrirModalQrDetactado(context, state);
        }
      },
      child: BlocBuilder<NuevoPedidoBloc,NuevoPedidoState>(
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
                          onPressed: () {
                            if(state.tamanioListaArticulosAPedir != null &&state.tamanioListaArticulosAPedir != 0){
                              _clickNuevoPedido(context);
                            }else {
                              EasyLoading.showToast("Por favor ingrese al menos un artículo a pedir");
                            }

                          },
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
      ),
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
        SizedBox(height: 10.0),
        TextField(
            maxLength: 140,
            maxLines: 4,
            decoration: const InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical:5.0, horizontal: 10.0),
              hintStyle: TextStyle(color: Colors.grey),
              hintText: "Observaciones",
              border: OutlineInputBorder(),
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
          if(index == 0){
            return _rowNuevoArticulo(context);
          }else{
            return _rowArticulo(context, state.articulosAPedir[index-1]);
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
    BlocProvider.of<NavigatorBloc>(context).add(NavigatorEventPushPage(1));

  }

  void scannearMultiplesArticulos() async{
    await Permission.camera.request();
    String resultado = await FlutterBarcodeScanner.scanBarcode(
        "#ff0000", "Cancelar", true, ScanMode.QR);

    if(RegExp("articulo{1}-.{1,}-[0-9]{1,}").hasMatch(resultado)){
      print("añadido");
      BlocProvider.of<NuevoPedidoBloc>(_context).add(NuevoPedidoEventArticulosFromQr(resultado));
    }else{
      EasyLoading.showToast("Por favor scanee un Qr de Artículo!");
    }
  }

  void _abrirModalQrDetactado(BuildContext contexto, NuevoPedidoState state){
    showModalBottomSheet<void>(
        context: contexto,
        builder: (BuildContext context) {
          return Container(
              height: 700,
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text('Articulo: ' +
                            state.nombresArticulosFromQr.split("-")[1]),
                        SizedBox(height: 35.0,),
                        Align(child: Text('Ingrese la cantidad:'), alignment: Alignment.centerLeft,),
                        TextField(controller: _controller, keyboardType: TextInputType.number, maxLength: 3, autofocus: true,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () => _finalizar(contexto, state.nombresArticulosFromQr.split("-")[1], _controller.value.text),
                              child: Text("Finalizar"),
                            ),
                            SizedBox(width: 40.0,),
                            ElevatedButton(
                                onPressed: () => _continuar(contexto, state.nombresArticulosFromQr.split("-")[1], _controller.value.text),
                                child: Text("Continuar Scaneo")
                            ),
                          ],
                        )
                      ]
                  )
              )
          );
        }
    );
  }

  void _continuar(BuildContext context, String nombreArt, String nuevaCantidad){
    if(nuevaCantidad != null && nuevaCantidad.isNotEmpty && nuevaCantidad != "0"){
      _finalizar(context, nombreArt, nuevaCantidad);
      scannearMultiplesArticulos();
    }else {
      EasyLoading.showToast("Por favor ingrese una cantidad válida!");
    }

  }

  void _finalizar(BuildContext context, String nombre, String nuevaCantidad){
    if(nuevaCantidad != null && nuevaCantidad.isNotEmpty && nuevaCantidad != "0"){
      BlocProvider.of<NuevoPedidoBloc>(context).add(NuevoPedidoEventAddArt(nombre, nuevaCantidad));
      Navigator.pop(context);
      _controller.text = "";
    }else {
      EasyLoading.showToast("Por favor ingrese una cantidad válida!");
    }
  }

}



