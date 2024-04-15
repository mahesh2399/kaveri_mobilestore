// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kaveri/common/error_handle.dart';
import 'package:kaveri/common/header.dart';
import 'package:kaveri/constants/api_url.dart';
import 'package:kaveri/products/product_model/product_model.dart';

Future<EitherData<List<UserDetailModel>>> getDirectorsData({
  required String searchQuery,
}) async {
  List<UserDetailModel> userDataList = [];
  try {
    Dio dio = Dio();
    Response rawData = await dio.get(
      '$kbaseUrl/admin/SearchUsers', //admin/SearchUsers?searchString=deep
      queryParameters: {"searchString": searchQuery},
      options: Options(
        validateStatus: (status) => true,
      ),
    );
    httpErrorHandle(
      res: rawData,
      onsuccess: () async {
        for (var element in rawData.data['data']) {
          userDataList.add(UserDetailModel(
              userId: element['id'],
              mobileNumber: element['phone'],
              emailAddress: element['email'],
              name: element['name']));
        }
      },
    );
    return right(userDataList);
  } on DioException {
    return left('Something went wrong');
  } catch (e) {
    return left(e.toString());
  }
}

placeOrder(
    {required List<Product> productId,
    required String userID,
    required String phone,
    required String altNumber,
    required String subTotalAmount,
    required String totalTax,
    required String grandTotal,
    required String totalShippinCost,
    required String paymmentStatus,
    required String payentMethod}) async {
  Dio dio = Dio();

  final body = {
    "user_id": 5,
    "phone": phone,
    "alternative_phone_no": altNumber,
    "sub_total_amount": subTotalAmount,
    "total_tax": totalTax,
    "total_discount": 34,
    "grand_total": grandTotal,
    "total_shipping_cost": totalShippinCost,
    "payment_method": "Cash On Delivery",
    "payment_status": "Paid",
    "shipping_address_id": 1,
    "billing_address_id": 1,
    "products": [
      {
        "product_id": 4,
        "qty": 3,
        "product_variation_id": 4,
        "location_id": 3,
        "unit_price": 200,
        "total_price": 600,
        "tax_id": 1,
        "discount_percentage": 3,
        "tax_percentage": 4,
        "unit_id": 2
      }
    ]
  };

  Response rawData = await dio.post(
    '$kbaseUrl/admin/SearchUsers', //admin/SearchUsers?searchString=deep
    data: body,
    options: Options(
      validateStatus: (status) => true,
    ),
  );
  httpErrorHandle(
    res: rawData,
    onsuccess: () async {},
  );
}

Future<bool> createNewCustomer(
    {required String name,
    required String email,
    required String number,
    required String address}) async {
  Dio dio = Dio();
  final body = {
    "name": name,
    "phone": number,
    "email": email,
    "address": address
  };
  Response rawData = await dio.post(
    data: body,
    '$kbaseUrl/admin/usercreate', //admin/SearchUsers?searchString=deep

    options: Options(
      validateStatus: (status) => true,
    ),
  );
  log("${rawData.data}datatadaata");
  if (rawData.statusCode == 200) {
    return true;
  }

  return false;
}

class UserDetailModel {
  final String userId;
  final String mobileNumber;
  final String emailAddress;
  final String name;

  UserDetailModel(
      {required this.userId,
      required this.mobileNumber,
      required this.emailAddress,
      required this.name});
}
