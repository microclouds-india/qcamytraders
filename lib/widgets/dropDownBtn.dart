import 'package:flutter/material.dart';
import 'package:qcamytraders/common/ui/Ui.dart';
import '../../config/colors.dart';
import 'package:http/http.dart' as http;
// ignore: must_be_immutable
class DropDownBtn extends StatefulWidget {
  String id;
  DropDownBtn({required this.id});

  @override
  State<DropDownBtn> createState() => _DropDownBtnState();
}

const List<String> list = <String>[
  'ordered',
  'processing',
  'shipped',
  'delivered',
  'cancelled',
];

String dropdownValue = list.first;

class _DropDownBtnState extends State<DropDownBtn> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(8),
        padding:
        const EdgeInsets.only(left: 8, right: 8),
        decoration: Ui.getBoxDecoration(
            color: primaryColor),
        child: DropdownButton(
          value: dropdownValue,
          underline: SizedBox(),
          iconEnabledColor: primaryColor,
          isExpanded: true,
          hint: Text(
            "Select Tracking Status",
            style:
            const TextStyle(color: Colors.black),
          ),
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          style: const TextStyle(
            color: Colors.black,
          ),
          onChanged: (value) async {

            dropdownValue = value!;

            var confirmUrl = 'https://cashbes.com/photography/apis/trader_delivery_confirm';
            var responde = await http.post(Uri.parse(confirmUrl),
                body: {'id': widget.id, 'status': value});
            Navigator.of(context).pop();
            if (responde.statusCode == 200) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Delivery status changed!"),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
