import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  Future<bool?> showToast(String messege) {
    return Fluttertoast.showToast(msg: messege, timeInSecForIosWeb: 2);
  }
}
