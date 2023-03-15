// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamytraders/common/ui/Ui.dart';
import 'package:qcamytraders/config/colors.dart';
import 'package:qcamytraders/repository/profile/notifier/profile.notifier.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<ProfileNotifier>(context, listen: false);

    return FutureBuilder(
        future: userData.getProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return userData.profileModel.data.isNotEmpty
                ? Scaffold(
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      elevation: 0,
                      backgroundColor: primaryColor,
                      title: Text(userData.profileModel.data[0].name,
                        style: GoogleFonts.quicksand(
                            fontSize: 17,
                            color: Colors.white,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Options(
                              icon: "past_bookings_icon.png",
                              title: "My Orders",
                              onTap: () {
                                Navigator.of(context).pushNamed("/traderOrders");
                              },
                            ),
                            Options(
                              icon: "view_items.png",
                              title: "Sales Report",
                              onTap: () {
                                Navigator.of(context).pushNamed("/saleReport");
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Options(
                              icon: "my_bookings_icon.png",
                              title: "Products",
                              onTap: () {
                                Navigator.of(context).pushNamed("/traderProducts");
                              },
                            ),
                            Options(
                              icon: "add_items.png",
                              title: "Add Product",
                              onTap: () {
                                Navigator.of(context).pushNamed("/traderAddProduct");
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : Center(child: Text("No items"));
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong"),
            );
          }
          return Center(child: CircularProgressIndicator(color: primaryColor));
        });
  }
}

class Options extends StatelessWidget {
  const Options({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  final String icon;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        height: 200,
        decoration: Ui.getBoxDecoration(color: primaryColor),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            "assets/images/png/$icon",
            height: 50,
          ),
          SizedBox(height: 30),
          SizedBox(
            width: 150,
            child: Text(
              title,
              style: GoogleFonts.openSans(fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
        ]),
      ),
    ));
  }
}
