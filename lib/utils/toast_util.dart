import 'package:oktoast/oktoast.dart';

class ToastUtil {
  static toast(final String text) {
    if (text != null && text.length != 0 && text != 'null') {
      showToast(text, duration: Duration(seconds: 2));
    }
  }
}
