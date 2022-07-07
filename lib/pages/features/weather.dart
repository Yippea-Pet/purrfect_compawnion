import 'package:flutter/material.dart';
import 'package:purrfect_compawnion/services/get_weather.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Weather weather = new Weather();
  @override
  void initState() {
    super.initState();
    weather.getLocation();
    weather.getWeather();
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
}
