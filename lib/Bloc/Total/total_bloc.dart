import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'total_event.dart';
part 'total_state.dart';

class TotalBloc extends Bloc<TotalEvent, TotalState> {
  TotalBloc() : super(TotalInitial()) {
    on<PilihTotalEvent>(_showHideMenu);
  }

  Future<void> _showHideMenu(
      PilihTotalEvent event, Emitter<TotalState> emit) async {
    int Total = int.parse(event.Total) + int.parse(event.Ongkir);

    emit(SetTotal(Total: Total.toString()));
  }
}
