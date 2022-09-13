import 'dart:convert';
import 'package:e_commers/Models/Response/response_order_buy.dart';
import 'package:e_commers/Models/Response/response_order_details.dart';
import 'package:http/http.dart' as http;
import 'package:e_commers/Helpers/secure_storage_frave.dart';
import 'package:e_commers/Models/product.dart';
import 'package:e_commers/Models/Response/response_default.dart';
import 'package:e_commers/Service/urls.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PembayaranServices {
  Future<ResponseDefault> saveOrderBuyProductToDatabase(
      String receipt, String amount, List<ProductCart> products) async {
    final token = await secureStorage.readToken();

    Map<String, dynamic> data = {
      'receipt': receipt,
      'amount': amount,
      'products': products
    };

    final body = json.encode(data);

    final resp = await http.post(
        Uri.parse('${URLS.urlApi}/product/save-order-buy-product'),
        headers: {'Content-type': 'application/json', 'xxx-token': token!},
        body: body);

    return ResponseDefault.fromJson(jsonDecode(resp.body));
  }

  Future<ResponseDefault> saveOrderBuyProductToDatabase1() async {
    final token = await secureStorage.readToken();

    // Map<String, dynamic> data = {
    //   'receipt': receipt,
    //   'amount': amount,
    //   'products': products
    // };

    // final body = json.encode(data);

    final resp = await http.post(
      Uri.parse('${URLS.urlApi}/product/save-order-buy-product-1'),
      headers: {'Content-type': 'application/json', 'xxx-token': token!},
    );

    return ResponseDefault.fromJson(jsonDecode(resp.body));
  }

  Future<ResponseDefault> saveOrderBuyProductToDatabase2(
      String uidOrder, String image) async {
    final token = await secureStorage.readToken();
    print(uidOrder);

    var request = http.MultipartRequest('POST',
        Uri.parse('${URLS.urlApi}/product/save-order-buy-product-2' + uidOrder))
      ..headers['Accept'] = 'application/json'
      ..headers['xxx-token'] = token!
      ..fields['uidOrder'] = uidOrder
      // ..fields.addEntries(MapEntry("uidOrder" : uidOrder));
      ..files.add(
          await http.MultipartFile.fromPath('BuktiPembayaranImage', image));

    final resp = await request.send();
    var data = await http.Response.fromStream(resp);

    return ResponseDefault.fromJson(jsonDecode(data.body));
  }

  Future<List<OrderBuy>> getPurchasedProducts() async {
    final token = await secureStorage.readToken();
    // print(token);
    // final uidPerson = await secureStorage.read(key: uidPerson);

    Map<String, dynamic> data = {
      'token': token,
    };

    final body = json.encode(data);
    final response = await http.post(
        Uri.parse('${URLS.urlApi}/product/get-all-purchased-products'),
        headers: {'Content-type': 'application/json', 'xxx-token': token!},
        body: body);
    return ResponseOrderBuy.fromJson(jsonDecode(response.body)).orderBuy;
  }

  Future<List<OrderDetail>> getOrderDetails(String uidOrder) async {
    final token = await secureStorage.readToken();
    print(uidOrder);

    final response = await http.get(
      Uri.parse('${URLS.urlApi}/product/get-orders-details/' + uidOrder),
      headers: {'Content-type': 'application/json', 'xxx-token': token!},
    );
    print(response.body);
    return ResponseOrderDetails.fromJson(jsonDecode(response.body))
        .orderDetails;
  }
}

final pembayaranServices = PembayaranServices();
