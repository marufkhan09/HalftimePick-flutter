import 'package:get/get.dart';
import 'package:halftimepick/controllers/base_api_controller.dart';
import 'package:halftimepick/utils/shared_pref.dart';

class SplashController extends BaseApiController {
  final SharedPref sharedPref = SharedPref();
  RxInt currentBottom = 0.obs;
  RxString currentGame = "".obs;
  RxInt selectedGameIndex = 0.obs;

  String getname() {
    var a = currentGame.value;
    update();
    return a;
  }
}
