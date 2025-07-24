import 'package:flutter/material.dart';
import 'package:tenki/models/weather_model.dart';
import 'package:tenki/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});
  @override
  State<WeatherPage> createState() => _weatherPageState();
}

class _weatherPageState extends State<WeatherPage> {

  final _weatherService = WeatherService('6868bc1fa5ce3bf1f1ec93080061b549');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });

    } 
    catch (e) {
      print(e);
    }
  }
  @override
  void initState(){
    super.initState();

    _fetchWeather();
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_weather?.cityName ?? "Loading city..."),
              Text('${_weather?.temperature ?? "--"}°C'),
            ],
          ),
        )
      );
    }
}
