part of 'ongkir_bloc.dart';

@immutable
abstract class OngkirEvent {}

class PilihOngkirEvent extends OngkirEvent {
  final String Ongkir;
  final String Order;

  PilihOngkirEvent({required this.Ongkir, required this.Order});
}
