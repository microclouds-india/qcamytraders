import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:qcamytraders/config/colors.dart';
import 'package:http/http.dart' as http;
import 'package:qcamytraders/config/routes.dart';
import 'package:qcamytraders/repository/invoice/model/invoice_model.dart';

// ignore: must_be_immutable
class InvoiceScreen extends StatefulWidget {
  String id;
  String productName;
  InvoiceScreen({required this.id, required this.productName});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  InvoiceProduct _invoiceProduct = InvoiceProduct();
  bool isLoading = false;
  postDatas() async {
    var response = await http.post(Uri.parse("https://cashbes.com/photography/apis/trader_order_invoice"), body: {'order_id': widget.id});
    _invoiceProduct = InvoiceProduct.fromJson(jsonDecode(response.body));
    setState(() {
      isLoading = true;
    });
    return _invoiceProduct;
  }

  @override
  void initState() {
    super.initState();
    postDatas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 1,
          title: Text(
            "Invoice",
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
        body: isLoading
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image(
                                        height: 150,
                                        width: 150,
                                        image: AssetImage(
                                            'assets/images/png/splashscreen_logo.png')),
                                  ],
                                ),

                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Invoice to: ${_invoiceProduct.data![0].name}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        // SizedBox(
                                        //   width: 20,
                                        // ),
                                        Flexible(
                                          child: Text(
                                            '${_invoiceProduct.data![0].address}',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                customTxtHead(
                                    'Invoice#  ${_invoiceProduct.data![0].orderId}'),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: DataTable(columns: [
                                    DataColumn(label: Text('SL')),
                                    DataColumn(label: Text('Product Name')),
                                    DataColumn(label: Text('Price'))
                                  ], rows: [
                                    DataRow(cells: [
                                      DataCell(Text("1")),
                                      DataCell(Text(_invoiceProduct
                                          .data![0].items![0].productName!)),
                                      DataCell(Text(_invoiceProduct
                                          .data![0].items![0].price!))
                                    ])
                                  ]),
                                  color: Colors.grey[200],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                addressTxt('Thank you'),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: customTxtHead("Payment info:"),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                                "${_invoiceProduct.data![0].paymentType}"),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        customTxtHead('Sub Total:    ${_invoiceProduct.data![0].items![0].price}'),
                                        customTxtHead('Cut prize:    ${_invoiceProduct.data![0].items![0].cutPrice}'),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        customTxtHead("Total:    ${_invoiceProduct.data![0].items![0].price}"),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                // Divider(
                                //   color: Colors.black,
                                //   height: 36,
                                //   endIndent: 5,
                                // )
                              ],
                            ),
                          )),
                    )
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              ));
  }
}

Widget customTxtHead(String txt) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        txt,
        style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w600),
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}

Widget addressTxt(String txt) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          txt,
          style:
              GoogleFonts.quicksand(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ),
    ],
  );
}
