// import 'package:date_format/date_format.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:qcamytraders/common/ui/Ui.dart';
// import 'package:qcamytraders/config/colors.dart';
// import 'package:qcamytraders/repository/products/notifier/products.notifier.dart';
// import 'package:qcamytraders/repository/saleReport/notifier/saleReport.notifier.dart';
// import 'package:qcamytraders/views/invoice/invoiceScreen.dart';
//
//
// class SaleReport extends StatefulWidget {
//   SaleReport({Key? key}) : super(key: key);
//
//   @override
//   State<SaleReport> createState() => _SaleReportState();
// }
//
// class _SaleReportState extends State<SaleReport> {
//
//   @override
//   Widget build(BuildContext context) {
//
//     final saleReportsData = Provider.of<SaleReportNotifier>(context, listen: false);
//     final productsData = Provider.of<ProductsNotifier>(context, listen: false);
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: primaryColor,
//         elevation: 1,
//         title: Text(
//           "Sales Report",
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back_ios_new_sharp,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Consumer<SaleReportNotifier>(builder: (context, data, _) {
//               return Row(
//                 children: [
//                   Expanded(
//                     child: GestureDetector(
//                       onTap: () {
//                         saleReportsData.daily = true;
//                         saleReportsData.monthly = false;
//                         saleReportsData.yearly = false;
//                         saleReportsData.notifyListeners();
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: saleReportsData.daily == true ? primaryColor : Colors.grey.shade300,
//                         ),
//                         padding: EdgeInsets.all(10.0),
//                         margin: EdgeInsets.only(left: 10.0, top: 10.0),
//                         child: Align(
//                           alignment: AlignmentDirectional.centerStart,
//                           child: Center(
//                             child: Text("Daily",
//                               style: GoogleFonts.quicksand(
//                                   color: saleReportsData.daily == true ? Colors.white : Colors.black,
//                                   fontSize: 14, fontWeight: FontWeight.w600),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: GestureDetector(
//                       onTap: () {
//
//                         saleReportsData.daily = false;
//                         saleReportsData.monthly = true;
//                         saleReportsData.yearly = false;
//                         saleReportsData.notifyListeners();
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: saleReportsData.monthly == true ? primaryColor : Colors.grey.shade300,
//                         ),
//                         padding: EdgeInsets.all(10.0),
//                         margin: EdgeInsets.only(left: 1.0, top: 10.0),
//                         child: Align(
//                           alignment: AlignmentDirectional.centerStart,
//                           child: Center(
//                             child: Text("Monthly",
//                               style: GoogleFonts.quicksand(
//                                   color: saleReportsData.monthly == true ? Colors.white : Colors.black,
//                                   fontSize: 14, fontWeight: FontWeight.w600),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: GestureDetector(
//                       onTap: () {
//                         saleReportsData.daily = false;
//                         saleReportsData.monthly = false;
//                         saleReportsData.yearly = true;
//                         saleReportsData.notifyListeners();
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: saleReportsData.yearly == true ? primaryColor : Colors.grey.shade300,
//                         ),
//                         padding: EdgeInsets.all(10.0),
//                         margin: EdgeInsets.only(left: 1.0, right: 10.0, top: 10.0),
//                         child: Align(
//                           alignment: AlignmentDirectional.centerStart,
//                           child: Center(
//                             child: Text("Yearly",
//                               style: GoogleFonts.quicksand(
//                                 color: saleReportsData.yearly == true ? Colors.white : Colors.black,
//                                   fontSize: 14, fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             }),
//             Container(
//               margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Select Product',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 15,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             FutureBuilder(
//               future: productsData.getProducts(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return productsData.productsModel.data.isNotEmpty
//                       ? Consumer<ProductsNotifier>(builder: (context, data, _) {
//                         return Align(
//                           alignment: Alignment.centerLeft,
//                           child: Container(
//                             width: double.infinity,
//                             margin: const EdgeInsets.all(8),
//                             padding:
//                             const EdgeInsets.only(left: 8, right: 8),
//                             decoration: Ui.getBoxDecoration(
//                                 color: primaryColor),
//                             child: DropdownButton(
//                               value: productsData.productName,
//                               underline: SizedBox(),
//                               iconEnabledColor: primaryColor,
//                               isExpanded: true,
//                               hint: Text(
//                                 "Select Product",
//                                 style:
//                                 const TextStyle(color: Colors.black),
//                               ),
//                               items: productsData.productsModel.data.map((map) => DropdownMenuItem(
//                                   value: map.id,
//                                   child: Text(
//                                     map.productName,
//                                     style: const TextStyle(
//                                         color: Colors.black),
//                                   ),
//                                 ),
//                               ).toList(),
//                               style: const TextStyle(
//                                 color: Colors.black,
//                               ),
//                               onChanged: (value) {
//                                 productsData.productName = value.toString();
//                                 saleReportsData.search = false;
//                                 productsData.notifyListeners();
//                                 saleReportsData.notifyListeners();
//                               },
//                             ),
//                           ),
//                         );
//                       }) : const Center(child: Text("No items"));
//                 } else {
//                   return Container(
//                     margin: EdgeInsets.all(10),
//                     child: const CircularProgressIndicator(
//                       color: primaryColor,
//                     ),
//                   );
//                 }
//               },
//             ),
//             Consumer<SaleReportNotifier>(builder: (context, data, _) {
//               return saleReportsData.monthly == true ? Container(
//                 margin: EdgeInsets.all(20.0),
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Month',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ) : Container();
//             }),
//             Consumer<SaleReportNotifier>(builder: (context, data, _) {
//               return saleReportsData.monthly == true ? GestureDetector(
//                 onTap: () async {
//                   saleReportsData.month = await saleReportsData.selectMonth(context, saleReportsData.month);
//                 },
//                 child: Container(
//                   decoration: Ui.getBoxDecoration(color: primaryColor),
//                   margin: EdgeInsets.only(left: 10.0, right: 10.0),
//                   padding: EdgeInsets.all(20.0),
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     '${formatDate(saleReportsData.month, [MM])}',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 13,
//                     ),
//                   ),
//                 ),
//               ) : Container();
//             }),
//             Consumer<SaleReportNotifier>(builder: (context, data, _) {
//               return saleReportsData.yearly == true ? Container(
//                 margin: EdgeInsets.all(20.0),
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Year',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ) : Container();
//             }),
//             Consumer<SaleReportNotifier>(builder: (context, data, _) {
//               return saleReportsData.yearly == true ? GestureDetector(
//                 onTap: () async {
//                   await saleReportsData.selectYear(context);
//                 },
//                 child: Container(
//                   decoration: Ui.getBoxDecoration(color: primaryColor),
//                   margin: EdgeInsets.only(left: 10.0, right: 10.0),
//                   padding: EdgeInsets.all(20.0),
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     '${formatDate(saleReportsData.year, [yyyy])}',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 13,
//                     ),
//                   ),
//                 ),
//               ) : Container();
//             }),
//             Consumer<SaleReportNotifier>(builder: (context, data, _) {
//               return saleReportsData.daily == true ? Container(
//                 margin: EdgeInsets.all(20.0),
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'From Date',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ) : Container();
//             }),
//             Consumer<SaleReportNotifier>(builder: (context, data, _) {
//               return saleReportsData.daily == true ? GestureDetector(
//                 onTap: () async {
//                   saleReportsData.fromDate = await saleReportsData.selectDate(context, saleReportsData.fromDate);
//                 },
//                 child: Container(
//                   decoration: Ui.getBoxDecoration(color: primaryColor),
//                   margin: EdgeInsets.only(left: 10.0, right: 10.0),
//                   padding: EdgeInsets.all(20.0),
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     '${saleReportsData.formatter.format(saleReportsData.fromDate)}',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 13,
//                     ),
//                   ),
//                 ),
//               ) : Container();
//             }),
//             Consumer<SaleReportNotifier>(builder: (context, data, _) {
//               return saleReportsData.daily == true ? Container(
//                 margin: EdgeInsets.all(20.0),
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'To Date',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ) : Container();
//             }),
//             Consumer<SaleReportNotifier>(builder: (context, data, _) {
//               return saleReportsData.daily == true ? GestureDetector(
//                 onTap: () async {
//                   saleReportsData.toDate = await saleReportsData.selectDate(context, saleReportsData.toDate);
//                 },
//                 child: Container(
//                   decoration: Ui.getBoxDecoration(color: primaryColor),
//                   margin: EdgeInsets.only(left: 10.0, right: 10.0),
//                   padding: EdgeInsets.all(20.0),
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     '${saleReportsData.formatter.format(saleReportsData.toDate)}',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 13,
//                     ),
//                   ),
//                 ),
//               ) : Container();
//             }),
//             GestureDetector(
//               child: Container(
//                 margin: EdgeInsets.all(20.0),
//                 decoration: BoxDecoration(
//                     color: primaryColor,
//                     borderRadius: BorderRadius.all(Radius.circular(10))),
//                 height: 40,
//                 width: 150,
//                 child: Center(
//                   child: Text("Search",
//                     style: GoogleFonts.openSans(
//                         color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ),
//               onTap: () {
//                   if(saleReportsData.daily != true && saleReportsData.monthly != true && saleReportsData.yearly != true){
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       behavior: SnackBarBehavior.floating,
//                       backgroundColor: Colors.red,
//                       content: Text("Please select day, month or year."),
//                     ),
//                   );
//                 }else if(productsData.productName == null){
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         behavior: SnackBarBehavior.floating,
//                         backgroundColor: Colors.red,
//                         content: Text("Please select product."),
//                       ),
//                     );
//                 }else{
//                   saleReportsData.search = true;
//                   saleReportsData.notifyListeners();
//                 }
//               },
//             ),
//             Consumer<SaleReportNotifier>(builder: (context, data, _) {
//               return saleReportsData.search == true ? FutureBuilder(
//                   future: saleReportsData.getSaleReport(
//                       fromdate: saleReportsData.daily == true ? saleReportsData.fromDate.toString() : "",
//                       todate: saleReportsData.daily == true ? saleReportsData.toDate.toString() : "",
//                       month: saleReportsData.monthly == true ? formatDate(saleReportsData.month, [MM]) : "",
//                       year: saleReportsData.yearly == true ? formatDate(saleReportsData.year, [yyyy]) : "",
//                       product_id: productsData.productName),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       saleReportsData.search = false;
//                       if (saleReportsData.salereportModel.data.isEmpty) {
//                         return Center(
//                           child: Text("No items"),
//                         );
//                       } else {
//                         return SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Row(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
//                                 child: Text("Grand Total",
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 14),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 10.0),
//                                 child: Text(" : "+saleReportsData.salereportModel.grandtotal,
//                                   style: TextStyle(
//                                       color: Colors.blue.shade700,
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 14),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
//                                 child: Text("CGST",
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 14),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 10.0),
//                                 child: Text(" : "+saleReportsData.salereportModel.cgst.toString(),
//                                   style: TextStyle(
//                                       color: Colors.blue.shade700,
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 14),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
//                                 child: Text("SGST",
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 14),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 10.0),
//                                 child: Text(" : "+saleReportsData.salereportModel.sgst.toString(),
//                                   style: TextStyle(
//                                       color: Colors.blue.shade700,
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 14),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
//                                 child: Text("Total Tax",
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 14),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 10.0),
//                                 child: Text(" : "+saleReportsData.salereportModel.tax_total,
//                                   style: TextStyle(
//                                       color: Colors.blue.shade700,
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 14),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       }
//                     } else if (snapshot.hasError) {
//                       return Center(child: Text("No Data Found"));
//                     }
//                     return Center(
//                       child: Container(),
//                     );
//                   }) : Container();
//             }),
//             Consumer<SaleReportNotifier>(builder: (context, data, _) {
//               return saleReportsData.search == true ? FutureBuilder(
//                   future: saleReportsData.getSaleReport(
//                       fromdate: saleReportsData.daily == true ? saleReportsData.fromDate.toString() : "",
//                       todate: saleReportsData.daily == true ? saleReportsData.toDate.toString() : "",
//                       month: saleReportsData.monthly == true ? formatDate(saleReportsData.month, [MM]) : "",
//                       year: saleReportsData.yearly == true ? formatDate(saleReportsData.year, [yyyy]) : "",
//                       product_id: productsData.productName),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       saleReportsData.search = false;
//                       if (saleReportsData.salereportModel.data.isEmpty) {
//                         return Center(
//                           child: Text("No items"),
//                         );
//                       } else {
//                         return ListView.builder(
//                           shrinkWrap: true,
//                           physics: NeverScrollableScrollPhysics(),
//                           itemCount: saleReportsData.salereportModel.data.length,
//                           itemBuilder: (context, index) {
//                             return Container(
//                               margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 20.0),
//                               decoration: Ui.getBoxDecoration(color: primaryColor),
//                               child: Column(
//                                 children: [
//                                   SizedBox(height: 10),
//                                   OrderElement(title: "Date", value: saleReportsData.salereportModel.data[index]!.tdate,id: ""),
//                                   SizedBox(height: 5),
//                                   OrderElement(title: "Name", value: saleReportsData.salereportModel.data[index]!.userId,id: ""),
//                                   SizedBox(height: 5),
//                                   OrderElement(title: "No of items", value: saleReportsData.salereportModel.data[index]!.noProducts,id: ""),
//                                   SizedBox(height: 5),
//                                   OrderElement(title: "Product Price", value: saleReportsData.salereportModel.data[index]!.totalProductPrice,id: ""),
//                                   SizedBox(height: 5),
//                                   OrderElement(title: "Discount", value: saleReportsData.salereportModel.data[index]!.totalDisc,id: ""),
//                                   // SizedBox(height: 5),
//                                   // OrderElement(title: "Sub Total", value: saleReportsData.salereportModel.data[index].subTotal,id: ""),
//                                   SizedBox(height: 5),
//                                   OrderElement(title: "Status", value: saleReportsData.salereportModel.data[index]!.orderStatus,id: ""),
//                                   SizedBox(height: 5),
//                                   OrderElement(title: "Actions", value: "invoice", id: saleReportsData.salereportModel.data[index]!.id),
//                                   SizedBox(height: 10),
//                                   SizedBox(height: 1, width: double.infinity, child: Container(color: Colors.grey),),
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
//                                           child: Text("Total Amount",
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontWeight: FontWeight.w600,
//                                                 fontSize: 14),
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(top: 10.0),
//                                           child: Text(" : "+saleReportsData.salereportModel.data[index]!.totalProductPrice,
//                                             style: TextStyle(
//                                                 color: Colors.blue.shade700,
//                                                 fontWeight: FontWeight.w600,
//                                                 fontSize: 14),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: 10),
//                                   SizedBox(height: 1, width: double.infinity, child: Container(color: Colors.grey),),
//                                   Consumer<SaleReportNotifier>(builder: (context, data, _) {
//                                     return data.isLoading ? Padding(
//                                       padding: const EdgeInsets.all(20.0),
//                                       child: Center(
//                                         child: CircularProgressIndicator(color: primaryColor,),
//                                       ),
//                                     ) : GestureDetector(
//                                       child: Center(
//                                         child: Container(
//                                           margin: const EdgeInsets.all(10.0),
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(10.0),
//                                             color: primaryColor,),
//                                           height: 35,
//                                           width: 150,
//                                           child: Center(
//                                             child: Text("Download PDF",
//                                               style: GoogleFonts.openSans(
//                                                   color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
//                                               overflow: TextOverflow.ellipsis,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       onTap: () {
//                                         // Navigator.of(context).pushNamed("/pdfDownload");
//                                         saleReportsData.downloadFile(pdfUrl: "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf");
//                                         ScaffoldMessenger.of(context).showSnackBar(
//                                           SnackBar(
//                                             behavior: SnackBarBehavior.floating,
//                                             backgroundColor: primaryColor,
//                                             content: Text("File will download in your downloads folder. please check"),
//                                           ),
//                                         );
//                                       },
//                                     );
//                                   }),
//                                 ],
//                               ),
//                             );
//                           },
//                         );
//                       }
//                     } else if (snapshot.hasError) {
//                       return Center(child: Text("No Data Found"));
//                     }else{
//                       return Center(
//                         child: CircularProgressIndicator(color: primaryColor),
//                       );
//                     }
//                   }) : Container();
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class OrderElement extends StatelessWidget {
//   const OrderElement({
//     Key? key,
//     required this.value,
//     required this.title,
//     required this.id,
//     // required this.date,
//     // required this.name,
//     // required this.noOfItems,
//     // required this.price,
//     // required this.discount,
//     // required this.subTotal,
//     // required this.status,
//   }) : super(key: key);
//
//   final String title;
//   final String id;
//   // final String date;
//   // final String name;
//   // final String noOfItems;
//   // final String price;
//   // final String discount;
//   // final String subTotal;
//   // final String status;
//   final String value;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Align(
//                   alignment: AlignmentDirectional.centerStart,
//                   child: Text(
//                     title,
//                     style: GoogleFonts.quicksand(
//                         fontSize: 14, fontWeight: FontWeight.w600),
//                   ),
//                 ),
//               ),
//               Text(" : "),
//               Expanded(
//                 child: Align(
//                   alignment: AlignmentDirectional.centerStart,
//                   child: value == "invoice" ? GestureDetector(
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: Colors.grey,),
//                       height: 25,
//                       width: 100,
//                       child: Center(
//                         child: Text("Invoice",
//                           style: GoogleFonts.openSans(
//                               color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ),
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//                         return InvoiceScreen(
//                             id: id,
//                             productName: "");
//                       }));
//                     },
//                   ) : Text(
//                     value,
//                     style: GoogleFonts.quicksand(
//                         fontSize: 14, fontWeight: FontWeight.w500),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }




