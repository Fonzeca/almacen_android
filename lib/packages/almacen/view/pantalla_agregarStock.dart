import 'package:almacen_android/packages/almacen/bloc/bloc_almacen_agregar_stock_bloc.dart';
import 'package:almacen_android/packages/almacen/model/articulo.dart';
import 'package:almacen_android/packages/common/bloc/bloc_navigator_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:permission_handler/permission_handler.dart';

class AgregarStock extends StatelessWidget{

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _scannear(context);
    BlocProvider.of<AgregarStockBloc>(context).add(AgregarStockEventInitialize());
    _controller.text = "";
    return BlocListener<AgregarStockBloc, AlmacenAgregarStockState>(listener: (context, state){
      if(state.carga){
        EasyLoading.show();
      }else {
        EasyLoading.dismiss();
      }

      if(state.success){
        EasyLoading.showSuccess("Stock agregado");
      }

      if(state.qrArticulo != null && state.articulo == null){
        BlocProvider.of<AgregarStockBloc>(context).add(AgregarStockEventBuscarArticulo(state.qrArticulo));
      }
    },
      child: BlocBuilder<AgregarStockBloc, AlmacenAgregarStockState>(
        builder: (context, state){
          if(state.qrArticulo == null){
            return Container(child: Center(child: ElevatedButton.icon(onPressed:()=> _scannear(context), icon: const Icon(Icons.camera_alt), label: Text("Abrir cámara"))),
            );
          }else{
            if(state.articulo != null){
              Articulo articulo = state.articulo;
              return Container(
                child: Column(
                  children: [
                    Text(articulo.nombre, style: TextStyle(fontSize: 24),),
                    Text("Inserte la cantidad a agregar:"),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(keyboardType: TextInputType.number,maxLength: 3, controller: _controller,),
                    ),
                    FloatingActionButton.extended(onPressed: ()=>_sumarStock(context, articulo.nombre, _controller.text), label: Text("Agregar")),
                  ],
                ),
              );
            }else {
              return Container (child: Text("No se encontró el artículo deseado"));
            }
          }
        },
      ),
    );
  }

  Future<void> _scannear (BuildContext context) async{
    await Permission.camera.request();
    String resultado = await FlutterBarcodeScanner.scanBarcode("#ff0000", "Cancelar", true, ScanMode.QR);
    if(resultado != null){
      if(RegExp("articulo{1}-.{1,}-[0-9]{1,}").hasMatch(resultado)){
        BlocProvider.of<AgregarStockBloc>(context).add(AgregarStockEventReconocerQr(resultado));

      }else EasyLoading.showToast("El código scaneado no corresponde con un artículo!\n\nPor favor inténtelo nuevamente.");

    }else EasyLoading.showToast("Se canceló la operación");
  }

  Future<void> _sumarStock(BuildContext context,String id, String cantidad){
    BlocProvider.of<AgregarStockBloc>(context).add(AgregarStockEventAgregarStock(id,cantidad));
    BlocProvider.of<AgregarStockBloc>(context).add(AgregarStockEventInitialize());
    BlocProvider.of<NavigatorBloc>(context).add(NavigatorEventPushPage(0));
  }

}