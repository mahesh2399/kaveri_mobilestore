import 'package:connectivity_plus/connectivity_plus.dart';

class CheckInternetForApi {
  Future<bool> chechInternet() async {
    bool isConnected = true;
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
    }
    return isConnected;
  }
}
