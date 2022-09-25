part of 'ongkir_bloc.dart';

@immutable
abstract class OngkirState {}

class OngkirInitial extends OngkirState {}

class SetOngkir extends OngkirState {
  final String Ongkir;
  final String Total;
  final String Estimasi;
  final String Kota;

  SetOngkir(
      {required this.Ongkir,
      required this.Total,
      required this.Estimasi,
      required this.Kota})
      : super();
}
