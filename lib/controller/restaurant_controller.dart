import 'package:efood_multivendor/controller/order_controller.dart';
import 'package:efood_multivendor/data/api/api_checker.dart';
import 'package:efood_multivendor/data/model/response/product_model.dart';
import 'package:efood_multivendor/data/model/response/restaurant_model.dart';
import 'package:efood_multivendor/data/repository/restaurant_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class RestaurantController extends GetxController implements GetxService {
  final RestaurantRepo restaurantRepo;
  RestaurantController({@required this.restaurantRepo});

  List<Restaurant> _restaurantList;
  Restaurant _restaurant;
  List<Product> _restaurantProducts;
  int _categoryIndex = 0;
  bool _isLoading = false;
  int _popularPageSize;
  List<String> _offsetList = [];
  int _offset = 1;
  String _restaurantType = 'all';

  List<Restaurant> get restaurantList => _restaurantList;
  Restaurant get restaurant => _restaurant;
  List<Product> get restaurantProducts => _restaurantProducts;
  int get categoryIndex => _categoryIndex;
  bool get isLoading => _isLoading;
  int get popularPageSize => _popularPageSize;
  int get offset => _offset;
  String get restaurantType => _restaurantType;

  void setOffset(int offset) {
    _offset = offset;
  }

  Future<void> getRestaurantList(String offset, bool reload) async {
    if(offset == '1' || reload) {
      _offsetList = [];
      _offset = 1;
      if(reload) {
        _restaurantList = null;
      }
      update();
    }
    if (!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      Response response = await restaurantRepo.getRestaurantList(offset, _restaurantType);
      if (response.statusCode == 200) {
        if (offset == '1') {
          _restaurantList = [];
        }
        _restaurantList.addAll(RestaurantModel.fromJson(response.body).restaurants);
        _popularPageSize = RestaurantModel.fromJson(response.body).totalSize;
        _isLoading = false;
        update();
      } else {
        ApiChecker.checkApi(response);
      }
    } else {
      if(isLoading) {
        _isLoading = false;
        update();
      }
    }
  }

  void setRestaurantType(String type) {
    _restaurantType = type;
    getRestaurantList('1', true);
  }

  Future<Restaurant> getRestaurantDetails(Restaurant restaurant) async {
    _categoryIndex = 0;
    if(restaurant.name != null) {
      _restaurant = restaurant;
    }else {
      _isLoading = true;
      _restaurant = null;
      Response response = await restaurantRepo.getRestaurantDetails(restaurant.id.toString());
      if (response.statusCode == 200) {
        _restaurant = Restaurant.fromJson(response.body);
      } else {
        ApiChecker.checkApi(response);
      }
      Get.find<OrderController>().setOrderType(
        _restaurant != null ? _restaurant.delivery ? 'delivery' : 'take_away' : 'delivery', notify: false,
      );

      _isLoading = false;
      update();
    }
    return _restaurant;
  }

  Future<void> getRestaurantProductList(String restaurantID) async {
    _restaurantProducts = null;
    Response response = await restaurantRepo.getRestaurantProductList(restaurantID);
    if (response.statusCode == 200) {
      _restaurantProducts = [];
      _restaurantProducts.addAll(ProductModel.fromJson(response.body).products);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void showBottomLoader() {
    _isLoading = true;
    update();
  }

  void setCategoryIndex(int index) {
    _categoryIndex = index;
    update();
  }
}