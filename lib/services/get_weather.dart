import 'package:http/http.dart';

class Weather {
  String location;
  String url;
  
  Weather({ required this.location, required this.url });
  
  Future getWeather() async {
    try {
      Response response = await get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=Singapore&appid=397ae723cbabc3756170e7a70b4c8869'));
      print(response.body);
    } catch(e) {
      print(e);
    }
  }
}