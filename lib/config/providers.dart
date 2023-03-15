import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:qcamytraders/repository/addProduct/notifier/addProduct.notifier.dart';
import 'package:qcamytraders/repository/allProducts/notifier/allProducts.notifier.dart';
import 'package:qcamytraders/repository/brands/notifier/brands.notifier.dart';
import 'package:qcamytraders/repository/category/notifier/category.notifier.dart';
import 'package:qcamytraders/repository/editProduct/notifier/editProduct.notifier.dart';
import 'package:qcamytraders/repository/login/notifier/login.notifier.dart';
import 'package:qcamytraders/repository/orders/notifier/orders.notifier.dart';
import 'package:qcamytraders/repository/products/notifier/productDetails.notifier.dart';
import 'package:qcamytraders/repository/products/notifier/products.notifier.dart';
import 'package:qcamytraders/repository/profile/notifier/profile.notifier.dart';
import 'package:qcamytraders/repository/saleReport/notifier/saleReport.notifier.dart';
import 'package:qcamytraders/repository/spec/notifier/spec.notifier.dart';
import 'package:qcamytraders/repository/spec/notifier/specDetails.notifier.dart';
import 'package:qcamytraders/repository/spec/notifier/specTemplate.notifier.dart';
import 'package:qcamytraders/repository/tax/notifier/tax.notifier.dart';

List<SingleChildWidget> providers = [

  ChangeNotifierProvider<LoginNotifier>(create: (context) => LoginNotifier()),
  ChangeNotifierProvider<ProfileNotifier>(create: (context) => ProfileNotifier()),
  ChangeNotifierProvider<ProductsNotifier>(create: (context) => ProductsNotifier()),
  ChangeNotifierProvider<ProductDetailsNotifier>(create: (context) => ProductDetailsNotifier()),
  ChangeNotifierProvider<OrdersNotifier>(create: (context) => OrdersNotifier()),
  ChangeNotifierProvider<AddProductNotifier>(create: (context) => AddProductNotifier()),
  ChangeNotifierProvider<SpecNotifier>(create: (context) => SpecNotifier()),
  ChangeNotifierProvider<SpecTemplateNotifier>(create: (context) => SpecTemplateNotifier()),
  ChangeNotifierProvider<CategoryNotifier>(create: (context) => CategoryNotifier()),
  ChangeNotifierProvider<BrandsNotifier>(create: (context) => BrandsNotifier()),
  ChangeNotifierProvider<AllProductsNotifier>(create: (context) => AllProductsNotifier()),
  ChangeNotifierProvider<TaxNotifier>(create: (context) => TaxNotifier()),
  ChangeNotifierProvider<SpecDetailsNotifier>(create: (context) => SpecDetailsNotifier()),
  ChangeNotifierProvider<EditProductNotifier>(create: (context) => EditProductNotifier()),
  ChangeNotifierProvider<SaleReportNotifier>(create: (context) => SaleReportNotifier()),

];
