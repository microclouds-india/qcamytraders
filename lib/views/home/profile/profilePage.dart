import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamytraders/common/ui/Ui.dart';
import 'package:qcamytraders/config/colors.dart';
import 'package:qcamytraders/core/token_storage/storage.dart';
import 'package:qcamytraders/repository/profile/notifier/profile.notifier.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<ProfileNotifier>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text(
          userData.profileModel.data[0].name,
          style: GoogleFonts.quicksand(
              fontSize: 17,
              color: Colors.white,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 150),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 15, right: 15),
              decoration:
              Ui.getBoxDecoration(color: primaryColor),
              child: Column(
                children: [
                  UserInfo(
                    title: "Owner's Name",
                    text: userData.profileModel.data[0].name,
                    icon: Icons.person,
                  ),
                  UserInfo(
                    title: "Location",
                    text: userData.profileModel.data[0].city,
                    icon: Icons.description,
                  ),
                  UserInfo(
                      title: "Address",
                      text: userData.profileModel.data[0].address,
                      icon: Icons.location_on),
                  UserInfo(
                    title: "Phone No",
                    text: userData.profileModel.data[0].phone,
                    icon: Icons.call,
                  ),
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      height: 40,
                      width: 150,
                      child: Center(
                        child: Text("Logout",
                          style: GoogleFonts.openSans(
                              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              title: Text('Logout',
                                  style: TextStyle(color: Colors.black)),
                              content: Text(
                                  'Do you want to logout from this account?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text('No', style: TextStyle(color: primaryColor),),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    //logout operations
                                    LocalStorage localStorage = LocalStorage();
                                    await localStorage.deleteToken().whenComplete(() {
                                      Navigator.of(context).pushNamedAndRemoveUntil("/loginView", (route) => false);
                                    });
                                  },
                                  child: Text('Yes', style: TextStyle(color: primaryColor),),
                                ),
                              ],
                            );
                          }));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key? key,
    required this.text,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.all(20),
      decoration: Ui.getBoxDecorationProfile(color: primaryColor),
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 30,
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w700, fontSize: 14),
              ),
              SizedBox(
                width: 250,
                child: Text(
                  text,
                  style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w500, fontSize: 12),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
