import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qcamytraders/common/ui/Ui.dart';
import 'package:qcamytraders/config/colors.dart';
import 'package:qcamytraders/repository/addProduct/notifier/addProduct.notifier.dart';
import 'package:qcamytraders/repository/allProducts/notifier/allProducts.notifier.dart';
import 'package:qcamytraders/repository/brands/notifier/brands.notifier.dart';
import 'package:qcamytraders/repository/category/notifier/category.notifier.dart';
import 'package:qcamytraders/repository/editProduct/notifier/editProduct.notifier.dart';
import 'package:qcamytraders/repository/products/notifier/productDetails.notifier.dart';
import 'package:qcamytraders/repository/products/notifier/products.notifier.dart';
import 'package:qcamytraders/repository/spec/notifier/spec.notifier.dart';
import 'package:qcamytraders/repository/spec/notifier/specDetails.notifier.dart';
import 'package:qcamytraders/repository/spec/notifier/specTemplate.notifier.dart';
import 'package:qcamytraders/repository/tax/notifier/tax.notifier.dart';
import 'package:qcamytraders/widgets/booking_button.widget.dart';
import 'package:qcamytraders/widgets/booking_form_textfield.widget.dart';
import 'package:qcamytraders/widgets/success_dialogBox.widget.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class TraderEditProduct extends StatefulWidget {
  const TraderEditProduct({Key? key}) : super(key: key);

  @override
  State<TraderEditProduct> createState() => _TraderEditProductState();
}

class _TraderEditProductState extends State<TraderEditProduct> {
  final ImagePicker imagePicker = ImagePicker();

  var specTemplateitems = [];
  var specTemplateitemsEdited = [];

  List<TextEditingController> _controllers = [TextEditingController()];
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController specificationsController = TextEditingController();
  final TextEditingController mrpController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController taxtypeController = TextEditingController();
  final TextEditingController totalPriceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController slnoController = TextEditingController();
  final TextEditingController hsncodeController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    specificationsController.dispose();
    mrpController.dispose();
    priceController.dispose();
    taxtypeController.dispose();
    totalPriceController.dispose();
    stockController.dispose();
    slnoController.dispose();
    hsncodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final specData = Provider.of<SpecNotifier>(context, listen: false);
    final specTemplateData =
        Provider.of<SpecTemplateNotifier>(context, listen: false);
    final categoryData = Provider.of<CategoryNotifier>(context, listen: false);
    final brandsData = Provider.of<BrandsNotifier>(context, listen: false);
    final allProductsData =
        Provider.of<AllProductsNotifier>(context, listen: false);
    final taxData = Provider.of<TaxNotifier>(context, listen: false);
    final productDetailsData =
        Provider.of<ProductDetailsNotifier>(context, listen: false);
    final productsData = Provider.of<ProductsNotifier>(context, listen: false);

