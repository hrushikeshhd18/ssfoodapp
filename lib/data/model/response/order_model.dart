import 'package:efood_multivendor/data/model/response/address_model.dart';
import 'package:efood_multivendor/data/model/response/restaurant_model.dart';

class OrderModel {
  int _id;
  int _userId;
  double _orderAmount;
  double _couponDiscountAmount;
  String _couponDiscountTitle;
  String _paymentStatus;
  String _orderStatus;
  double _totalTaxAmount;
  String _paymentMethod;
  String _createdAt;
  String _updatedAt;
  double _deliveryCharge;
  String _orderNote;
  DeliveryMan _deliveryMan;
  int _detailsCount;
  int _scheduled;
  String _scheduleAt;
  String _orderType;
  String _otp;
  String _pending;
  String _accepted;
  String _confirmed;
  String _processing;
  String _handover;
  String _pickedUp;
  String _delivered;
  String _canceled;
  String _refundRequested;
  String _refunded;
  Restaurant _restaurant;
  AddressModel _deliveryAddress;

  OrderModel(
      {int id,
        int userId,
        double orderAmount,
        double couponDiscountAmount,
        String couponDiscountTitle,
        String paymentStatus,
        String orderStatus,
        double totalTaxAmount,
        String paymentMethod,
        String transactionReference,
        String createdAt,
        String updatedAt,
        String checked,
        double deliveryCharge,
        String orderNote,
        DeliveryMan deliveryMan,
        int detailsCount,
        int scheduled,
        String scheduleAt,
        String orderType,
        String otp,
        String pending,
        String accepted,
        String confirmed,
        String processing,
        String handover,
        String pickedUp,
        String delivered,
        String canceled,
        String refundRequested,
        String refunded,
        Restaurant restaurant,
        AddressModel deliveryAddress,
      }) {
    this._id = id;
    this._userId = userId;
    this._orderAmount = orderAmount;
    this._couponDiscountAmount = couponDiscountAmount;
    this._couponDiscountTitle = couponDiscountTitle;
    this._paymentStatus = paymentStatus;
    this._orderStatus = orderStatus;
    this._totalTaxAmount = totalTaxAmount;
    this._paymentMethod = paymentMethod;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._deliveryCharge = deliveryCharge;
    this._orderNote = orderNote;
    this._deliveryMan = deliveryMan;
    this._detailsCount = detailsCount;
    this._scheduled = scheduled;
    this._scheduleAt = scheduleAt;
    this._orderType = orderType;
    this._otp = otp;
    this._pending = pending;
    this._accepted = accepted;
    this._confirmed = confirmed;
    this._processing = processing;
    this._handover = handover;
    this._pickedUp = pickedUp;
    this._delivered = delivered;
    this._canceled = canceled;
    this._refundRequested = refundRequested;
    this._refunded = refunded;
    this._restaurant = restaurant;
    this._deliveryAddress = deliveryAddress;
  }

  int get id => _id;
  int get userId => _userId;
  double get orderAmount => _orderAmount;
  double get couponDiscountAmount => _couponDiscountAmount;
  String get couponDiscountTitle => _couponDiscountTitle;
  String get paymentStatus => _paymentStatus;
  String get orderStatus => _orderStatus;
  double get totalTaxAmount => _totalTaxAmount;
  // ignore: unnecessary_getters_setters
  String get paymentMethod => _paymentMethod;
  // ignore: unnecessary_getters_setters
  set paymentMethod(String method) => _paymentMethod = method;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  double get deliveryCharge => _deliveryCharge;
  String get orderNote => _orderNote;
  DeliveryMan get deliveryMan => _deliveryMan;
  int get detailsCount => _detailsCount;
  int get scheduled => _scheduled;
  String get scheduleAt => _scheduleAt;
  String get orderType => _orderType;
  String get otp => _otp;
  String get pending => _pending;
  String get accepted => _accepted;
  String get confirmed => _confirmed;
  String get processing => _processing;
  String get handover => _handover;
  String get pickedUp => _pickedUp;
  String get delivered => _delivered;
  String get canceled => _canceled;
  String get refundRequested => _refundRequested;
  String get refunded => _refunded;
  Restaurant get restaurant => _restaurant;
  AddressModel get deliveryAddress => _deliveryAddress;

  OrderModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _orderAmount = json['order_amount'].toDouble();
    _couponDiscountAmount = json['coupon_discount_amount'].toDouble();
    _couponDiscountTitle = json['coupon_discount_title'];
    _paymentStatus = json['payment_status'];
    _orderStatus = json['order_status'];
    _totalTaxAmount = json['total_tax_amount'].toDouble();
    _paymentMethod = json['payment_method'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deliveryCharge = json['delivery_charge'].toDouble();
    _orderNote = json['order_note'];
    _detailsCount = json['details_count'];
    _scheduled = json['scheduled'];
    _scheduleAt = json['schedule_at'];
    _deliveryMan = json['delivery_man'] != null
        ? new DeliveryMan.fromJson(json['delivery_man'])
        : null;
    _orderType = json['order_type'];
    _otp = json['otp'];
    _pending = json['pending'];
    _accepted = json['accepted'];
    _confirmed = json['confirmed'];
    _processing = json['processing'];
    _handover = json['handover'];
    _pickedUp = json['picked_up'];
    _delivered = json['delivered'];
    _canceled = json['canceled'];
    _refundRequested = json['refund_requested'];
    _refunded = json['refunded'];
    _restaurant = json['restaurant'] != null
        ? new Restaurant.fromJson(json['restaurant'])
        : null;
    _deliveryAddress = json['delivery_address'] != null
        ? new AddressModel.fromJson(json['delivery_address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['user_id'] = this._userId;
    data['order_amount'] = this._orderAmount;
    data['coupon_discount_amount'] = this._couponDiscountAmount;
    data['coupon_discount_title'] = this._couponDiscountTitle;
    data['payment_status'] = this._paymentStatus;
    data['order_status'] = this._orderStatus;
    data['total_tax_amount'] = this._totalTaxAmount;
    data['payment_method'] = this._paymentMethod;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['delivery_charge'] = this._deliveryCharge;
    data['order_note'] = this._orderNote;
    data['details_count'] = this._detailsCount;
    data['scheduled'] = this._scheduled;
    data['schedule_at'] = this._scheduleAt;
    if (this._deliveryMan != null) {
      data['delivery_man'] = this._deliveryMan.toJson();
    }
    data['order_type'] = this._orderType;
    data['otp'] = this._otp;
    data['pending'] = this._pending;
    data['accepted'] = this._accepted;
    data['confirmed'] = this._confirmed;
    data['processing'] = this._processing;
    data['handover'] = this._handover;
    data['picked_up'] = this._pickedUp;
    data['delivered'] = this._delivered;
    data['canceled'] = this._canceled;
    data['refund_requested'] = this._refundRequested;
    data['refunded'] = this._refunded;
    if (this._restaurant != null) {
      data['restaurant'] = this._restaurant.toJson();
    }
    if (this._deliveryAddress != null) {
      data['delivery_address'] = this._deliveryAddress.toJson();
    }
    return data;
  }
}

class Details {
  int _id;
  int _productId;
  int _orderId;
  double _price;
  String _productDetails;
  String _variation;
  double _discountOnProduct;
  String _discountType;
  int _quantity;
  double _taxAmount;
  String _createdAt;
  String _updatedAt;
  String _addOnIds;
  String _variant;

  Details(
      {int id,
        int productId,
        int orderId,
        double price,
        String productDetails,
        String variation,
        double discountOnProduct,
        String discountType,
        int quantity,
        double taxAmount,
        String createdAt,
        String updatedAt,
        String addOnIds,
        String variant}) {
    this._id = id;
    this._productId = productId;
    this._orderId = orderId;
    this._price = price;
    this._productDetails = productDetails;
    this._variation = variation;
    this._discountOnProduct = discountOnProduct;
    this._discountType = discountType;
    this._quantity = quantity;
    this._taxAmount = taxAmount;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._addOnIds = addOnIds;
    this._variant = variant;
  }

  int get id => _id;
  int get productId => _productId;
  int get orderId => _orderId;
  double get price => _price;
  String get productDetails => _productDetails;
  String get variation => _variation;
  double get discountOnProduct => _discountOnProduct;
  String get discountType => _discountType;
  int get quantity => _quantity;
  double get taxAmount => _taxAmount;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get addOnIds => _addOnIds;
  String get variant => _variant;

  Details.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _productId = json['product_id'];
    _orderId = json['order_id'];
    _price = json['price'].toDouble();
    _productDetails = json['product_details'];
    _variation = json['variation'];
    _discountOnProduct = json['discount_on_food'].toDouble();
    _discountType = json['discount_type'];
    _quantity = json['quantity'];
    _taxAmount = json['tax_amount'].toDouble();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _addOnIds = json['add_on_ids'];
    _variant = json['variant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['product_id'] = this._productId;
    data['order_id'] = this._orderId;
    data['price'] = this._price;
    data['product_details'] = this._productDetails;
    data['variation'] = this._variation;
    data['discount_on_food'] = this._discountOnProduct;
    data['discount_type'] = this._discountType;
    data['quantity'] = this._quantity;
    data['tax_amount'] = this._taxAmount;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['add_on_ids'] = this._addOnIds;
    data['variant'] = this._variant;
    return data;
  }
}

class DeliveryMan {
  int id;
  String fName;
  String lName;
  String phone;
  String email;
  String image;
  int zoneId;
  int active;
  int available;
  double avgRating;
  int ratingCount;
  String lat;
  String lng;
  String location;

  DeliveryMan(
      {this.id,
        this.fName,
        this.lName,
        this.phone,
        this.email,
        this.image,
        this.zoneId,
        this.active,
        this.available,
        this.avgRating,
        this.ratingCount,
        this.lat,
        this.lng,
        this.location
      });

  DeliveryMan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    zoneId = json['zone_id'];
    active = json['active'];
    available = json['available'];
    avgRating = json['avg_rating'].toDouble();
    ratingCount = json['rating_count'];
    lat = json['lat'];
    lng = json['lng'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['image'] = this.image;
    data['zone_id'] = this.zoneId;
    data['active'] = this.active;
    data['available'] = this.available;
    data['avg_rating'] = this.avgRating;
    data['rating_count'] = this.ratingCount;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['location'] = this.location;
    return data;
  }
}
