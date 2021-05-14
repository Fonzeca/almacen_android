part of 'scan_screen_bloc.dart';

abstract class ScanScreenEvent extends Equatable{
  const ScanScreenEvent();
  @override
  List<Object> get props => [];

}


class ScanEventGetGrupoLlave extends ScanScreenEvent{
  final String identificacionGrupoLlaves;
  ScanEventGetGrupoLlave(this.identificacionGrupoLlaves);
}
class ScanEventGetGrupoEquipo extends ScanScreenEvent{
  final String identificacionGrupoEquipo;
  ScanEventGetGrupoEquipo(this.identificacionGrupoEquipo);

}
class ScanEventGetEquipo extends ScanScreenEvent{
  final String identificacionEquipo;
  ScanEventGetEquipo(this.identificacionEquipo);

}
class ScanEventGetArticulo extends ScanScreenEvent{
  final String identificacionArticulo;
  ScanEventGetArticulo(this.identificacionArticulo);
}
