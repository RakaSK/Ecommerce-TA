import 'dart:convert';

import 'package:e_commers/ui/Views/cart/detailpage.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:e_commers/ui/Views/cart/widgets/kota.dart';

import 'package:http/http.dart' as http;

// void main() {
//   runApp(const OpsiKirim());
// }

// class OpsiKirim extends StatelessWidget {
//   const OpsiKirim({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Cek Ongkos Kirim',
//       debugShowCheckedModeBanner: false,
//       home: Home(),
//     );
//   }
// }

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var key = '10cb836f3ab0ef52cad5298b57367723';
  String? kota_asal = "445";
  var kota_tujuan;
  String? berat = "500";
  var kurir;
  var nama_kota_tujuan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cek Ongkir"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DropdownSearch<Kota>(
            //   //kamu bisa mendekorasi tampilan field
            //   dropdownSearchDecoration: InputDecoration(
            //     labelText: "Kota Asal",
            //     hintText: "Pilih Kota Asal",
            //   ),

            //   //tersedia mode menu dan mode dialog
            //   mode: Mode.MENU,

            //   //jika ingin menampilkan pencarian box
            //   showSearchBox: true,

            //   //di dalam event kita bisa set state atau menyimpan variabel
            //   onChanged: (value) {
            //     // kota_asal = value?.cityId;
            //   },

            //   //kata yang ditampilkan setelah kita memilih
            //   itemAsString: (item) => "Solo",

            //   //mencari data dari api
            //   onFind: (text) async {
            //     //mengambil data dari api
            //     var response = await http.get(Uri.parse(
            //         "https://api.rajaongkir.com/starter/city?key=${key}"));

            //     //parse string json as dart string dynamic
            //     //get data just from results
            //     List allKota = (jsonDecode(response.body)
            //         as Map<String, dynamic>)['rajaongkir']['results'];

            //     //simpan data ke dalam model kota
            //     var dataKota = Kota.fromJsonList(allKota);

            //     //return data
            //     return dataKota;
            //   },
            // ),
            Text("Kota Asal = Solo"),
            SizedBox(height: 20),
            DropdownSearch<Kota>(
              //kamu bisa merubah tampilan field sesuai keinginan
              dropdownSearchDecoration: InputDecoration(
                labelText: "Kota Tujuan",
                hintText: "Pilih Kota Tujuan",
              ),

              //tersedia mode menu dan mode dialog
              mode: Mode.MENU,

              //jika kamu ingin menampilkan pencarian
              showSearchBox: true,

              //di dalam onchang3e kamu bisa set state
              onChanged: (value) {
                kota_tujuan = value?.cityId;
                nama_kota_tujuan = value?.cityName;
              },

              //kata yang akan ditampilkan setelah dipilih
              itemAsString: (item) => "${item!.type} ${item.cityName}",

              //find data from api
              onFind: (text) async {
                //get data from api
                var response = await http.get(Uri.parse(
                    "https://api.rajaongkir.com/starter/city?key=${key}"));

                //parse string json as dart string dynamic
                //get data just from results

                List allKota = (jsonDecode(response.body)
                    as Map<String, dynamic>)['rajaongkir']['results'];

                //store data to model
                var dataKota = Kota.fromJsonList(allKota);

                //return data
                return dataKota;
              },
            ),
            SizedBox(height: 30),
            // TextField(
            //   //input hanya angka
            //   keyboardType: TextInputType.number,
            //   decoration: InputDecoration(
            //     labelText: "Berat Paket (gram)",
            //     hintText: "Input Berat Paket",
            //   ),
            //   onChanged: (text) {
            //     berat = text;
            //   },
            // ),
            Text("Berat Paket (gram) = $berat"),
            SizedBox(height: 30),
            DropdownSearch<String>(
                mode: Mode.MENU,
                showSelectedItems: true,
                //pilihan kurir
                items: ["jne", "tiki", "pos"],
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Kurir",
                  hintText: "Kurir",
                ),
                popupItemDisabled: (String s) => s.startsWith('I'),
                onChanged: (text) {
                  kurir = text;
                }),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                //validasi
                if (kota_asal == '' ||
                    kota_tujuan == '' ||
                    berat == '' ||
                    kurir == '') {
                  final snackBar =
                      SnackBar(content: Text("Isi bidang yang masih kosong!"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  //berpindah halaman dan bawa data
                  Navigator.push(
                    context,
                    // DetailPage adalah halaman yang dituju
                    MaterialPageRoute(
                        builder: (context) => DetailPage(
                              kota_asal: kota_asal,
                              kota_tujuan: kota_tujuan,
                              berat: berat,
                              kurir: kurir,
                              nama_kota_tujuan: nama_kota_tujuan,
                            )),
                  );
                }
              },
              child: Center(
                child: Text("Cek Ongkir"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
