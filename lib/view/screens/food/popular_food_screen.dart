import 'package:efood_multivendor/controller/product_controller.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/view/base/custom_app_bar.dart';
import 'package:efood_multivendor/view/base/product_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularFoodScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.find<ProductController>().getPopularProductList(true);

    return Scaffold(
      appBar: CustomAppBar(title: 'popular_foods_nearby'.tr, showCart: true),
      body: Scrollbar(child: SingleChildScrollView(child: Center(child: SizedBox(
        width: Dimensions.WEB_MAX_WIDTH,
        child: GetBuilder<ProductController>(builder: (productController) {
          return ProductView(
            isRestaurant: false, products: productController.popularProductList, restaurants: null,
          );
        }),
      )))),
    );
  }
}
