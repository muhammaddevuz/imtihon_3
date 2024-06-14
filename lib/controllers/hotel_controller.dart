import 'package:imtihon3/models/hotel.dart';
import 'package:imtihon3/services/auth_http_services.dart';

class HotelController {
  AuthHttpServices authHttpServices = AuthHttpServices();
  Future<List<Hotel>> getHotels() async {
    return authHttpServices.getHotels();
  }
}