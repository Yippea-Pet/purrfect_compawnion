class Weather {
  int id;
  String main;
  String description;
  String icon;
  double temp;
  double temp_min;
  double temp_max;
  String country;
  DateTime sunrise;
  DateTime sunset;
  String city;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
    required this.temp,
    required this.temp_min,
    required this.temp_max,
    required this.country,
    required this.sunrise,
    required this.sunset,
    required this.city,
  });
}
