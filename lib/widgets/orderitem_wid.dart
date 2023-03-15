import 'package:flutter/material.dart';
import 'package:qcamytraders/common/ui/Ui.dart';
import 'package:qcamytraders/config/colors.dart';
import 'package:qcamytraders/views/home/traderOrders/traderOrders.dart';
import 'package:qcamytraders/views/invoice/invoiceScreen.dart';
import 'package:qcamytraders/widgets/customBtn.dart';
import 'package:qcamytraders/widgets/dropDownBtn.dart';

class OrderItem extends StatefulWidget {
  const OrderItem({
    Key? key,
    required this.orderNumber,
    required this.orderStatus,
    required this.date,
    required this.onTap,
    required this.productName,
    required this.bookingDate,
    required this.img,
    required this.name,
    required this.orderId,
    required this.mobileNo,
    // required this.status,
  }) : super(key: key);

  final String orderNumber;
  final String date;
  final String productName;
  final String bookingDate;
  final String orderStatus;
  final String name;
  final String img;
  final String orderId;
  final String mobileNo;
  // final String status;
  final Function() onTap;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: Ui.getBoxDecoration(color: primaryColor),
        margin:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      OrderElement(title: "Order no", value: widget.orderNumber),
                      SizedBox(height: 5),
                      OrderElement(title: "Name", value: widget.name),
                      SizedBox(height: 5),
                      OrderElement(title: "Mobile No:", value: widget.mobileNo),
                      SizedBox(height: 5),
                      OrderElement(title: "Delivery Status", value: widget.orderStatus),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
                // Row(
                //   children: [
                //     Image(
                //       height: 90,
                //       width: 80,
                //       // ignore: unnecessary_null_comparison
                //       image: NetworkImage(widget.img), fit: BoxFit.cover,
                //     )
                //   ],
                // )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Confirm Order'),
                            actions: <Widget>[
                              Center(
                                child: DropDownBtn(id: widget.orderId),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: btn('Confirm')),
                  GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            return InvoiceScreen(
                                id: widget.orderId,
                                productName: widget.productName);
                          })),
                      child: btn('Invoice'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
