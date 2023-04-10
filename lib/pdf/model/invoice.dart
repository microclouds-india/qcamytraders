
import 'package:qcamytraders/pdf/model/customer.dart';
import 'package:qcamytraders/pdf/model/supplier.dart';

class Invoice {
  final InvoiceInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<InvoiceItem> items;

  const Invoice({
    required this.info,
    required this.supplier,
    required this.customer,
    required this.items,
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final String date;
  // final DateTime date;
  // final double date;
  final DateTime dueDate;

  const InvoiceInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
  });
}

class InvoiceItem {
  // final DateTime date;
  final String date;
  final String noOfItems;
  final String product;
  final String discount;
  final String subTotal;
  final String status;

  const InvoiceItem({
    required this.date,
    required this.noOfItems,
    required this.product,
    required this.discount,
    required this.subTotal,
    required this.status,
  });
}
