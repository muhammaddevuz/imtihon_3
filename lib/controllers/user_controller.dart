import 'package:imtihon3/models/hotel.dart';
import 'package:imtihon3/models/user.dart';
import 'package:imtihon3/services/user_http_services.dart';

class UserController {
  UserHttpServices userHttpServices = UserHttpServices();
  Future<void> addUser(String email, String userId) async {
    await userHttpServices.addUser(email, userId);
  }

  Future<User> getUser() async {
    User box = await userHttpServices.getUser();
    return box;
  }
  Future<List<Hotel>> fetchUser(String userId) async {
    List<Hotel> box = await userHttpServices.fetchUser(userId);
    return box;
  }
  Future<void> editUser(String id,String name,String birthday) async {
    await userHttpServices.editUser(id, name, birthday);
  }
  
}
