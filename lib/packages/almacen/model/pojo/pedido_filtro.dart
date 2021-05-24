
import 'package:almacen_android/packages/common/utils.dart';

import '../pedido.dart';

class PedidoFiltro{
  List<PedidoEstados> estados = [
    PedidoEstados.EnCurso,
    PedidoEstados.EnEspera,
    PedidoEstados.Entregado
  ];

  bool filterByEstado(Pedido p){
    for(PedidoEstados e in estados){
      if(e.toString().split(".").last == p.estadoPedido.replaceAll(" ", "")){
        return true;
      }
    }


    return false;
  }

  void setFilter(PedidoEstados estado, bool apply){
    if(apply){
      if(!estados.contains(estado))
        estados.add(estado);
    }else{
      if(estados.contains(estado))
        estados.remove(estado);
    }
  }
}