import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kaveri/common/error_handle.dart';
import 'package:kaveri/common/header.dart';
import 'package:kaveri/constants/api_url.dart';


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
