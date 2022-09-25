import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ongkir_event.dart';
part 'ongkir_state.dart';

class OngkirBloc extends Bloc<OngkirEvent, OngkirState> {
  OngkirBloc() : super(OngkirInitial()) {
    on<PilihOngkirEvent>(_showHideMenu);
    on<deleteongkirevent>(deleteongkir);
  }

  Future<void> _showHideMenu(
      PilihOngkirEvent event, Emitter<OngkirState> emit) async {
    int total = int.parse(event.Ongkir) + int.parse(event.Order);

    emit(SetOngkir(
      Ongkir: event.Ongkir,
      Total: total.toString(),
      Estimasi: event.Estimasi,
      Kota: event.Kota,
    ));
  }

  Future<void> deleteongkir(
      deleteongkirevent event, Emitter<OngkirState> emit) async {
    emit(OngkirInitial());
  }
}
