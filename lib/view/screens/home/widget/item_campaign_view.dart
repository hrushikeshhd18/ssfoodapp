import 'package:efood_multivendor/controller/campaign_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/controller/theme_controller.dart';
import 'package:efood_multivendor/helper/date_converter.dart';
import 'package:efood_multivendor/helper/price_converter.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/custom_image.dart';
import 'package:efood_multivendor/view/base/discount_tag.dart';
import 'package:efood_multivendor/view/base/not_available_widget.dart';
import 'package:efood_multivendor/view/base/product_bottom_sheet.dart';
import 'package:efood_multivendor/view/base/rating_bar.dart';
import 'package:efood_multivendor/view/base/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:get/get.dart';

class ItemCampaignView extends StatelessWidget {
  final CampaignController campaignController;
  ItemCampaignView({@required this.campaignController});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
          child: TitleWidget(title: 'campaigns'.tr, onTap: () => Get.toNamed(RouteHelper.getItemCampaignRoute())),
        ),

        SizedBox(
          height: 80,
          child: campaignController.itemCampaignList != null ? ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
            itemCount: campaignController.itemCampaignList.length > 5 ? 5 : campaignController.itemCampaignList.length,
            itemBuilder: (context, index){
              bool _isAvailable = DateConverter.isAvailable(
                campaignController.itemCampaignList[index].availableTimeStarts,
                campaignController.itemCampaignList[index].availableTimeEnds,
              ) && DateConverter.isAvailable(
                campaignController.itemCampaignList[index].restaurantOpeningTime,
                campaignController.itemCampaignList[index].restaurantClosingTime,
              );

              return Padding(
                padding: EdgeInsets.fromLTRB(2, 2, Dimensions.PADDING_SIZE_SMALL, 2),
                child: InkWell(
                  onTap: () {
                    ResponsiveHelper.isMobile(context) ? Get.bottomSheet(
                      ProductBottomSheet(product: campaignController.itemCampaignList[index], isCampaign: true),
                      backgroundColor: Colors.transparent, isScrollControlled: true,
                    ) : Get.dialog(
                      Dialog(child: ProductBottomSheet(product: campaignController.itemCampaignList[index], isCampaign: true)),
                    );
                  },
                  child: Container(
                    height: 80, width: 200,
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                      boxShadow: [BoxShadow(
                        color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
                        blurRadius: 5, spreadRadius: 1,
                      )],
                    ),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [

                      Stack(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                          child: CustomImage(
                            image: '${Get.find<SplashController>().configModel.baseUrls.campaignImageUrl}'
                                '/${campaignController.itemCampaignList[index].image}',
                            height: 70, width: 70, fit: BoxFit.cover,
                          ),
                        ),
                        DiscountTag(
                          discount: campaignController.itemCampaignList[index].discount,
                          discountType: campaignController.itemCampaignList[index].discountType,
                        ),
                        _isAvailable ? SizedBox() : NotAvailableWidget(),
                      ]),

                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text(
                              campaignController.itemCampaignList[index].name,
                              style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                              maxLines: 1, overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                            Text(
                              campaignController.itemCampaignList[index].restaurantName,
                              style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor),
                              maxLines: 1, overflow: TextOverflow.ellipsis,
                            ),

                            RatingBar(
                              rating: campaignController.itemCampaignList[index].avgRating, size: 12,
                              ratingCount: campaignController.itemCampaignList[index].ratingCount,
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    PriceConverter.convertPrice(campaignController.itemCampaignList[index].price, asFixed: 1),
                                    style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall),
                                  ),
                                ),
                                Icon(Icons.add, size: 20),
                              ],
                            ),
                          ]),
                        ),
                      ),

                    ]),
                  ),
                ),
              );
            },
          ) : ItemCampaignShimmer(campaignController: campaignController),
        ),
      ],
    );
  }
}

class ItemCampaignShimmer extends StatelessWidget {
  final CampaignController campaignController;
  ItemCampaignShimmer({@required this.campaignController});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
      itemCount: 10,
      itemBuilder: (context, index){
        return Container(
          height: 80, width: 200,
          margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            boxShadow: [BoxShadow(color: Colors.grey[300], blurRadius: 10, spreadRadius: 1)],
          ),
          child: Shimmer(
            duration: Duration(seconds: 1),
            interval: Duration(seconds: 1),
            enabled: campaignController.itemCampaignList == null,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [

              Container(
                height: 70, width: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                    color: Colors.grey[300]
                ),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(height: 15, width: 100, color: Colors.grey[300]),
                    SizedBox(height: 5),

                    Container(height: 10, width: 130, color: Colors.grey[300]),
                    SizedBox(height: 5),

                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Container(height: 10, width: 30, color: Colors.grey[300]),
                      RatingBar(rating: 0.0, size: 12, ratingCount: 0),
                    ]),
                  ]),
                ),
              ),

            ]),
          ),
        );
      },
    );
  }
}

