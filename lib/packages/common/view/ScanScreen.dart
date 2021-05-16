import 'package:almacen_android/packages/common/bloc/scan_screen_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';


class ScanScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
   _scannear(context);
   return BlocListener<ScanScreenBloc, ScanScreenState>(
      listener: (context, state) {
      if(state.equipo!=null){

      }
      if(state.articulo!=null){

      }
      if(state.grupoLlave!=null){

      }
      if(state.grupoEquipo!=null){

      }
    },
    child: Container(
      child: ElevatedButton.icon(onPressed:()=> _scannear(context), icon: const Icon(Icons.camera_alt), label: Text("Abrir cámara")),
    ),);
  }

  Future<void> _scannear (BuildContext context) async{
    await Permission.camera.request();
    String resultado = await FlutterBarcodeScanner.scanBarcode("#ff0000", "Cancelar", true, ScanMode.QR);
    if(resultado != null) {
      if (RegExp("grupoL{1}-.{1,}-[0-9]{1,}").hasMatch(resultado)) {
        BlocProvider.of<ScanScreenBloc>(context).add(
            ScanEventGetGrupoLlave(resultado));
      } else if (RegExp("grupoE{1}-.{1,}-[0-9]{1,}").hasMatch(resultado)) {
        BlocProvider.of<ScanScreenBloc>(context).add(
            ScanEventGetEquipo(resultado));
      } else if (RegExp("equipo{1}-.{1,}-[0-9]{1,}").hasMatch(resultado)) {
        BlocProvider.of<ScanScreenBloc>(context).add(
            ScanEventGetEquipo(resultado));
      } else if (RegExp("articulo{1}-.{1,}-[0-9]{1,}").hasMatch(resultado)) {
        BlocProvider.of<ScanScreenBloc>(context).add(
            ScanEventGetArticulo(resultado));
      }
    }else{
      EasyLoading.showToast("Se canceló la operación");
    }
  }


}