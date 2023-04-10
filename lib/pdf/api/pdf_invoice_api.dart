import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:qcamytraders/pdf/api/pdf_api.dart';
import 'package:qcamytraders/pdf/model/customer.dart';
import 'package:qcamytraders/pdf/model/invoice.dart';
import 'package:qcamytraders/pdf/model/supplier.dart';
import 'package:qcamytraders/pdf/utils.dart';

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(invoice),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(invoice),
        buildInvoice(invoice),
        Divider(),
        buildTotal(invoice),
      ],
      footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(name: 'sales_report.pdf', pdf: pdf);
  }

  static Widget buildHeader(Invoice invoice) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildSupplierAddress(invoice.supplier),
              // Container(
              //   height: 50,
              //   width: 50,
              //   child: BarcodeWidget(
              //     barcode: Barcode.qrCode(),
              //     data: invoice.info.number,
              //   ),
              // ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildCustomerAddress(invoice.customer),
              buildInvoiceInfo(invoice.info),
            ],
          ),
        ],
      );

  static Widget buildCustomerAddress(Customer customer) => Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(customer.name, style: TextStyle(fontWeight: FontWeight.bold)),
          // Text(customer.address),
        ],
      );

  static Widget buildInvoiceInfo(InvoiceInfo info) {
    // final paymentTerms = '${info.dueDate.difference(info.date).inDays} days';
    final titles = <String>[
      // 'Invoice Number:',
      'Sales report Date:',
      // 'Payment Terms:',
      // 'Due Date:'
    ];
    final data = <String>[
      // info.number,
      // Utils.formatDate(info.date),
      info.date,
      // paymentTerms,
      // Utils.formatDate(info.dueDate),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 300);
      }),
    );
  }

  static Widget buildSupplierAddress(Supplier supplier) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(supplier.name, style: TextStyle(fontWeight: FontWeight.bold)),
          // SizedBox(height: 1 * PdfPageFormat.mm),
          // Text(supplier.address),
        ],
      );

  static Widget buildTitle(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sales Report',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          // SizedBox(height: 0.8 * PdfPageFormat.cm),
          // Text(invoice.info.description),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(Invoice invoice) {
    final headers = [
      'Date',
      'No of items',
      'Product Price',
      'Discount',
      'Sub Total',
      'Status'
    ];
    final data = invoice.items.map((item) {
      // final total = item.unitPrice * item.quantity * (1 + item.vat);
      final total = item.product;

      return [
        item.date,
        '${item.noOfItems}',
        // '\$ ${item.unitPrice}',
        '${item.product}',
        '${item.discount}',
        // '${item.vat} %',
        '${item.subTotal}',
        '${item.status}',
        // '${total.toStringAsFixed(2)}',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(Invoice invoice) {
    final netTotal = invoice.items
        .map((item) => item.product)
        .reduce((item1, item2) => item1 + item2);
    // final vatPercent = invoice.items.first.vat;
    // final vat = netTotal * vatPercent;
    // final total = netTotal + vat;
    final total = netTotal;

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // buildText(
                //   title: 'Net total',
                //   value: Utils.formatPrice(00),
                //   unite: true,
                // ),
                // buildText(
                //   // title: 'Vat ${vatPercent * 100} %',
                //   // value: Utils.formatPrice(vat),
                //   unite: true,
                //   title: 'vatPercent',
                //   value: 'vat',
                // ),
                // Divider(),
                buildText(
                  title: 'Total amount',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: Utils.formatPrice(00),
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          // buildSimpleText(title: 'Address', value: invoice.supplier.address),
          SizedBox(height: 1 * PdfPageFormat.mm),
          // buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Expanded(child: Text(value, style: unite ? style : null)),
        ],
      ),
    );
  }
}