    void selectImages() async {
      try {
        final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
        if (selectedImages!.isNotEmpty) {
          productDetailsData.imageFileList!.addAll(selectedImages);
        }
        productDetailsData.notifyListeners();
        // print("Image List Length:" + imageFileList!.length.toString());
        // setState(() {});
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }

    return WillPopScope(
      onWillPop: () async {
        allProductsData.togetherproductsItems.clear();
        allProductsData.togetherproductsName.clear();
        specTemplateitems.clear();
        specTemplateitemsEdited.clear();
        categoryData.categoryname = null;
        brandsData.brandname = null;
        taxData.taxType = null;
        specTemplateData.product_id = null;
        specData.product_id = null;
        allProductsData.togetherproducts = null;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          title: Text(
            "Edit Product",
            style: GoogleFonts.openSans(
                fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: productDetailsData.getProductDetails(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              }
              if (snapshot.hasData) {
                // productDetailsData.selectedImage = productDetailsData.productDetailsModel.data[0].image.data[0].image.isNotEmpty
                //     ? productDetailsData.productDetailsModel.data[0].image.data[0].image
                //     : "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg";

                productNameController.text = productDetailsData.productDetailsModel.data[0].productName;
                descriptionController.text = productDetailsData.productDetailsModel.data[0].description;
                specificationsController.text = productDetailsData.productDetailsModel.data[0].specifications;
                mrpController.text = productDetailsData.productDetailsModel.data[0].mrp;
                priceController.text = productDetailsData.productDetailsModel.data[0].price;
                taxtypeController.text = productDetailsData.productDetailsModel.data[0].taxPer;
                totalPriceController.text = productDetailsData.productDetailsModel.data[0].actualPrice;
                stockController.text = productDetailsData.productDetailsModel.data[0].stock;
                slnoController.text = productDetailsData.productDetailsModel.data[0].slno;
                hsncodeController.text = productDetailsData.productDetailsModel.data[0].hsncode;

                allProductsData.togetherproductsItems.clear();
                allProductsData.togetherproductsName.clear();
                if(productDetailsData.productDetailsModel.data[0].together != "no Items"){
                  for(int i = 0; i < productDetailsData.productDetailsModel.data[0].together.data.length; i++){
                    allProductsData.togetherproductsItems.add(productDetailsData.productDetailsModel.data[0].together.data[i].id);
                    allProductsData.togetherproductsName.add(productDetailsData.productDetailsModel.data[0].together.data[i].product_name);
                  }
                }
                if(productDetailsData.productDetailsModel.data[0].specDetails != "no Items"){
                  for(int i = 0; i < productDetailsData.productDetailsModel.data[0].specDetails.data.length; i++){
                    specTemplateitems.add({
                      "spec_cat": productDetailsData.productDetailsModel.data[0].specDetails.data[i].specCat,
                      "cat_value": productDetailsData.productDetailsModel.data[0].specDetails.data[i].catValue,
                      "measure": productDetailsData.productDetailsModel.data[0].specDetails.data[i].measure,
                    });
                  }
                }

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      margin: EdgeInsets.only(left: 5.0, right: 5.0),
                      decoration: Ui.getBoxDecoration(color: primaryColor),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                              child: Text("Category",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          FutureBuilder(
                            future: categoryData.getCategory(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return categoryData.categoryModel.data.isNotEmpty
                                    ? Consumer<CategoryNotifier>(
                                        builder: (context, data, _) {
                                        return Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            width: double.infinity,
                                            margin: const EdgeInsets.all(8),
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8),
                                            decoration:
                                                Ui.getBoxDecorationProfile(
                                                    color: primaryColor),
                                            child: DropdownButton(
                                              value: categoryData.categoryname,
                                              underline: SizedBox(),
                                              iconEnabledColor: primaryColor,
                                              isExpanded: true,
                                              hint: Text(productDetailsData.productDetailsModel.data[0].categoryName,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                              items: categoryData
                                                  .categoryModel.data
                                                  .map(
                                                    (map) => DropdownMenuItem(
                                                      value: map.id,
                                                      child: Text(
                                                        map.categoryname,
                                                        style: const TextStyle(
                                                            color: Colors.black),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                              onChanged: (value) {
                                                categoryData.categoryname = value.toString();
                                                categoryData.notifyListeners();
                                              },
                                            ),
                                          ),
                                        );
                                      })
                                    : const Center(child: Text("No items"));
                              } else {
                                return Container(
                                  margin: EdgeInsets.all(10),
                                  child: const CircularProgressIndicator(
                                    color: primaryColor,
                                  ),
                                );
                              }
                            },
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                              child: Text("Brand",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          FutureBuilder(
                            future: brandsData.getBrands(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return brandsData.brandsModel.data.isNotEmpty
                                    ? Consumer<BrandsNotifier>(
                                        builder: (context, data, _) {
                                        return Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            width: double.infinity,
                                            margin: const EdgeInsets.all(8),
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8),
                                            decoration:
                                                Ui.getBoxDecorationProfile(
                                                    color: primaryColor),
                                            child: DropdownButton(
                                              value: brandsData.brandname,
                                              underline: SizedBox(),
                                              iconEnabledColor: primaryColor,
                                              isExpanded: true,
                                              hint: Text(
                                                productDetailsData
                                                    .productDetailsModel
                                                    .data[0]
                                                    .brandName,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                              items: brandsData.brandsModel.data
                                                  .map(
                                                    (map) => DropdownMenuItem(
                                                      value: map.id,
                                                      child: Text(
                                                        map.brandName,
                                                        style: const TextStyle(
                                                            color: Colors.black),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                              onChanged: (value) {
                                                brandsData.brandname =
                                                    value.toString();
                                                brandsData.notifyListeners();
                                              },
                                            ),
                                          ),
                                        );
                                      })
                                    : const Center(child: Text("No items"));
                              } else {
                                return Container(
                                  margin: EdgeInsets.all(10),
                                  child: const CircularProgressIndicator(
                                    color: primaryColor,
                                  ),
                                );
                              }
                            },
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                              child: Text("Product Name",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          BookingFormTextFields(
                            hint: "Product Name",
                            maxLines: 1,
                            controller: productNameController,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                              child: Text("Description",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          BookingFormTextFields(
                            hint: "Description",
                            controller: descriptionController,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                              child: Text("Specifications",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          BookingFormTextFields(
                            hint: "Specifications",
                            controller: specificationsController,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                              child: Text("MRP",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          BookingFormTextFields(
                            hint: "MRP",
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                            controller: mrpController,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                              child: Text("Price",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          BookingFormTextFields(
                            hint: "Price",
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                            controller: priceController,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                              child: Text("Tax Type",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          FutureBuilder(
                            future: taxData.getTax(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return taxData.taxModel.data.isNotEmpty
                                    ? Consumer<TaxNotifier>(
                                        builder: (context, data, _) {
                                        return Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            width: double.infinity,
                                            margin: const EdgeInsets.all(8),
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8),
                                            decoration:
                                                Ui.getBoxDecorationProfile(
                                                    color: primaryColor),
                                            child: DropdownButton(
                                              value: taxData.taxType,
                                              underline: SizedBox(),
                                              iconEnabledColor: primaryColor,
                                              isExpanded: true,
                                              hint: Text(productDetailsData.productDetailsModel.data[0].taxPer,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                              items: taxData.taxModel.data
                                                  .map(
                                                    (map) => DropdownMenuItem(
                                                      value: map.tax,
                                                      child: Text(
                                                        map.tax,
                                                        style: const TextStyle(
                                                            color: Colors.black),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                              onChanged: (value) {
                                                taxData.taxType = value.toString();
                                                taxData.calc = 100 + double.parse(taxData.taxType);
                                                taxData.plus = double.parse(priceController.text) / taxData.calc;
                                                taxData.total1 = taxData.plus * 100;
                                                taxData.total = taxData.total1.toStringAsFixed(2);
                                                taxData.taxamount1 = double.parse(priceController.text) - double.parse(taxData.total);
                                                taxData.taxamount = taxData.taxamount1.toStringAsFixed(2);
                                                taxData.gst1 = double.parse(taxData.taxamount) / 2;
                                                taxData.gst = taxData.gst1.toStringAsFixed(2);
                                                taxData.actualprice = taxData.total.toString();
                                                taxData.notifyListeners();
                                              },
                                            ),
                                          ),
                                        );
                                      })
                                    : const Center(child: Text("No items"));
                              } else {
                                return Container(
                                  margin: EdgeInsets.all(10),
                                  child: const CircularProgressIndicator(
                                    color: primaryColor,
                                  ),
                                );
                              }
                            },
                          ),
                          Container(
                              width: double.infinity,
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5)),
                                ],
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.05)),
                              ),
                              child: Text("Include")),
                          // Consumer<TaxNotifier>(builder: (context, data, _) {
                          //   return Container(
                          //       width: double.infinity,
                          //       margin: const EdgeInsets.all(10),
                          //       padding: const EdgeInsets.all(10),
                          //       decoration: BoxDecoration(
                          //         color: Colors.white,
                          //         borderRadius:
                          //             const BorderRadius.all(Radius.circular(10)),
                          //         boxShadow: [
                          //           BoxShadow(
                          //               color: Colors.grey.withOpacity(0.2),
                          //               blurRadius: 10,
                          //               offset: const Offset(0, 5)),
                          //         ],
                          //         border:
                          //             Border.all(color: Colors.grey.withOpacity(0.05)),
                          //       ),
                          //       child: Text(taxData.actualprice));
                          // }),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                              child: Text("Stock",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          BookingFormTextFields(
                            hint: "Stock",
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                            controller: stockController,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                              child: Text("Sl No",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          BookingFormTextFields(
                            hint: "Sl No",
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                            controller: slnoController,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                              child: Text("HSN Code",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          BookingFormTextFields(
                            hint: "HSN Code",
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                            controller: hsncodeController,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                              child: Text("Select Spec",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          FutureBuilder(
                            future: specData.getSpec(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return specData.specModel.data.isNotEmpty
                                    ? Consumer<SpecNotifier>(
                                        builder: (context, data, _) {
                                        return Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            width: double.infinity,
                                            margin: const EdgeInsets.all(8),
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8),
                                            decoration:
                                                Ui.getBoxDecorationProfile(
                                                    color: primaryColor),
                                            child: DropdownButton(
                                              value: specData.product_id,
                                              underline: SizedBox(),
                                              iconEnabledColor: primaryColor,
                                              isExpanded: true,
                                              hint: Text(productDetailsData.productDetailsModel.data[0].specDetails == "no Items" ?
                                              "Select Spec" : productDetailsData.productDetailsModel.data[0].specDetails.data[0].templateId,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                              items: specData.specModel.data
                                                  .map(
                                                    (map) => DropdownMenuItem(
                                                      value: map.id,
                                                      child: Text(
                                                        map.templateName,
                                                        style: const TextStyle(
                                                            color: Colors.black),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                              onChanged: (value) {
                                                // setState(() {
                                                  specData.product_id = value.toString();
                                                  specTemplateData.product_id = value.toString();
                                                  specTemplateData.notifyListeners();
                                                  specData.notifyListeners();
                                                // });
                                              },
                                            ),
                                          ),
                                        );
                                      })
                                    : const Center(child: Text("No items"));
                              } else {
                                return Container(
                                  margin: EdgeInsets.all(10),
                                  child: const CircularProgressIndicator(
                                    color: primaryColor,
                                  ),
                                );
                              }
                            },
                          ),
                          // if (productDetailsData.productDetailsModel.data[0].specDetails == "no Items")
                          //   ListView.builder(
                          //       physics: NeverScrollableScrollPhysics(),
                          //       shrinkWrap: true,
                          //       itemCount: productDetailsData.productDetailsModel.data[0].specDetails.data.length,
                          //       itemBuilder: (context, index) {
                          //         _controllers.add(new TextEditingController());
                          //         _controllers[index].text = productDetailsData.productDetailsModel.data[0].specDetails.data[index].catValue+" "+
                          //             productDetailsData.productDetailsModel.data[0].specDetails.data[index].measure;
                          //         return BookingFormTextFields(
                          //           hint: productDetailsData.productDetailsModel.data[0].specDetails.data[index].specCat,
                          //           maxLines: 1,
                          //           keyboardType: TextInputType.number,
                          //           controller: _controllers[index],
                          //         );
                          //       }),
                          // if (specTemplateData.product_id != null)
                          // if (productDetailsData.productDetailsModel.data[0].specDetails != "no Items")
                          if (specTemplateitems.length != 0)
                            Consumer<SpecTemplateNotifier>(builder: (context, data, _) {
                              return specTemplateData.product_id.toString() == "null" ? ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: productDetailsData.productDetailsModel.data[0].specDetails.data.length,
                                  itemBuilder: (context, index) {
                                    _controllers.add(new TextEditingController());
                                    _controllers[index].text = productDetailsData.productDetailsModel.data[0].specDetails.data[index].catValue+" "+
                                        productDetailsData.productDetailsModel.data[0].specDetails.data[index].measure;
                                    return BookingFormTextFields(
                                      hint: productDetailsData.productDetailsModel.data[0].specDetails.data[index].specCat,
                                      maxLines: 1,
                                      keyboardType: TextInputType.number,
                                      controller: _controllers[index],
                                    );
                                  }) : FutureBuilder(
                                future: specTemplateData.getSpecTemplate(
                                    id: specTemplateData.product_id),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    // for(int i=0; i<productDetailsData.productDetailsModel.data[0].specDetails.data.length; i++){
                                    //   _controllers[i-1].clear();
                                    // }
                                    return specTemplateData.specTemplateModel.data.isNotEmpty
                                        ? Consumer<SpecTemplateNotifier>(builder: (context, data, _) {
                                      return ListView.builder(
                                          physics: NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: specTemplateData.specTemplateModel.data.length,
                                          itemBuilder: (context, index) {
                                            _controllers.add(new TextEditingController());
                                            return BookingFormTextFields(
                                              hint: specTemplateData.specTemplateModel.data[index].specCat+"("+specTemplateData.specTemplateModel.data[index].measure+")",
                                              maxLines: 1,
                                              keyboardType: TextInputType.number,
                                              controller: _controllers[index],
                                            );
                                          });
                                    })
                                        : const Center(child: Text("No items"));
                                  } else {
                                    return Container(
                                      margin: EdgeInsets.all(10),
                                      child: const CircularProgressIndicator(
                                        color: primaryColor,
                                      ),
                                    );
                                  }
                                },
                              );
                            }),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                              child: Text("Together Products",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          FutureBuilder(
                            future: allProductsData.getAllProducts(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return allProductsData
                                        .allProductsModel.data.isNotEmpty
                                    ? Consumer<AllProductsNotifier>(
                                        builder: (context, data, _) {
                                        return Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            width: double.infinity,
                                            margin: const EdgeInsets.all(8),
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8),
                                            decoration:
                                                Ui.getBoxDecorationProfile(
                                                    color: primaryColor),
                                            child: DropdownButton(
                                              value: allProductsData
                                                  .togetherproducts,
                                              underline: SizedBox(),
                                              iconEnabledColor: primaryColor,
                                              isExpanded: true,
                                              // hint: Text( productDetailsData.productDetailsModel.data[0].together == "no Items" ?
                                              //   "Together Products" : productDetailsData.productDetailsModel.data[0].together.data[0].product_name,
                                              //   style: const TextStyle(
                                              //       color: Colors.black),
                                              // ),
                                              hint: Text("Together Products",
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                              items: allProductsData
                                                  .allProductsModel.data
                                                  .map(
                                                    (map) => DropdownMenuItem(
                                                      value: map.id,
                                                      child: Container(
                                                        width: double.infinity,
                                                        padding: EdgeInsets.only(
                                                            left: 10.0,
                                                            right: 10.0,
                                                            top: 15.0,
                                                            bottom: 15.0),
                                                        decoration: Ui
                                                            .getBoxDecorationProfile(
                                                                color:
                                                                    primaryColor),
                                                        child: Text(
                                                          map.productName,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                              onChanged: (value) {
                                                // setState(() {
                                                allProductsData.togetherproducts = value.toString();
                                                allProductsData.togetherproductsItems.add(value.toString());
                                                for (int i = 0; i < allProductsData.allProductsModel.data.length; i++) {
                                                  if (value.toString() == allProductsData.allProductsModel.data[i].id) {
                                                    allProductsData.togetherproductsName.add(allProductsData.allProductsModel.data[i].productName);
                                                  }
                                                }
                                                allProductsData.notifyListeners();
                                                // });
                                              },
                                            ),
                                          ),
                                        );
                                      })
                                    : const Center(child: Text("No items"));
                              } else {
                                return Container(
                                  margin: EdgeInsets.all(10),
                                  child: const CircularProgressIndicator(
                                    color: primaryColor,
                                  ),
                                );
                              }
                            },
                          ),
                          // if (allProductsData.togetherproductsName.length == 0)
                          //   if (productDetailsData.productDetailsModel.data[0].together != "no Items")
                          //   ListView.builder(
                          //     physics: NeverScrollableScrollPhysics(),
                          //     shrinkWrap: true,
                          //     itemCount: productDetailsData.productDetailsModel.data[0].together.data.length,
                          //     itemBuilder: (context, index) {
                          //       return Container(
                          //         margin: const EdgeInsets.all(10),
                          //         padding: const EdgeInsets.all(10),
                          //         decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           borderRadius: const BorderRadius.all(
                          //               Radius.circular(10)),
                          //           boxShadow: [
                          //             BoxShadow(
                          //                 color: Colors.grey.withOpacity(0.2),
                          //                 blurRadius: 10,
                          //                 offset: const Offset(0, 5)),
                          //           ],
                          //           border: Border.all(
                          //               color: Colors.grey.withOpacity(0.05)),
                          //         ),
                          //         child: Row(
                          //           children: [
                          //             Expanded(
                          //               child: Text(productDetailsData.productDetailsModel.data[0].together.data[index].product_name,
                          //                 style: TextStyle(
                          //                   color: Colors.black,
                          //                 ),
                          //               ),
                          //             ),
                          //             GestureDetector(
                          //               onTap: () {
                          //                 allProductsData.togetherproductsName
                          //                     .remove(productDetailsData.productDetailsModel.data[0].together.data[index]);
                          //                 allProductsData
                          //                     .togetherproductsItems
                          //                     .remove(productDetailsData.productDetailsModel.data[0].together.data[index]);
                          //                 allProductsData.notifyListeners();
                          //               },
                          //               child: Padding(
                          //                 padding: const EdgeInsets.all(10.0),
                          //                 child: Icon(
                          //                   Icons.close,
                          //                   color: Colors.black,
                          //                 ),
                          //               ),
                          //             )
                          //           ],
                          //         ),
                          //       );
                          //     },
                          //   ),
                          // if (allProductsData.togetherproductsName.length != 0)
                            Consumer<AllProductsNotifier>(builder: (context, data, _) {
                              return allProductsData.togetherproductsName.length == 0 ? Container() : ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                allProductsData.togetherproductsName.length,
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
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            allProductsData
                                                .togetherproductsName[index],
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            allProductsData.togetherproductsName
                                                .remove(allProductsData
                                                .togetherproductsName[
                                            index]);
                                            allProductsData
                                                .togetherproductsItems
                                                .remove(allProductsData
                                                .togetherproductsItems[
                                            index]);
                                            allProductsData.notifyListeners();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.black,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            }),

                          //button to select images
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(left: 10, top: 10),
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                              color: primaryColor,
                              onPressed: () async {
                                selectImages();
                              },
                              child: Text(
                                "Add Images",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          //image showing part
                              Consumer<ProductDetailsNotifier>(builder: (context, data, _) {
                                return ReorderableGridView.builder(
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing: 10, crossAxisCount: 3),
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: EdgeInsets.all(10),
                                    onReorder: ((oldIndex, newIndex) {
                                      XFile path = productDetailsData.imageFileList!.removeAt(oldIndex);
                                      productDetailsData.imageFileList!.insert(newIndex, path);
                                      setState(() {});
                                    }),
                                    itemCount: productDetailsData.imageFileList!.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        key: ValueKey(index),
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          border:
                                          Border.all(color: primaryColor, width: 2),
                                        ),
                                        child: Stack(
                                          children: [
                                            Image.file(
                                              File(productDetailsData.imageFileList![index].path),
                                              fit: BoxFit.cover,
                                            ),
                                            Visibility(
                                              visible: index == 0,
                                              child: Container(
                                                decoration:
                                                BoxDecoration(color: primaryColor),
                                                child: Text(
                                                  " Main Image ",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              }),

                        ],
                      ),
                    ),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }),
        bottomNavigationBar: Consumer<ProductDetailsNotifier>(builder: (context, data, _) {
          return SizedBox(
            height: kBottomNavigationBarHeight - 5,
            child: Consumer<EditProductNotifier>(builder: (context, data, _) {
              return data.isLoading
                  ? const Center(
                heightFactor: 1,
                widthFactor: 1,
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                    color: primaryColor,
                  ),
                ),
              )
                  : MaterialButton(
                onPressed: () async {
                  if (productDetailsData.imageFileList!.isNotEmpty) {
                    // LocalStorage localStorage = LocalStorage();
                    // final String? token = await localStorage.getToken();

                    specTemplateitems.clear();
                    specTemplateitemsEdited.clear();

                    print("sssssssss: "+specTemplateData.product_id.toString());

                    if(specTemplateData.product_id.toString() == "null") {
                      // for (int i = 0; i < _controllers.length - 1; i++) {
                        for (int j = 0; j < productDetailsData.productDetailsModel.data[0].specDetails.data.length; j++) {
                          // if (i == j) {
                            // specTemplateitems.add({
                            //   "spec_cat": productDetailsData.productDetailsModel.data[0].specDetails.data[j].specCat,
                            //   "cat_value": _controllers[i].text,
                            //   "measure": productDetailsData.productDetailsModel.data[0].specDetails.data[j].measure,
                            // });
                            specTemplateitemsEdited.add({
                              "id": productDetailsData.productDetailsModel.data[0].specDetails.data[j].templateId,
                              "spec_cat": productDetailsData.productDetailsModel.data[0].specDetails.data[j].specCat,
                              "cat_value": productDetailsData.productDetailsModel.data[0].specDetails.data[j].catValue,
                              "measure": productDetailsData.productDetailsModel.data[0].specDetails.data[j].measure,
                            });
                          // }
                        }
                      // }
                    }
                    else if(specTemplateData.product_id == productDetailsData.productDetailsModel.data[0].specDetails.data[0].templateId){
                      for (int i = 0; i < _controllers.length - 1; i++) {
                        for (int j = 0; j < productDetailsData.productDetailsModel.data[0].specDetails.data.length; j++) {
                          if (i == j) {
                            specTemplateitemsEdited.add({
                              "id": productDetailsData.productDetailsModel.data[0].specDetails.data[j].id,
                              "spec_cat": productDetailsData.productDetailsModel.data[0].specDetails.data[j].specCat,
                              "cat_value": _controllers[i].text,
                              "measure": productDetailsData.productDetailsModel.data[0].specDetails.data[j].measure,
                            });
                          }
                        }
                      }
                    }
                    else {
                      for (int i = 0; i < _controllers.length - 1; i++) {
                        for (int j = 0; j < specTemplateData.specTemplateModel.data.length; j++) {
                          if (i == j) {
                            // specTemplateitemsEdited.add({
                            //   "id": specData.product_id.toString(),
                            //   "spec_cat": specTemplateData.specTemplateModel.data[j].specCat,
                            //   "cat_value": _controllers[i].text,
                            //   "measure": specTemplateData.specTemplateModel.data[j].measure,
                            // });
                            specTemplateitems.add({
                              "spec_cat": specTemplateData.specTemplateModel.data[j].specCat,
                              "cat_value": _controllers[i].text,
                              "measure": specTemplateData.specTemplateModel.data[j].measure,
                            });
                          }
                        }
                      }
                    }



                    if(categoryData.categoryname.toString() == "null"){
                      for(int i=0; i<categoryData.categoryModel.data.length; i++){
                        if(productDetailsData.productDetailsModel.data[0].categoryName == categoryData.categoryModel.data[i].categoryname){
                          categoryData.categoryname = categoryData.categoryModel.data[i].id;
                        }
                      }
                    }
                    if(brandsData.brandname.toString() == "null"){
                      for(int i=0; i<brandsData.brandsModel.data.length; i++){
                        if(productDetailsData.productDetailsModel.data[0].brandName == brandsData.brandsModel.data[i].brandName){
                          brandsData.brandname = brandsData.brandsModel.data[i].id;
                        }
                      }
                    }

                    if(taxData.taxType.toString() == "null"){
                      taxData.taxType = productDetailsData.productDetailsModel.data[0].taxPer;
                      taxData.calc = 100 + double.parse(taxData.taxType);
                      taxData.plus = double.parse(priceController.text) / taxData.calc;
                      taxData.total1 = taxData.plus * 100;
                      taxData.total = taxData.total1.toStringAsFixed(2);
                      taxData.taxamount1 = double.parse(priceController.text) - double.parse(taxData.total);
                      taxData.taxamount = taxData.taxamount1.toStringAsFixed(2);
                      taxData.gst1 = double.parse(taxData.taxamount) / 2;
                      taxData.gst = taxData.gst1.toStringAsFixed(2);
                      taxData.actualprice = taxData.total.toString();
                    }
                    if(specTemplateData.product_id.toString() == "null"){
                      specTemplateData.product_id = productDetailsData.productDetailsModel.data[0].specDetails.data[0].templateId;
                    }

                    if (categoryData.categoryname.toString() == "null") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          content: Text("Please select category."),
                        ),
                      );
                    } else if (brandsData.brandname.toString() == "null") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          content: Text("Please select brand."),
                        ),
                      );
                    } else if (productNameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          content: Text("Please enter product name."),
                        ),
                      );
                    } else if (descriptionController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          content: Text("Please enter description."),
                        ),
                      );
                    } else if (specificationsController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          content: Text("Please enter specifications."),
                        ),
                      );
                    } else if (mrpController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          content: Text("Please enter mrp."),
                        ),
                      );
                    } else if (priceController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          content: Text("Please enter price."),
                        ),
                      );
                    } else if (taxData.taxType.toString() == "null") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          content: Text("Please select tax type."),
                        ),
                      );
                    } else if (taxData.actualprice.toString().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          content: Text("Please select tax type."),
                        ),
                      );
                    } else if (stockController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          content: Text("Please enter stock."),
                        ),
                      );
                    } else if (slnoController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          content: Text("Please enter slno."),
                        ),
                      );
                    } else if (hsncodeController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          content: Text("Please enter HSN code."),
                        ),
                      );
                    } else if (specTemplateitems.isEmpty && specTemplateitemsEdited.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          content: Text("Please enter spec."),
                        ),
                      );
                    } else {

                      print("specTemplateitems : "+JsonEncoder().convert(specTemplateitems));
                      print("specTemplateitemsEdited : "+JsonEncoder().convert(specTemplateitemsEdited));
                      print("spec_template_id : "+specTemplateData.product_id.toString());
                      print("taxamount : "+taxData.taxamount.toString());
                      print("gst : "+taxData.gst.toString());
                      print("cat name : "+categoryData.categoryname.toString());
                      print("brandname : "+brandsData.brandname.toString());
                      print("togetherproductsItems : "+allProductsData.togetherproductsItems.join(', '));

                      try {
                        await data.editProducts(
                          id: productDetailsData.productId,
                          imageList: productDetailsData.imageFileList!,
                          product_name: productNameController.text,
                          specifications: specificationsController.text,
                          descri: descriptionController.text,
                          price: priceController.text,
                          actual_price: taxData.actualprice.toString(),
                          mrp: mrpController.text,
                          hsncode: hsncodeController.text,
                          slno: slnoController.text,
                          brand_id: brandsData.brandname.toString(),
                          taxamount: taxData.taxamount.toString(),
                          tax_per: taxData.taxType.toString(),
                          tax_type: "Include",
                          gst: taxData.gst.toString(),
                          catid: categoryData.categoryname.toString(),
                          stock: stockController.text,
                          together: allProductsData.togetherproductsItems.join(', '),
                          spec_template_id: specTemplateData.product_id.toString(),
                          spec_values: JsonEncoder().convert(specTemplateitems),
                          spec_values_edited: JsonEncoder().convert(specTemplateitemsEdited),
                        );
                      } on Exception {
                        allProductsData.togetherproductsItems.clear();
                        allProductsData.togetherproductsName.clear();
                        specTemplateitems.clear();
                        specTemplateitemsEdited.clear();
                        categoryData.categoryname = null;
                        brandsData.brandname = null;
                        taxData.taxType = null;
                        specTemplateData.product_id = null;
                        specData.product_id = null;
                        allProductsData.togetherproducts = null;
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return SuccessDialog(
                                message: "Product edited successfully",
                                onOkPressed: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    productDetailsData.imageFileList!.clear();
                                    productsData.notifyListeners();
                                  });
                                  Navigator.pop(context);
                                },
                              );
                            }));
                      } catch (e) {
                        allProductsData.togetherproductsItems.clear();
                        allProductsData.togetherproductsName.clear();
                        specTemplateitems.clear();
                        specTemplateitemsEdited.clear();
                        categoryData.categoryname = null;
                        brandsData.brandname = null;
                        taxData.taxType = null;
                        specTemplateData.product_id = null;
                        allProductsData.togetherproducts = null;
                        specData.product_id = null;
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return SuccessDialog(
                                message: "Product edited successfully",
                                onOkPressed: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    productDetailsData.imageFileList!.clear();
                                    productsData.notifyListeners();
                                  });
                                  Navigator.pop(context);
                                },
                              );
                            }));
                      }


                      if (data.editProductModel.status == "200") {

                        allProductsData.togetherproductsItems.clear();
                        allProductsData.togetherproductsName.clear();
                        specTemplateitems.clear();
                        specTemplateitemsEdited.clear();
                        categoryData.categoryname = null;
                        brandsData.brandname = null;
                        taxData.taxType = null;
                        specTemplateData.product_id = null;
                        allProductsData.togetherproducts = null;
                        specData.product_id = null;

                        showDialog(
                            context: context,
                            builder: ((context) {
                              return SuccessDialog(
                                message: "Product edited successfully",
                                onOkPressed: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    productDetailsData.imageFileList!.clear();
                                    productsData.notifyListeners();
                                  });
                                  Navigator.pop(context);
                                },
                              );
                            }));
                      } else {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                            content:
                            Text("Upload failed.Please try again later."),
                          ),
                        );
                      }
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Add images to upload"),
                      ),
                    );
                  }
                },
                color: productDetailsData.imageFileList!.isNotEmpty ? primaryColor : Colors.grey,
                child: Text(
                  "Edit",
                  style: GoogleFonts.openSans(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2),
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}
