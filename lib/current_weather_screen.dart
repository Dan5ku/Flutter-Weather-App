import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_icons/weather_icons.dart';

class CurrentWeatherScreen extends StatefulWidget {
  @override
  State<CurrentWeatherScreen> createState() => _CurrentWeatherScreenState();
}

class _CurrentWeatherScreenState extends State<CurrentWeatherScreen> {
  String cityName = "London";
  String currentWeather = "Cloudy";
  double temperature = 0;
  double windSpeed = 0;
  String iconCode = "02d";

  void fetchWeatherData() async {
    Uri uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=40b1a03945c908c5cc9b447cdbc2abab&units=metric');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var weatherData = json.decode(response.body);

      setState(() {
        temperature = weatherData['main']['temp'];
        currentWeather = weatherData['weather'][0]['description'];
        windSpeed = weatherData['wind']['speed'];
        iconCode = weatherData['weather'][0]['icon'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cityName),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(currentWeather, style: const TextStyle(fontSize: 40)),
          Text("$temperature °C", style: const TextStyle(fontSize: 40)),
          Text("$windSpeed m/s", style: const TextStyle(fontSize: 40)),
          Image.network("http://openweathermap.org/img/wn/$iconCode@2x.png"),
          ElevatedButton(
            onPressed: () {
              fetchWeatherData();
            },
            child: const Text("Fetch weather forecast",
                style: TextStyle(fontSize: 30)),
          )
        ],
      )),
    );
  }
}
