import 'package:get/get.dart';
import 'package:user_login/users/model/user.dart';
import 'package:user_login/users/userPreferances/user_preferences.dart';

class CurrentUser extends GetxController {
  Rx<User> _currentUser = User(0, '', '', '').obs;

  User get user => _currentUser.value;

  getUserInfo() async {
    User? getUserInofFromLocalStorage = await RememberUserPrefs.readUserInfo();
    _currentUser.value = getUserInofFromLocalStorage!;
  }
}
