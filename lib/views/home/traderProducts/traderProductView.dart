import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamytraders/common/ui/Ui.dart';
import 'package:qcamytraders/config/colors.dart';
import 'package:qcamytraders/repository/products/notifier/productDetails.notifier.dart';
import 'package:qcamytraders/widgets/view_image.dart';
import 'package:readmore/readmore.dart';

class TraderProductView extends StatelessWidget {
  const TraderProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final productDetailsData = Provider.of<ProductDetailsNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Details",
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
      body: FutureBuilder(
          future: productDetailsData.getProductDetails(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              productDetailsData.selectedImage = productDetailsData.productDetailsModel.data[0].image.data[0].image.isNotEmpty
                  ? productDetailsData.productDetailsModel.data[0].image.data[0].image
                  : "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg";
              return Container(
                margin: EdgeInsets.all(20.0),
                decoration: Ui.getBoxDecoration(color: primaryColor),
                child: ListView(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ViewImage(imageLink: productDetailsData.selectedImage),
                          ),
                        );
                      },
                      child: Consumer<ProductDetailsNotifier>(
                          builder: (context, data, _) {
                            return Container(
                              margin: EdgeInsets.all(50.0),
                              child: CachedNetworkImage(
                                // imageUrl: itemData.viewItemDetailsModel.image.isNotEmpty
                                //     ? itemData.viewItemDetailsModel.image[0].image
                                //     : imgPlaceHolder,
                                imageUrl: productDetailsData.selectedImage,
                                placeholder: (context, url) {
                                  return Image.asset(
                                    "assets/images/png/place_holder.png",
                                  );
                                },
                                fit: BoxFit.fill,
                                errorWidget: (context, url, error) {
                                  return Image.asset(
                                      "assets/images/png/place_holder.png");
                                },
                              ),
                            );
                          }),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      decoration:
                      Ui.getBoxDecorationProfile(color: primaryColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                            child: Text("Product Details",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text("Category",
                                    style: GoogleFonts.openSans(fontSize: 13),
                                  ),
                                ),
                              ),
                              Text(" : "),
                              Expanded(
                                child: Text("${productDetailsData.productDetailsModel.data[0].categoryName}",
                                  style: GoogleFonts.openSans(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text("Brand",
                                    style: GoogleFonts.openSans(fontSize: 13),
                                  ),
                                ),
                              ),
                              Text(" : "),
                              Expanded(
                                child: Text("${productDetailsData.productDetailsModel.data[0].brandName}",
                                  style: GoogleFonts.openSans(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text("Product Name",
                                    style: GoogleFonts.openSans(fontSize: 13),
                                  ),
                                ),
                              ),
                              Text(" : "),
                              Expanded(
                                child: Text("${productDetailsData.productDetailsModel.data[0].productName}",
                                  style: GoogleFonts.openSans(fontSize: 13),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text("Stock",
                                    style: GoogleFonts.openSans(fontSize: 13),
                                  ),
                                ),
                              ),
                              Text(" : "),
                              Expanded(
                                child: Text(
                                  productDetailsData.productDetailsModel.data[0].stock
                                      .isNotEmpty
                                      ? "${productDetailsData.productDetailsModel.data[0].stock}"
                                      : "0",
                                  style: GoogleFonts.openSans(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text("Slno",
                                    style: GoogleFonts.openSans(fontSize: 13),
                                  ),
                                ),
                              ),
                              Text(" : "),
                              Expanded(
                                child: Text("${productDetailsData.productDetailsModel.data[0].slno}",
                                  style: GoogleFonts.openSans(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text("HSN Code",
                                    style: GoogleFonts.openSans(fontSize: 13),
                                  ),
                                ),
                              ),
                              Text(" : "),
                              Expanded(
                                child: Text("${productDetailsData.productDetailsModel.data[0].hsncode}",
                                  style: GoogleFonts.openSans(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text("MRP",
                                    style: GoogleFonts.openSans(fontSize: 13),
                                  ),
                                ),
                              ),
                              Text(" : "),
                              Expanded(
                                child: Text("${productDetailsData.productDetailsModel.data[0].mrp}",
                                  style: GoogleFonts.openSans(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text("Tax Type",
                                    style: GoogleFonts.openSans(fontSize: 13),
                                  ),
                                ),
                              ),
                              Text(" : "),
                              Expanded(
                                child: Text("Include",
                                  style: GoogleFonts.openSans(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text("Tax %",
                                    style: GoogleFonts.openSans(fontSize: 13),
                                  ),
                                ),
                              ),
                              Text(" : "),
                              Expanded(
                                child: Text("${productDetailsData.productDetailsModel.data[0].taxPer}",
                                  style: GoogleFonts.openSans(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text("Actual Price",
                                    style: GoogleFonts.openSans(fontSize: 13),
                                  ),
                                ),
                              ),
                              Text(" : "),
                              Expanded(
                                child: Text("${productDetailsData.productDetailsModel.data[0].actualPrice}",
                                  style: GoogleFonts.openSans(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text("CGST",
                                    style: GoogleFonts.openSans(fontSize: 13),
                                  ),
                                ),
                              ),
                              Text(" : "),
                              Expanded(
                                child: Text("${productDetailsData.productDetailsModel.data[0].cgst}",
                                  style: GoogleFonts.openSans(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text("SGST",
                                    style: GoogleFonts.openSans(fontSize: 13),
                                  ),
                                ),
                              ),
                              Text(" : "),
                              Expanded(
                                child: Text("${productDetailsData.productDetailsModel.data[0].sgst}",
                                  style: GoogleFonts.openSans(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text("GST",
                                    style: GoogleFonts.openSans(fontSize: 13),
                                  ),
                                ),
                              ),
                              Text(" : "),
                              Expanded(
                                child: Text("${productDetailsData.productDetailsModel.data[0].gst}",
                                  style: GoogleFonts.openSans(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text("Price",
                                    style: GoogleFonts.openSans(fontSize: 13),
                                  ),
                                ),
                              ),
                              Text(" : "),
                              Expanded(
                                child: Text("${productDetailsData.productDetailsModel.data[0].price}",
                                  style: GoogleFonts.openSans(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text("Offer %",
                                    style: GoogleFonts.openSans(fontSize: 13),
                                  ),
                                ),
                              ),
                              Text(" : "),
                              Expanded(
                                child: Text("${productDetailsData.productDetailsModel.data[0].offerPer}",
                                  style: GoogleFonts.openSans(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          EquipmentDetails(
                            title: "Description",
                            details: productDetailsData.productDetailsModel.data[0].description,
                          ),
                          EquipmentDetails(
                            title: "Specifications",
                            details: productDetailsData.productDetailsModel.data[0].specifications,
                          ),
                          if (productDetailsData.productDetailsModel.data[0].specDetails != "no Items")
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                            child: Text("Specifications Details",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          ),
                          if (productDetailsData.productDetailsModel.data[0].specDetails != "no Items")
                          for(int i = 0; i<productDetailsData.productDetailsModel.data[0].specDetails.data.length; i++)
                            if (productDetailsData.productDetailsModel.data[0].specDetails != "no Items")
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      productDetailsData.productDetailsModel.data[0].specDetails.data[i].specCat,
                                      style: GoogleFonts.quicksand(
                                          fontSize: 14, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Text(" : "),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(productDetailsData.productDetailsModel.data[0].specDetails.data[i].catValue+" "+
                                        productDetailsData.productDetailsModel.data[0].specDetails.data[i].measure,
                                      style: GoogleFonts.quicksand(
                                          fontSize: 14, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (productDetailsData.productDetailsModel.data[0].together != "no Items")
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                              child: Text("Together Products",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                          if (productDetailsData.productDetailsModel.data[0].together != "no Items")
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:productDetailsData.productDetailsModel.data[0].together.data.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 10,
                                          offset: const Offset(0, 5)),
                                    ],
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.05)),
                                  ),
                                  child: Text(productDetailsData.productDetailsModel.data[0].together.data[index].product_name,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              },
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }),
    );
  }
}


class EquipmentDetails extends StatefulWidget {
  const EquipmentDetails({
    Key? key,
    required this.title,
    required this.details,
  }) : super(key: key);

  final String title;
  final String details;

  @override
  State<EquipmentDetails> createState() => _EquipmentDetailsState();
}

class _EquipmentDetailsState extends State<EquipmentDetails> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            ),
            SizedBox(height: 5),
            ReadMoreText(
              widget.details,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
              trimLines: 5,
              colorClickableText: primaryColor,
              trimMode: TrimMode.Line,
              trimCollapsedText: ' Show more',
              trimExpandedText: ' Show less',
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}


class EquipmentImage extends StatelessWidget {
  const EquipmentImage({
    Key? key,
    required this.image,
    required this.itemData,
  }) : super(key: key);

  final String image;
  final ProductDetailsNotifier itemData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: ((context) => ViewImage(imageLink: image))));
        itemData.changeSelectedImage(image);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5)),
          ],
          border: Border.all(color: Colors.grey),
        ),
        padding: EdgeInsets.all(10),
        // margin: EdgeInsets.only(left: 10, right: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.fill,
            width: 120,
            placeholder: (context, url) {
              return Image.asset(
                "assets/images/png/place_holder.png",
                fit: BoxFit.fill,
                width: 120,
              );
            },
          ),
        ),
      ),
    );
  }
}