import 'package:get/get.dart';
import '../controller/quiz_controller.dart';
import '../repository/enrolled_repository.dart';

class QuizBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(QuizController(Get.find<EnrolledDataSource>()));
  }
}