import 'package:flutter/material.dart';
import 'package:qcamytraders/views/home/main/main.view.dart';
import 'package:qcamytraders/views/home/profile/profilePage.dart';
import 'package:qcamytraders/views/home/traderOrders/traderOrders.dart';
import 'package:qcamytraders/views/home/traderProducts/traderAddProduct.dart';
import 'package:qcamytraders/views/home/traderProducts/traderEditProduct.dart';
import 'package:qcamytraders/views/home/traderProducts/traderProductView.dart';
import 'package:qcamytraders/views/home/traderProducts/traderProducts.dart';
import 'package:qcamytraders/views/login/login.view.dart';
import 'package:qcamytraders/views/report/pdfDownload.dart';
import 'package:qcamytraders/views/report/saleReport.dart';
import 'package:qcamytraders/views/splashscreen/splash.view.dart';

Map<String, Widget Function(BuildContext)> routes = {

  '/splashView': (context) => const SplashView(),
  '/loginView': (context) => const LoginView(),
  '/mainHomeView': (context) => MainHomeView(),
  '/traderProducts': (context) => const TraderProducts(),
  '/traderProductView': (context) => const TraderProductView(),
  '/traderOrders': (context) => const TraderOrders(),
  '/traderAddProduct': (context) => const TraderAddProduct(),
  '/traderEditProduct': (context) => const TraderEditProduct(),
  '/profilePage': (context) => const ProfilePage(),
  '/saleReport': (context) => SaleReport(),
  '/pdfDownload': (context) => PDFDownload(),

};
