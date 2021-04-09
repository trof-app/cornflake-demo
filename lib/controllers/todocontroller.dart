import 'package:cornflake/services/remoteservices.dart';

import '../models/todomodel.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  var isLoading = true.obs;
  List<Todo> todoList = <Todo>[].obs;

  @override
  void onInit() {
    fetchfinaltodo();
    super.onInit();
  }

  void fetchfinaltodo() async {
    isLoading(true);
    try {
      var todos = await Dataservices.getTodo();
      if (todos != null) {
        todoList = todos;
      }
    } finally {
      isLoading(false);
    }
  }
}
