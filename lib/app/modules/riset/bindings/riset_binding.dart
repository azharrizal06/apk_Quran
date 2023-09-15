import 'package:get/get.dart';

import '../controllers/riset_controller.dart';

class RisetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RisetController>(
      () => RisetController(),
    );
  }
}
