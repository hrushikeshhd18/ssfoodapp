import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/category_controller.dart';
import 'package:efood_multivendor/controller/restaurant_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/controller/wishlist_controller.dart';
import 'package:efood_multivendor/data/model/response/address_model.dart';
import 'package:efood_multivendor/data/model/response/category_model.dart';
import 'package:efood_multivendor/data/model/response/product_model.dart';
import 'package:efood_multivendor/data/model/response/restaurant_model.dart';
import 'package:efood_multivendor/helper/date_converter.dart';
import 'package:efood_multivendor/helper/price_converter.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/cart_widget.dart';
import 'package:efood_multivendor/view/base/custom_image.dart';
import 'package:efood_multivendor/view/base/custom_snackbar.dart';
import 'package:efood_multivendor/view/base/product_view.dart';
import 'package:efood_multivendor/view/base/web_menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantScreen extends StatelessWidget {
  final Restaurant restaurant;
  RestaurantScreen({@required this.restaurant});

  @override
  Widget build(BuildContext context) {
    Get.find<RestaurantController>().getRestaurantDetails(restaurant);
    if(Get.find<CategoryController>().categoryList == null) {
      Get.find<CategoryController>().getCategoryList(true);
    }
    Get.find<RestaurantController>().getRestaurantProductList(restaurant.id.toString());

    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context) ? WebMenuBar() : null,
      backgroundColor: Theme.of(context).cardColor,
      body: GetBuilder<RestaurantController>(builder: (restController) {
        return GetBuilder<CategoryController>(builder: (categoryController) {
          List<CategoryProduct> _categoryProducts = [];
          Restaurant _restaurant;
          if(restController.restaurant != null && restController.restaurant.name != null && categoryController.categoryList != null) {
            _restaurant = restController.restaurant;
          }
          if(categoryController.categoryList != null && restController.restaurantProducts != null) {
            _categoryProducts.add(CategoryProduct(CategoryModel(name: 'all'.tr), restController.restaurantProducts));
            List<int> _categorySelectedIds = [];
            List<int> _categoryIds = [];
            categoryController.categoryList.forEach((category) {
              _categoryIds.add(category.id);
            });
            _categorySelectedIds.add(0);
            restController.restaurantProducts.forEach((restProd) {
              if(!_categorySelectedIds.contains(int.parse(restProd.categoryIds[0].id))) {
                _categorySelectedIds.add(int.parse(restProd.categoryIds[0].id));
                _categoryProducts.add(CategoryProduct(
                  categoryController.categoryList[_categoryIds.indexOf(int.parse(restProd.categoryIds[0].id))],
                  [restProd],
                ));
              }else {
                int _index = _categorySelectedIds.indexOf(int.parse(restProd.categoryIds[0].id));
                _categoryProducts[_index].products.add(restProd);
              }
            });
          }

          return (restController.restaurant != null && restController.restaurant.name != null && categoryController.categoryList != null) ? CustomScrollView(
            slivers: [

              ResponsiveHelper.isDesktop(context) ? SliverToBoxAdapter(
                child: Container(
                  color: Color(0xFF171A29),
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                    child: CustomImage(
                      fit: BoxFit.cover, placeholder: Images.restaurant_cover, height: 220, width: 1150,
                      image: '${Get.find<SplashController>().configModel.baseUrls.restaurantCoverPhotoUrl}/${_restaurant.coverPhoto}',
                    ),
                  ),
                ),
              ) : SliverAppBar(
                expandedHeight: 230, toolbarHeight: 50,
                pinned: true, floating: false,
                backgroundColor: Theme.of(context).primaryColor,
                leading: IconButton(
                  icon: Container(
                    height: 50, width: 50,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                    alignment: Alignment.center,
                    child: Icon(Icons.chevron_left, color: Theme.of(context).cardColor),
                  ),
                  onPressed: () => Get.back(),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: CustomImage(
                    fit: BoxFit.cover, placeholder: Images.restaurant_cover,
                    image: '${Get.find<SplashController>().configModel.baseUrls.restaurantCoverPhotoUrl}/${_restaurant.coverPhoto}',
                  ),
                ),
                actions: [IconButton(
                  onPressed: () => Get.toNamed(RouteHelper.getCartRoute()),
                  icon: Container(
                    height: 50, width: 50,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                    alignment: Alignment.center,
                    child: CartWidget(color: Theme.of(context).cardColor, size: 15, fromRestaurant: true),
                  ),
                )],
              ),

              SliverToBoxAdapter(child: Center(child: Container(
                width: Dimensions.WEB_MAX_WIDTH,
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                color: Theme.of(context).cardColor,
                child: Column(children: [
                  Row(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                      child: CustomImage(
                        image: '${Get.find<SplashController>().configModel.baseUrls.restaurantImageUrl}/${_restaurant.logo}',
                        height: 40, width: 50, fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(
                        _restaurant.name, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                        maxLines: 1, overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        _restaurant.address ?? '', maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                      ),
                    ])),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    GetBuilder<WishListController>(builder: (wishController) {
                      bool _isWished = wishController.wishRestIdList.contains(restaurant.id);
                      return InkWell(
                        onTap: () {
                          if(Get.find<AuthController>().isLoggedIn()) {
                            _isWished ? wishController.removeFromWishList(_restaurant.id, true)
                                : wishController.addToWishList(null, _restaurant, true);
                          }else {
                            showCustomSnackBar('you_are_not_logged_in'.tr);
                          }
                        },
                        child: Icon(
                          _isWished ? Icons.favorite : Icons.favorite_border,
                          color: _isWished ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
                        ),
                      );
                    }),
                  ]),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                  _restaurant.openingTime != null ? Row(children: [
                    Text('daily_time'.tr, style: robotoRegular.copyWith(
                      fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor,
                    )),
                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Text(
                      '${DateConverter.convertTimeToTime(_restaurant.openingTime)}'
                          ' - ${DateConverter.convertTimeToTime(_restaurant.closeingTime)}',
                      style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).primaryColor),
                    ),
                  ]) : SizedBox(),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                  Row(children: [
                    Icon(Icons.star, color: Theme.of(context).primaryColor, size: 18),
                    Text(
                      _restaurant.avgRating.toStringAsFixed(1),
                      style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                    ),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    Text(
                      '${_restaurant.ratingCount} ${'ratings'.tr}',
                      style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor),
                    ),
                  ]),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                  _restaurant.discount != null ? Container(
                    width: context.width,
                    margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL), color: Theme.of(context).primaryColor),
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        _restaurant.discount.discountType == 'percent' ? '${_restaurant.discount.discount}% OFF'
                            : '${PriceConverter.convertPrice(_restaurant.discount.discount)} OFF',
                        style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).cardColor),
                      ),
                      Text(
                        _restaurant.discount.discountType == 'percent'
                            ? '${'enjoy'.tr} ${_restaurant.discount.discount}% ${'off_on_all_categories'.tr}'
                            : '${'enjoy'.tr} ${PriceConverter.convertPrice(_restaurant.discount.discount)}'
                            ' ${'off_on_all_categories'.tr}',
                        style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).cardColor),
                      ),
                      SizedBox(height: (_restaurant.discount.minPurchase != 0 || _restaurant.discount.maxDiscount != 0) ? 5 : 0),
                      _restaurant.discount.minPurchase != 0 ? Text(
                        '[ ${'minimum_purchase'.tr}: ${PriceConverter.convertPrice(_restaurant.discount.minPurchase)} ]',
                        style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).cardColor),
                      ) : SizedBox(),
                      _restaurant.discount.maxDiscount != 0 ? Text(
                        '[ ${'maximum_discount'.tr}: ${PriceConverter.convertPrice(_restaurant.discount.maxDiscount)} ]',
                        style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).cardColor),
                      ) : SizedBox(),
                    ]),
                  ) : SizedBox(),

                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    InkWell(
                      onTap: () => Get.toNamed(RouteHelper.getMapRoute(
                        AddressModel(
                          id: _restaurant.id, address: _restaurant.address, latitude: _restaurant.latitude,
                          longitude: _restaurant.longitude, contactPersonNumber: '', contactPersonName: '', addressType: '',
                        ), 'restaurant',
                      )),
                      child: Row(children: [
                        Icon(Icons.location_on, color: Theme.of(context).primaryColor, size: 20),
                        SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Text('location'.tr, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
                      ]),
                    ),
                    (_restaurant.delivery && _restaurant.freeDelivery) ? Text(
                      'free_delivery'.tr,
                      style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
                    ) : SizedBox(),
                  ]),
                ]),
              ))),

              (categoryController.categoryList.length != 0 && restController.restaurantProducts != null) ? SliverPersistentHeader(
                pinned: true,
                delegate: SliverDelegate(child: Center(child: Container(
                  height: 50, width: Dimensions.WEB_MAX_WIDTH, color: Theme.of(context).cardColor,
                  padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categoryProducts.length,
                    padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => restController.setCategoryIndex(index),
                        child: Container(
                          padding: EdgeInsets.only(
                            left: index == 0 ? Dimensions.PADDING_SIZE_LARGE : Dimensions.PADDING_SIZE_SMALL,
                            right: index == _categoryProducts.length-1 ? Dimensions.PADDING_SIZE_LARGE : Dimensions.PADDING_SIZE_SMALL,
                            top: Dimensions.PADDING_SIZE_SMALL,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(index == 0 ? Dimensions.RADIUS_EXTRA_LARGE : 0),
                              right: Radius.circular(index == _categoryProducts.length-1 ? Dimensions.RADIUS_EXTRA_LARGE : 0),
                            ),
                            color: Theme.of(context).primaryColor.withOpacity(0.1),
                          ),
                          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                            SizedBox(height: ResponsiveHelper.isDesktop(context) ? 0 : 2),
                            Text(
                              _categoryProducts[index].category.name,
                              style: index == restController.categoryIndex
                                  ? robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor)
                                  : robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                            ),
                            index == restController.categoryIndex ? Container(
                              height: 5, width: 5,
                              decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
                            ) : SizedBox(height: 5, width: 5),
                          ]),
                        ),
                      );
                    },
                  ),
                ))),
              ) : SliverToBoxAdapter(child: SizedBox()),

              SliverToBoxAdapter(child: Center(child: Container(
                width: Dimensions.WEB_MAX_WIDTH,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                ),
                child: ProductView(
                  isRestaurant: false, restaurants: null,
                  products: _categoryProducts.length > 0 ? _categoryProducts[restController.categoryIndex].products : null,
                  inRestaurantPage: true,
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_SMALL,
                    vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_SMALL : 0,
                  ),
                ),
              ))),
            ],
          ) : Center(child: CircularProgressIndicator());
        });
      }),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegate({@required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 || oldDelegate.minExtent != 50 || child != oldDelegate.child;
  }
}

class CategoryProduct {
  CategoryModel category;
  List<Product> products;
  CategoryProduct(this.category, this.products);
}
