import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LoaderViewModel extends GetxController {
  bool isActiveLoader = false;

  void showLoader({bool isShowLoader = true}) {
    isActiveLoader = isShowLoader;
    update();
  }
}
