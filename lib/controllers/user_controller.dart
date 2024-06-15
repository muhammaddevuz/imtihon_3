import 'package:imtihon3/models/user.dart';
import 'package:imtihon3/services/user_http_services.dart';

class UserController {
  UserHttpServices userHttpServices = UserHttpServices();
  Future<void> addUser(String email, String userId) async {
    await userHttpServices.addUser(email, userId);
  }
  Future<User> fetchUser(String userId)async{
    User user = await userHttpServices.fetchUser(userId);
    return user;
  }
  Future<User> getUser() async {
    User box = await userHttpServices.getUser();
    return box;
  }
  Future<void> editUser(String id,String name,String birthday) async {
    await userHttpServices.editUser(id, name, birthday);
  }
}
