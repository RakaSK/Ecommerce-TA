import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/Service/pembayaran_services.dart';
import 'package:e_commers/ui/Views/Home/home_page.dart';
import 'package:e_commers/ui/Views/Profile/shopping/order_details_page.dart';
import 'package:flutter/material.dart';
import 'package:e_commers/Models/Response/response_order_buy.dart';
import 'package:e_commers/Service/product_services.dart';
import 'package:e_commers/ui/themes/colors_frave.dart';
import 'package:e_commers/ui/widgets/shimmer_frave.dart';
import 'package:e_commers/ui/widgets/widgets.dart';
import 'package:timeago/timeago.dart' as timeago;

class ShoppingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      return await Navigator.push(context, routeSlide(page: HomePage())) ??
          false;
    }

    return new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
          backgroundColor: Color(0xfff5f5f5),
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const TextFrave(
                text: 'Dibeli',
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 20),
            centerTitle: true,
            elevation: 0,
            leading: InkWell(
              onTap: () =>
                  Navigator.push(context, routeSlide(page: HomePage())),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black)
                ],
              ),
            ),
            // leading: IconButton(
            //   splashRadius: 20,
            //   icon:
            //       const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
            //   onPressed: () => Navigator.pop(context),
            // ),
            actions: [
              TextButton(
                  onPressed: () {
                    modalInfoBank(
                      context,
                      'Transfer pembayaranmu ke No. Rekening di bawah\n\nBNI\nRaka Surya Kusuma\n0836776299',
                      // onPressed: () => Navigator.push(
                      //     context, routeSlide(page: ShoppingPage()))
                      onPressed: () => Navigator.pop(context),
                    );
                  },
                  child: const TextFrave(
                    text: 'Info Bank',
                    color: ColorsFrave.primaryColorFrave,
                    fontSize: 18,
                  ))
            ],
          ),
          body: FutureBuilder<List<OrderBuy>>(
            future: pembayaranServices.getPurchasedProducts(),
            builder: (_, snapshot) {
              return (!snapshot.hasData)
                  ? const ShimmerFrave()
                  : _DetailsProductsBuy(ordersBuy: snapshot.data!);
            },
          ),
        ));
  }
}

class _DetailsProductsBuy extends StatelessWidget {
  final List<OrderBuy> ordersBuy;

  const _DetailsProductsBuy({Key? key, required this.ordersBuy})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      itemCount: ordersBuy.length,
      itemBuilder: (_, i) => InkWell(
        onTap: () => Navigator.push(
            context,
            routeSlide(
                page: OrderDetailsPage(
                    uidOrder: ordersBuy[i].uidOrderBuy.toString()))),
        child: Container(
          height: 180,
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          margin: EdgeInsets.only(bottom: 15.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              // color: Colors.white,
              color: (ordersBuy[i].status == '0')
                  ? Colors.red[100]
                  : Colors.green[100]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFrave(
                  text: ordersBuy[i].receipt,
                  fontSize: 21,
                  color: ColorsFrave.primaryColorFrave,
                  fontWeight: FontWeight.w500),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextFrave(
                      text: 'Nama ', fontSize: 18, color: Colors.grey),
                  TextFrave(text: ordersBuy[i].users, fontSize: 18),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextFrave(
                      text: 'Email ', fontSize: 18, color: Colors.grey),
                  TextFrave(text: ordersBuy[i].email, fontSize: 18),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextFrave(
                      text: 'Tanggal ', fontSize: 18, color: Colors.grey),
                  TextFrave(
                      text: ordersBuy[i].createdAt.day.toString() +
                          "-" +
                          ordersBuy[i].createdAt.month.toString() +
                          "-" +
                          ordersBuy[i].createdAt.year.toString() +
                          " " +
                          ordersBuy[i].createdAt.hour.toString() +
                          ":" +
                          ordersBuy[i].createdAt.minute.toString(),
                      fontSize: 18),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextFrave(
                      text: 'Total harga ', fontSize: 18, color: Colors.grey),
                  TextFrave(
                      text: '\Rp ${ordersBuy[i].amount}',
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
