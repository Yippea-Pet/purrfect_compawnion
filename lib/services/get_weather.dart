import 'package:http/http.dart';
import 'package:location/location.dart';

class Weather {
  Location location = new Location();
  String APP_ID = '397ae723cbabc3756170e7a70b4c8869';

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  Future getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    print(_locationData.latitude);
  }

  Future getWeather() async {
    try {
      // Response response = await get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=Singapore&appid=397ae723cbabc3756170e7a70b4c8869'));
      // Response response = await get(Uri.parse('https://api.openweathermap.org/data/2.5/forecast?lat=${_locationData.latitude}&lon=${_locationData.longitude}&appid=${APP_ID}'));
      Response response = await get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=${_locationData.latitude}&lon=${_locationData.longitude}&appid=${APP_ID}'));

      print(response.body);
      print(_locationData);
    } catch(e) {
      print(e);
    }
  }
}