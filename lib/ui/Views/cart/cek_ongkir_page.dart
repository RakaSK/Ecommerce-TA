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

class CekOngkir extends StatefulWidget {
  final String jumlahquantity;
  final int beratproduk = 500;
  const CekOngkir({Key? key, required this.jumlahquantity}) : super(key: key);

  @override
  State<CekOngkir> createState() => _CekOngkirState();
}

class _CekOngkirState extends State<CekOngkir> {
  var key = '10cb836f3ab0ef52cad5298b57367723';
  String? kota_asal = "445";
  var kota_tujuan;
  // String? berat = widget.jumlahquantity.toString();
  var beratproduk = 500;
  var kurir;
  var namakurir;
  var nama_kota_tujuan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cek Ongkir Kamu"),
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

            Container(
              // margin: const EdgeInsets.all(30.0),
              // padding: const EdgeInsets.all(50.0),
              width: 360,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 120, 120, 120)),
                borderRadius: BorderRadius.all(Radius.circular(4.2)),
              ),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Kota Surakarta (Solo)',
                  style: TextStyle(fontSize: 15, height: 1.8),
                ),
              ),
            ),
            // Text("Kota Asal = Solo"),
            SizedBox(height: 30),
            DropdownSearch<Kota>(
              //kamu bisa merubah tampilan field sesuai keinginan
              dropdownSearchDecoration: InputDecoration(
                labelText: "Kota Tujuan",
                hintText: "Pilih Kota Tujuan",
                // helperText: "Pilih Kota Tujuan",
                border: OutlineInputBorder(),
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
            Container(
              // margin: const EdgeInsets.all(30.0),
              // padding: const EdgeInsets.all(50.0),
              width: 360,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 120, 120, 120)),
                borderRadius: BorderRadius.all(Radius.circular(4.2)),
              ),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Berat Paket (gr) = ${(widget.jumlahquantity)} pcs x 500 gr = ${int.parse(widget.jumlahquantity) * 500} gr',
                  style: TextStyle(fontSize: 15, height: 1.8),
                ),
              ),
              // child: Text(
              //     "Berat Paket (gr) = ${(widget.jumlahquantity)} pcs * 500 gr =  ${int.parse(widget.jumlahquantity) * 500} gr",
              //     style: TextStyle(
              //       fontSize: 15,
              //       height: 2.7,
              //     ),
              //     textWidthBasis: TextWidthBasis.parent),
            ),
            // Text(
            //     "Berat Paket (gr) = ${(widget.jumlahquantity)} pcs * 500 gr =  ${int.parse(widget.jumlahquantity) * 500} gr"),
            SizedBox(height: 30),
            DropdownSearch<String>(
                mode: Mode.MENU,
                showSelectedItems: true,
                //pilihan kurir
                items: ["jne", "tiki", "pos"],
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Kurir",
                  hintText: "Kurir",
                  // helperText: "Pilih Kurir",
                  border: OutlineInputBorder(),
                ),
                popupItemDisabled: (String s) => s.startsWith('I'),
                onChanged: (text) {
                  kurir = text;
                  namakurir = text?.toUpperCase();
                }),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(fixedSize: const Size(360, 45)),
              onPressed: () {
                //validasi
                if (kota_asal == '' ||
                    kota_tujuan == '' ||
                    // berat == '' ||
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
                              berat: (int.parse(widget.jumlahquantity) * 500)
                                  .toString(),
                              kurir: kurir,
                              namakurir: namakurir,
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
