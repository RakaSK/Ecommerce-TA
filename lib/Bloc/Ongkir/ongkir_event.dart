part of 'ongkir_bloc.dart';

@immutable
abstract class OngkirEvent {}

class PilihOngkirEvent extends OngkirEvent {
  final String Ongkir;
  final String Order;
  final String Estimasi;
  final String Kota;

  PilihOngkirEvent(
      {required this.Ongkir,
      required this.Order,
      required this.Estimasi,
      required this.Kota});
}

class deleteongkirevent extends OngkirEvent {
  deleteongkirevent();
}
