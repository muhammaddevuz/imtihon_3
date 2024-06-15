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

  Future<void> editUser(String id, String name, String birthday) async {
    await userHttpServices.editUser(id, name, birthday);
  }

  Future<void> addComment(String comment, String hotelId) async {
    await userHttpServices.addComment(comment, hotelId);
  }

  Future<void> addOrderedHotel(String userId, String hotelId) async {
    await userHttpServices.addOrderedHotel(userId, hotelId);
  }
}
