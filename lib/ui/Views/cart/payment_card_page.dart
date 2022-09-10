// import 'package:e_commers/Bloc/cart/cart_bloc.dart';
// import 'package:e_commers/Models/Card/CreditCardFrave.dart';
// import 'package:e_commers/ui/themes/colors_frave.dart';
// import 'package:flutter/material.dart';
// import 'package:e_commers/Data/ListCard.dart';
// import 'package:e_commers/ui/widgets/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class PaymentCardPage extends StatelessWidget {
//   const PaymentCardPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final cartBloc = BlocProvider.of<CartBloc>(context);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const TextFrave(
//             text: 'Transfer Bank Manual',
//             color: Colors.black,
//             fontSize: 21,
//             fontWeight: FontWeight.bold),
//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(
//           splashRadius: 20,
//           icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
//         itemCount: cards.length,
//         itemBuilder: (_, i) {
//           final CreditCardFrave card = cards[i];

//           return BlocBuilder<CartBloc, CartState>(
//             builder: (context, state) => GestureDetector(
//               onTap: () => cartBloc.add(OnSelectCardEvent(card)),
//               child: Container(
//                 margin: EdgeInsets.only(bottom: 20.0),
//                 padding: EdgeInsets.all(10.0),
//                 height: 80,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15.0),
//                     border: Border.all(
//                         color: state.creditCardFrave == null
//                             ? Colors.black
//                             : state.creditCardFrave!.cvv == card.cvv
//                                 ? Colors.blue
//                                 : Colors.black)),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                         height: 80,
//                         width: 80,
//                         child: SvgPicture.asset('assets/${card.brand}.svg')),
//                     Container(
//                         child: TextFrave(
//                             text: '**** **** **** ${card.cardNumberHidden}')),
//                     Container(
//                         child: state.creditCardFrave == null
//                             ? Icon(Icons.radio_button_off_rounded, size: 31)
//                             : state.creditCardFrave!.cvv == card.cvv
//                                 ? Icon(
//                                     Icons.radio_button_checked_rounded,
//                                     size: 31,
//                                     color: Colors.blue,
//                                   )
//                                 : Icon(Icons.radio_button_off_rounded,
//                                     size: 31))
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// import 'dart:convert';

// import 'package:e_commers/ui/Views/cart/detailpage.dart';
// import 'package:flutter/material.dart';
// import 'package:dropdown_search/dropdown_search.dart';

// import 'package:e_commers/ui/Views/cart/widgets/kota.dart';

// import 'package:http/http.dart' as http;

// void main() {
//   runApp(const OpsiKirim());
// }

// class OpsiKirim extends StatelessWidget {
//   const OpsiKirim({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Cek Ongkos Kirim',
//       home: Home(),
//     );
//   }
// }

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   var key = '10cb836f3ab0ef52cad5298b57367723';
//   var kota_asal;
//   var kota_tujuan;
//   var berat;
//   var kurir;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Cek Ongkir"),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             DropdownSearch<Kota>(
//               //kamu bisa mendekorasi tampilan field
//               dropdownSearchDecoration: InputDecoration(
//                 labelText: "Kota Asal",
//                 hintText: "Pilih Kota Asal",
//               ),

//               //tersedia mode menu dan mode dialog
//               mode: Mode.MENU,

//               //jika ingin menampilkan pencarian box
//               showSearchBox: true,

//               //di dalam event kita bisa set state atau menyimpan variabel
//               onChanged: (value) {
//                 kota_asal = value?.cityId;
//               },

//               //kata yang ditampilkan setelah kita memilih
//               itemAsString: (item) => "${item!.type} ${item.cityName}",

//               //mencari data dari api
//               onFind: (text) async {
//                 //mengambil data dari api
//                 var response = await http.get(Uri.parse(
//                     "https://api.rajaongkir.com/starter/city?key=${key}"));

//                 //parse string json as dart string dynamic
//                 //get data just from results
//                 List allKota = (jsonDecode(response.body)
//                     as Map<String, dynamic>)['rajaongkir']['results'];

//                 //simpan data ke dalam model kota
//                 var dataKota = Kota.fromJsonList(allKota);

//                 //return data
//                 return dataKota;
//               },
//             ),
//             SizedBox(height: 20),
//             DropdownSearch<Kota>(
//               //kamu bisa merubah tampilan field sesuai keinginan
//               dropdownSearchDecoration: InputDecoration(
//                 labelText: "Kota Tujuan",
//                 hintText: "Pilih Kota Tujuan",
//               ),

//               //tersedia mode menu dan mode dialog
//               mode: Mode.MENU,

//               //jika kamu ingin menampilkan pencarian
//               showSearchBox: true,

//               //di dalam onchang3e kamu bisa set state
//               onChanged: (value) {
//                 kota_tujuan = value?.cityId;
//               },

//               //kata yang akan ditampilkan setelah dipilih
//               itemAsString: (item) => "${item!.type} ${item.cityName}",

//               //find data from api
//               onFind: (text) async {
//                 //get data from api
//                 var response = await http.get(Uri.parse(
//                     "https://api.rajaongkir.com/starter/city?key=${key}"));

//                 //parse string json as dart string dynamic
//                 //get data just from results

//                 List allKota = (jsonDecode(response.body)
//                     as Map<String, dynamic>)['rajaongkir']['results'];

//                 //store data to model
//                 var dataKota = Kota.fromJsonList(allKota);

//                 //return data
//                 return dataKota;
//               },
//             ),
//             SizedBox(height: 20),
//             TextField(
//               //input hanya angka
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: "Berat Paket (gram)",
//                 hintText: "Input Berat Paket",
//               ),
//               onChanged: (text) {
//                 berat = text;
//               },
//             ),
//             SizedBox(height: 20),
//             DropdownSearch<String>(
//                 mode: Mode.MENU,
//                 showSelectedItems: true,
//                 //pilihan kurir
//                 items: ["jne", "tiki", "pos"],
//                 dropdownSearchDecoration: InputDecoration(
//                   labelText: "Kurir",
//                   hintText: "Kurir",
//                 ),
//                 popupItemDisabled: (String s) => s.startsWith('I'),
//                 onChanged: (text) {
//                   kurir = text;
//                 }),
//             SizedBox(
//               height: 20,
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 //validasi
//                 if (kota_asal == '' ||
//                     kota_tujuan == '' ||
//                     berat == '' ||
//                     kurir == '') {
//                   final snackBar =
//                       SnackBar(content: Text("Isi bidang yang masih kosong!"));
//                   ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                 } else {
//                   //berpindah halaman dan bawa data
//                   Navigator.push(
//                     context,
//                     // DetailPage adalah halaman yang dituju
//                     MaterialPageRoute(
//                         builder: (context) => DetailPage(
//                               kota_asal: kota_asal,
//                               kota_tujuan: kota_tujuan,
//                               berat: berat,
//                               kurir: kurir,
//                             )),
//                   );
//                 }
//               },
//               child: Center(
//                 child: Text("Cek Ongkir"),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
