
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:kaveri/constants/network/bloc/network_bloc.dart';


// class NetworkHelper {

//   static void observeNetwork() {
//     Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//       if (result == ConnectivityResult.none) {
//         NetworkBloc().add(NetworkNotify());
//       } else {
//         NetworkBloc().add(NetworkNotify(isConnected: true));
//       }
//     });
//   }
// }



class NetworkHelper {
  static void observeNetwork() {
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
  
      ConnectivityResult result = results.last;

      if (result == ConnectivityResult.none) {
        NetworkBloc().add(NetworkNotify(isConnected: false));
      } else {
        NetworkBloc().add(NetworkNotify(isConnected: true));
      }
    });
  }
}
