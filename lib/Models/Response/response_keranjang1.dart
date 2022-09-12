import 'dart:convert';

Keranjang1 responseKeranjang1FromJson(String str) =>
    Keranjang1.fromJson(json.decode(str));

String responseKeranjang1ToJson(Keranjang1 data) =>
    json.encode(data.toJson());

class Keranjang1 {
  bool? resp;
  String? msg;
  int? amount;
  int? uidKeranjang;

  Keranjang1({this.resp, this.msg, this.amount, this.uidKeranjang});

  Keranjang1.fromJson(Map<String, dynamic> json) {
    resp = json['resp'];
    msg = json['msg'];
    amount = json['amount'];
    uidKeranjang = json['uidKeranjang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resp'] = this.resp;
    data['msg'] = this.msg;
    data['amount'] = this.amount;
    data['uidKeranjang'] = this.uidKeranjang;
    return data;
  }
}