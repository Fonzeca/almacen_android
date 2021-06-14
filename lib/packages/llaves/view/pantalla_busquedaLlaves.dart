import 'package:almacen_android/packages/llaves/data/api_calls.dart';
import 'package:almacen_android/packages/common/bloc/bloc_navigator_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class BuscarLlave extends StatelessWidget{
  final TextEditingController _controller = TextEditingController();

  final TextEditingController _typeAheadController = TextEditingController();

  String nombreLlave;
  String idLlave;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                      decoration: InputDecoration(
                          hintText: "Nombre de la llave",
                          hintStyle: TextStyle(
                            color: Colors.black26,
                          )
                      ),
                      controller: _typeAheadController,
                    ),
                    suggestionsCallback: (pattern) async{
                      if(pattern.length < 2){
                        return ["NO HAY"];
                      }
                      return ServidorLlaves().getLlaveLikeNombre(pattern);
                    },
                    noItemsFoundBuilder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("No se encontro", style: TextStyle(fontSize: 20, color: Colors.black26),),
                      );
                    },
                    hideOnError: false,
                    itemBuilder: (context, itemData) {
                      if(itemData == "NO HAY"){
                        return Container();
                      }else{
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(itemData.nombre + " - copia " + itemData.copia),
                        );
                      }
                    },
                    onSuggestionSelected: (suggestion) {
                      _typeAheadController.text = suggestion.nombre + " - copia " + suggestion.copia;
                      nombreLlave = suggestion.nombre;
                      idLlave = suggestion.id;
                    },
                  ),
                ),
                TextButton(onPressed: ()=> _buscarLlave(context, idLlave), child: Text("Buscar"))
              ],
            ),
          ),
        ],
      ),
    );

  }
  void _buscarLlave(BuildContext context, String id){
    BlocProvider.of<NavigatorBloc>(context).add(NavigatorEventPushPage(21,parametro: id));
  }

}