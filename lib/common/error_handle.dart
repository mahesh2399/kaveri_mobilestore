import 'package:dio/dio.dart';

httpErrorHandle({
  required Response res,
  required Function onsuccess,
}) {
  switch (res.statusCode) {
    case 200:
      onsuccess();  
      break;
    case 201:
      onsuccess();
      break;
      // throw decryptedData["message"].toString();
    // showSnackbarBottom(context, decryptedData["message"]);
    // break;
    case 307:
      throw res.data["messages"].toString();
    // showSnackbarBottom(context, decryptedData["messages"]);
    // break;
    case 400:
      throw res.data["messages"].toString();
    // showSnackbarBottom(context, res.data["messages"]);
    // break;
    case 401:
      throw res.data["messages"].toString();
    // showSnackbarBottom(context, res.data["messages"]);
    // break;
    case 403:
      throw res.data["messages"].toString();
    // showSnackbarBottom(context, res.data["messages"]);
    // break;
    case 500:
      throw res.data["messages"] ?? res.data["error"];
    // showSnackbarBottom(context, res.data["messages"]);
    // break;
    default:
      throw res.data["messages"] ?? "An error occured";
    // showSnackbarBottom(context, "An error occured");
  }
}
