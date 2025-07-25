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
    } catch (e) {
      print(e);
    }
  }

  String getWeatherIcon(String? condition) {
    if (condition == null) return 'assets/none.png';

    switch (condition.toLowerCase()) {
      case 'clouds':
        return 'assets/clouds.png';
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/fog.png';
      case 'rain':
        return 'assets/rain.png';
      case 'drizzle':
      case 'shower rain':
        return 'assets/drizzle.png';
      case 'thunderstorm':
        return 'assets/thunder.png';
      case 'clear':
        return 'assets/sunny.png';
      default:
        return 'assets/sunny.png';
    }
  }


  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tenki.',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Color(0xFF343A40),
            fontWeight: FontWeight.bold,
            fontSize: 36
          ),
        ),
        backgroundColor: Color(0xffe9ecef), // same as your app bg
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF343A40)),
      ),
      backgroundColor: Color(0xffe9ecef),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 0.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Transform.translate(
                  offset: Offset(0, -30), // shift up by 20 pixels
                  child: Text(
                    _weather?.cityName ?? "Loading city...",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff6c757d),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Image.asset(
                getWeatherIcon(_weather?.condition),
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.contain,
              ),
            ),

            Text(
              '${_weather?.temperature.round() ?? "--"}°C',
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: Color(0xff343a40),
              ),
            ),

            Text(
              _weather?.condition ?? "",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff6c757d),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
