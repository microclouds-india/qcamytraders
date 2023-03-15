// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qcamytraders/config/colors.dart';
import 'package:qcamytraders/config/image_links.dart';
import 'package:qcamytraders/core/token_storage/storage.dart';
import 'package:http/http.dart' as http;
import 'package:qcamytraders/repository/confirmOrder/model/orderStatusModel.dart';
import 'package:qcamytraders/repository/confirmOrder/model/productViewModel.dart';
import 'package:qcamytraders/widgets/orderitem_wid.dart';

bool isRebuild = false;

class TraderOrders extends StatefulWidget {
  const TraderOrders({Key? key}) : super(key: key);

  @override
  State<TraderOrders> createState() => _TraderOrdersState();
}

class _TraderOrdersState extends State<TraderOrders> {
  bool isloaded = false;
  ViewApllData _allData = ViewApllData();

  OrderStatusModel orderStatusModel = OrderStatusModel();
  getDatas() async {
    LocalStorage localStorage = LocalStorage();
    var url = 'https://cashbes.com/photography/apis/trader_orders';
    var response = await http.post(Uri.parse(url), body: {
      'token': await localStorage.getToken(),
    });

    _allData = ViewApllData.fromJson(jsonDecode(response.body));
    setState(() {
      isloaded = true;
    });
  }

  getStatusData(String id) async {
    var statusUrl = 'https://cashbes.com/photography/apis/trader_delivery_confirm';
    var statusResponde = await http.post(Uri.parse(statusUrl), body: {'id': id});
    orderStatusModel = OrderStatusModel.fromJson(jsonDecode(statusResponde.body));
    return orderStatusModel;
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getDatas();
  }

  @override
  Widget build(BuildContext context) {
    // final ordersData = Provider.of<OrdersNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 1,
        title: Text(
          "Orders",
          style: GoogleFonts.openSans(
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isloaded
          ? ListView.builder(
              itemCount: _allData.data!.length,
              itemBuilder: (context, index) {
                ValueNotifier<String> statusValue =
                    ValueNotifier(_allData.data![index].orderStatus ?? '');

                return ValueListenableBuilder(
                    valueListenable: statusValue,
                    builder:
                        (BuildContext context, String newStats, Widget? child) {
                      return OrderItem(
                        mobileNo: _allData.data![index].phone!,
                        name: _allData.data![index].name!,
                        orderId: _allData.data![index].orderId!,
                        productName: _allData.data![index].name!,
                        img: _allData.data![index].items![0].image ?? noImage,
                        bookingDate: _allData.data![index].date!,
                        date: _allData.data![index].expectedDeliveryDate!,
                        orderNumber: _allData.data![index].orderId!,
                        orderStatus: newStats,
                        onTap: () {
                          // bookingDetailsData.orderId = bookingsData.myBookingsModel.data[index].orderId;
                          // Navigator.of(context).pushNamed("/pastBookingDetailsView");
                          // Navigator.of(context)
                          //     .push(MaterialPageRoute(builder: (context) {
                          //   return TraderProductScreens(
                          //     img: ordersData
                          //         .ordersModel.data[index].items[0].image,
                          //     productName: ordersData
                          //         .ordersModel.data[index].items[0].productName,
                          //     date: ordersData.ordersModel.data[index].date,
                          //     id: ordersData.ordersModel.data[index].orderId,
                          //     name: ordersData.ordersModel.data[index]
                          //         .items[index].productName,
                          //   );
                          // }));
                        },
                      );
                    });
              })
          : Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
    );
  }
}

//show orderd items list

class OrderElement extends StatelessWidget {
  const OrderElement({
    Key? key,
    required this.value,
    required this.title,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              title,
              style: GoogleFonts.quicksand(
                  fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Text(" : "),
        Expanded(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              value,
              style: GoogleFonts.quicksand(
                  fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}

class RentalShopsList extends StatelessWidget {
  final String shopName;
  final String? mobileNumber;
  final String? image;
  final String? location;
  final Function()? onTap;
  final String productName;
  final String bookedOnDate;
  final String orderNumber;
  final String date;
  final String orderStatus;
  const RentalShopsList({
    Key? key,
    required this.shopName,
    required this.mobileNumber,
    this.image,
    this.location,
    this.onTap,
    required this.productName,
    required this.bookedOnDate,
    required this.orderNumber,
    required this.date,
    required this.orderStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            color: primaryColor,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        // padding:
        //     const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  child: SizedBox(
                      width: 120,
                      height: 120,
                      child: CachedNetworkImage(
                        imageUrl: image ??
                            "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg",
                        placeholder: (context, url) {
                          return Image.network(
                              "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg");
                        },
                        fit: BoxFit.fill,
                        errorWidget: (context, url, error) {
                          return Image.network(
                              "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg");
                        },
                      )),
                ),
                const SizedBox(width: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: GoogleFonts.quicksand(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Booked on - $bookedOnDate",
                      style: GoogleFonts.quicksand(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    OrderElement(value: "date", title: "date"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
