import 'package:commet_sheet/controller/home_screen_controller.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeScreenController());
  }
}