import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamytraders/common/ui/Ui.dart';
import 'package:qcamytraders/config/colors.dart';
import 'package:qcamytraders/pdf/api/pdf_api.dart';
import 'package:qcamytraders/pdf/api/pdf_invoice_api.dart';
import 'package:qcamytraders/pdf/model/customer.dart';
import 'package:qcamytraders/pdf/model/invoice.dart';
import 'package:qcamytraders/pdf/model/supplier.dart';
import 'package:qcamytraders/repository/products/notifier/products.notifier.dart';
import 'package:qcamytraders/repository/saleReport/notifier/saleReport.notifier.dart';
import 'package:qcamytraders/views/invoice/invoiceScreen.dart';


class SaleReport extends StatefulWidget {
  SaleReport({Key? key}) : super(key: key);

  @override
  State<SaleReport> createState() => _SaleReportState();
}

class _SaleReportState extends State<SaleReport> {

  @override
  Widget build(BuildContext context) {

    final saleReportsData = Provider.of<SaleReportNotifier>(context, listen: false);
    final productsData = Provider.of<ProductsNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 1,
        title: Text(
          "Sales Report",
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      bottomNavigationBar: GestureDetector(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: primaryColor,),
          height: kBottomNavigationBarHeight - 5,
          width: 150,
          child: Center(
            child: Text("Download PDF",
              style: GoogleFonts.openSans(
                  color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        onTap: () async {
          // Navigator.of(context).pushNamed("/pdfDownload");
          // saleReportsData.downloadFile(pdfUrl: "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf");
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     behavior: SnackBarBehavior.floating,
          //     backgroundColor: primaryColor,
          //     content: Text("File will download in your downloads folder. please check"),
          //   ),
          // );
          final date = DateTime.now();
          final dueDate = date.add(Duration(days: 7));

          final invoice = Invoice(
            supplier: Supplier(
              name: 'Name',
              address: 'Address',
              paymentInfo: '',
            ),
            customer: Customer(
              name: 'Customer Name',
              address: 'Customer Address',
            ),
            info: InvoiceInfo(
              date: date,
              dueDate: dueDate,
              description: 'Description...',
              number: '${DateTime.now().year}-9999',
            ),
            items: [
              for(int i = 0; i<saleReportsData.salereportModel.data.length; i++)
                InvoiceItem(
                  date: saleReportsData.salereportModel.data[i]!.tdate,
                  noOfItems: saleReportsData.salereportModel.data[i]!.noProducts,
                  product: saleReportsData.salereportModel.data[i]!.totalProductPrice,
                  discount: saleReportsData.salereportModel.data[i]!.totalDisc,
                  subTotal: saleReportsData.salereportModel.data[i]!.subTotal,
                  status: saleReportsData.salereportModel.data[i]!.orderStatus,
                ),
            ],
          );

          final pdfFile = await PdfInvoiceApi.generate(invoice);
          PdfApi.saveInStorage(pdfFile);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: primaryColor,
              content: Text("File will download in your downloads folder. please check"),
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Consumer<SaleReportNotifier>(builder: (context, data, _) {
            //   return Row(
            //     children: [
            //       Expanded(
            //         child: GestureDetector(
            //           onTap: () {
            //             saleReportsData.daily = true;
            //             saleReportsData.monthly = false;
            //             saleReportsData.yearly = false;
            //             saleReportsData.notifyListeners();
            //           },
            //           child: Container(
            //             decoration: BoxDecoration(
            //               color: saleReportsData.daily == true ? primaryColor : Colors.grey.shade300,
            //             ),
            //             padding: EdgeInsets.all(10.0),
            //             margin: EdgeInsets.only(left: 10.0, top: 10.0),
            //             child: Align(
            //               alignment: AlignmentDirectional.centerStart,
            //               child: Center(
            //                 child: Text("Daily",
            //                   style: GoogleFonts.quicksand(
            //                       color: saleReportsData.daily == true ? Colors.white : Colors.black,
            //                       fontSize: 14, fontWeight: FontWeight.w600),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         child: GestureDetector(
            //           onTap: () {
            //
            //             saleReportsData.daily = false;
            //             saleReportsData.monthly = true;
            //             saleReportsData.yearly = false;
            //             saleReportsData.notifyListeners();
            //           },
            //           child: Container(
            //             decoration: BoxDecoration(
            //               color: saleReportsData.monthly == true ? primaryColor : Colors.grey.shade300,
            //             ),
            //             padding: EdgeInsets.all(10.0),
            //             margin: EdgeInsets.only(left: 1.0, top: 10.0),
            //             child: Align(
            //               alignment: AlignmentDirectional.centerStart,
            //               child: Center(
            //                 child: Text("Monthly",
            //                   style: GoogleFonts.quicksand(
            //                       color: saleReportsData.monthly == true ? Colors.white : Colors.black,
            //                       fontSize: 14, fontWeight: FontWeight.w600),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         child: GestureDetector(
            //           onTap: () {
            //             saleReportsData.daily = false;
            //             saleReportsData.monthly = false;
            //             saleReportsData.yearly = true;
            //             saleReportsData.notifyListeners();
            //           },
            //           child: Container(
            //             decoration: BoxDecoration(
            //               color: saleReportsData.yearly == true ? primaryColor : Colors.grey.shade300,
            //             ),
            //             padding: EdgeInsets.all(10.0),
            //             margin: EdgeInsets.only(left: 1.0, right: 10.0, top: 10.0),
            //             child: Align(
            //               alignment: AlignmentDirectional.centerStart,
            //               child: Center(
            //                 child: Text("Yearly",
            //                   style: GoogleFonts.quicksand(
            //                       color: saleReportsData.yearly == true ? Colors.white : Colors.black,
            //                       fontSize: 14, fontWeight: FontWeight.w500),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   );
            // }),
            // Container(
            //   margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
            //   alignment: Alignment.centerLeft,
            //   child: Text(
            //     'Select Product',
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 15,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            // FutureBuilder(
            //   future: productsData.getProducts(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       return productsData.productsModel.data.isNotEmpty
            //           ? Consumer<ProductsNotifier>(builder: (context, data, _) {
            //         return Align(
            //           alignment: Alignment.centerLeft,
            //           child: Container(
            //             width: double.infinity,
            //             margin: const EdgeInsets.all(8),
            //             padding:
            //             const EdgeInsets.only(left: 8, right: 8),
            //             decoration: Ui.getBoxDecoration(
            //                 color: primaryColor),
            //             child: DropdownButton(
            //               value: productsData.productName,
            //               underline: SizedBox(),
            //               iconEnabledColor: primaryColor,
            //               isExpanded: true,
            //               hint: Text(
            //                 "Select Product",
            //                 style:
            //                 const TextStyle(color: Colors.black),
            //               ),
            //               items: productsData.productsModel.data.map((map) => DropdownMenuItem(
            //                 value: map.id,
            //                 child: Text(
            //                   map.productName,
            //                   style: const TextStyle(
            //                       color: Colors.black),
            //                 ),
            //               ),
            //               ).toList(),
            //               style: const TextStyle(
            //                 color: Colors.black,
            //               ),
            //               onChanged: (value) {
            //                 productsData.productName = value.toString();
            //                 saleReportsData.search = false;
            //                 productsData.notifyListeners();
            //                 saleReportsData.notifyListeners();
            //               },
            //             ),
            //           ),
            //         );
            //       }) : const Center(child: Text("No items"));
            //     } else {
            //       return Container(
            //         margin: EdgeInsets.all(10),
            //         child: const CircularProgressIndicator(
            //           color: primaryColor,
            //         ),
            //       );
            //     }
            //   },
            // ),
            Consumer<SaleReportNotifier>(builder: (context, data, _) {
              return saleReportsData.monthly == true ? Container(
                margin: EdgeInsets.all(20.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Month',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ) : Container();
            }),
            Consumer<SaleReportNotifier>(builder: (context, data, _) {
              return saleReportsData.monthly == true ? GestureDetector(
                onTap: () async {
                  saleReportsData.month = await saleReportsData.selectMonth(context, saleReportsData.month);
                },
                child: Container(
                  decoration: Ui.getBoxDecoration(color: primaryColor),
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  padding: EdgeInsets.all(20.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${formatDate(saleReportsData.month, [MM])}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                ),
              ) : Container();
            }),
            Consumer<SaleReportNotifier>(builder: (context, data, _) {
              return saleReportsData.yearly == true ? Container(
                margin: EdgeInsets.all(20.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Year',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ) : Container();
            }),
            Consumer<SaleReportNotifier>(builder: (context, data, _) {
              return saleReportsData.yearly == true ? GestureDetector(
                onTap: () async {
                  await saleReportsData.selectYear(context);
                },
                child: Container(
                  decoration: Ui.getBoxDecoration(color: primaryColor),
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  padding: EdgeInsets.all(20.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${formatDate(saleReportsData.year, [yyyy])}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                ),
              ) : Container();
            }),
            Consumer<SaleReportNotifier>(builder: (context, data, _) {
              return saleReportsData.daily == true ? Container(
                margin: EdgeInsets.all(20.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'From Date',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ) : Container();
            }),
            Consumer<SaleReportNotifier>(builder: (context, data, _) {
              return saleReportsData.daily == true ? GestureDetector(
                onTap: () async {
                  saleReportsData.fromDate = await saleReportsData.selectDate(context, saleReportsData.fromDate);
                },
                child: Container(
                  decoration: Ui.getBoxDecoration(color: primaryColor),
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  padding: EdgeInsets.all(20.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${saleReportsData.formatter.format(saleReportsData.fromDate)}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                ),
              ) : Container();
            }),
            Consumer<SaleReportNotifier>(builder: (context, data, _) {
              return saleReportsData.daily == true ? Container(
                margin: EdgeInsets.all(20.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'To Date',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ) : Container();
            }),
            Consumer<SaleReportNotifier>(builder: (context, data, _) {
              return saleReportsData.daily == true ? GestureDetector(
                onTap: () async {
                  saleReportsData.toDate = await saleReportsData.selectDate(context, saleReportsData.toDate);
                },
                child: Container(
                  decoration: Ui.getBoxDecoration(color: primaryColor),
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  padding: EdgeInsets.all(20.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${saleReportsData.formatter.format(saleReportsData.toDate)}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                ),
              ) : Container();
            }),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: 40,
                width: 150,
                child: Center(
                  child: Text("Search",
                    style: GoogleFonts.openSans(
                        color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              onTap: () {
                if(saleReportsData.daily != true && saleReportsData.monthly != true && saleReportsData.yearly != true){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      content: Text("Please select day, month or year."),
                    ),
                  );
                }
                // else if(productsData.productName == null){
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       behavior: SnackBarBehavior.floating,
                //       backgroundColor: Colors.red,
                //       content: Text("Please select product."),
                //     ),
                //   );
                // }
                else{
                  saleReportsData.search = true;
                  saleReportsData.notifyListeners();
                }
              },
            ),
            Consumer<SaleReportNotifier>(builder: (context, data, _) {
              return saleReportsData.search == true ? FutureBuilder(
                  future: saleReportsData.getSaleReport(
                      fromdate: saleReportsData.daily == true ? saleReportsData.fromDate.toString() : "",
                      todate: saleReportsData.daily == true ? saleReportsData.toDate.toString() : "",
                      month: saleReportsData.monthly == true ? formatDate(saleReportsData.month, [MM]) : "",
                      year: saleReportsData.yearly == true ? formatDate(saleReportsData.year, [yyyy]) : "",
                      // product_id: productsData.productName,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      saleReportsData.search = false;
                      if (saleReportsData.salereportModel.data.isEmpty) {
                        return Center(
                          child: Text("No items"),
                        );
                      } else {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                                child: Text("Grand Total",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(" : "+saleReportsData.salereportModel.grandtotal,
                                  style: TextStyle(
                                      color: Colors.blue.shade700,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                                child: Text("CGST",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(" : "+saleReportsData.salereportModel.cgst.toString(),
                                  style: TextStyle(
                                      color: Colors.blue.shade700,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                                child: Text("SGST",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(" : "+saleReportsData.salereportModel.sgst.toString(),
                                  style: TextStyle(
                                      color: Colors.blue.shade700,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                                child: Text("Total Tax",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(" : "+saleReportsData.salereportModel.tax_total,
                                  style: TextStyle(
                                      color: Colors.blue.shade700,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Center(child: Text("No Data Found"));
                    }
                    return Center(
                      child: Container(),
                    );
                  }) : Container();
            }),
            Consumer<SaleReportNotifier>(builder: (context, data, _) {
              return saleReportsData.search == true ? FutureBuilder(
                  future: saleReportsData.getSaleReport(
                      fromdate: saleReportsData.daily == true ? saleReportsData.fromDate.toString() : "",
                      todate: saleReportsData.daily == true ? saleReportsData.toDate.toString() : "",
                      month: saleReportsData.monthly == true ? formatDate(saleReportsData.month, [MM]) : "",
                      year: saleReportsData.yearly == true ? formatDate(saleReportsData.year, [yyyy]) : "",
                      // product_id: productsData.productName
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      saleReportsData.search = false;
                      if (saleReportsData.salereportModel.data.isEmpty) {
                        return Center(
                          child: Text("No items"),
                        );
                      } else {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10.0, left: 10.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text("DATE",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                    width: 100,
                                    height: 30,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10.0, left: 10.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text("NO OF ITEMS",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                    width: 100,
                                    height: 30,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10.0, left: 10.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text("PRODUCT PRICE",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                    width: 100,
                                    height: 30,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10.0, left: 10.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text("DISCOUNT",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                    width: 100,
                                    height: 30,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10.0, left: 10.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text("SUB TOTAL",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                    width: 100,
                                    height: 30,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10.0, left: 10.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text("STATUS",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                    width: 100,
                                    height: 30,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10.0, left: 10.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text("ACTIONS",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                    width: 100,
                                    height: 30,
                                  ),
                                ],
                              ),
                              // Container(
                              //   margin: EdgeInsets.only(left: 20.0, right: 20.0),
                              //   width: MediaQuery.of(context).size.width,
                              //   color: Colors.grey,
                              //   height: 1,
                              // ),
                              Container(
                                height: 300,
                                margin: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0, top: 10.0),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: saleReportsData.salereportModel.data.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text("${saleReportsData.salereportModel.data[index]?.tdate}",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ),
                                          width: 100,
                                          height: 30,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10.0),
                                          width: 100,
                                          height: 30,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text("${saleReportsData.salereportModel.data[index]?.noProducts}",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10.0),
                                          width: 100,
                                          height: 30,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text("${saleReportsData.salereportModel.data[index]?.totalProductPrice}",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10.0),
                                          width: 100,
                                          height: 30,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text("${saleReportsData.salereportModel.data[index]?.totalDisc}",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10.0),
                                          width: 100,
                                          height: 30,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text("${saleReportsData.salereportModel.data[index]?.subTotal}",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10.0),
                                          width: 100,
                                          height: 35,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text("${saleReportsData.salereportModel.data[index]?.orderStatus}",
                                              style: TextStyle(
                                                color: Colors.blue.shade700,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey,),
                                            height: 25,
                                            width: 100,
                                            child: Center(
                                              child: Text("Invoice",
                                                style: GoogleFonts.openSans(
                                                    color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
                                          ),
                                          onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                              return InvoiceScreen(
                                                  id: saleReportsData.salereportModel.data[index]!.id,
                                                  productName: "");
                                            }));
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              // Container(
                              //   margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                              //   width: MediaQuery.of(context).size.width,
                              //   color: Colors.grey,
                              //   height: 1,
                              // ),
                            ],
                          ),
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Center(child: Text("No Data Found"));
                    }else{
                      return Center(
                        child: CircularProgressIndicator(color: primaryColor),
                      );
                    }
                  }) : Container();
            }),
          ],
        ),
      ),
    );
  }
}

class OrderElement extends StatelessWidget {
  const OrderElement({
    Key? key,
    required this.value,
    required this.title,
    required this.id,
    // required this.date,
    // required this.name,
    // required this.noOfItems,
    // required this.price,
    // required this.discount,
    // required this.subTotal,
    // required this.status,
  }) : super(key: key);

  final String title;
  final String id;
  // final String date;
  // final String name;
  // final String noOfItems;
  // final String price;
  // final String discount;
  // final String subTotal;
  // final String status;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
      child: Row(
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
              child: value == "invoice" ? GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,),
                  height: 25,
                  width: 100,
                  child: Center(
                    child: Text("Invoice",
                      style: GoogleFonts.openSans(
                          color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return InvoiceScreen(
                        id: id,
                        productName: "");
                  }));
                },
              ) : Text(
                value,
                style: GoogleFonts.quicksand(
                    fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
