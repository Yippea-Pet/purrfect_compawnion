import 'dart:convert';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import '../../services/get_weather.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  late Weather weather;
  final String APP_ID = '397ae723cbabc3756170e7a70b4c8869';
  Location location = Location();

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          child: Text("THIS IS WEATHER PAGE!!"),
        ),
      ),
    );
  }



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
  }

  Future getWeather() async {
    try {
      await getLocation();
      Response response = await get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=${_locationData.latitude}&lon=${_locationData.longitude}&appid=${APP_ID}'));
      Map data = jsonDecode(response.body);

      var weatherData = jsonDecode(jsonEncode(data['weather'][0]));
      print("weatherData");
      var mainData = jsonDecode(jsonEncode(data['main']));
      print("main");
      var sysData = jsonDecode(jsonEncode(data['sys']));
      print("sys");

      weather = Weather(
        id: weatherData['id'],
        main: weatherData['main'],
        description: weatherData['description'],
        icon: weatherData['icon'],
        temp: mainData['temp'],
        temp_min: mainData['temp_min'],
        temp_max: mainData['temp_max'],
        country: sysData['country'],
        sunrise: DateTime.fromMillisecondsSinceEpoch(sysData['sunrise'] * 1000),
        sunset: DateTime.fromMillisecondsSinceEpoch(sysData['sunset'] * 1000),
        city: data['name'],
      );

    } catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${e}")));
    }
  }
}
