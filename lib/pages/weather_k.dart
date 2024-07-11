import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class WeatherOutput extends StatefulWidget {
  const WeatherOutput({super.key});

  @override
  State<WeatherOutput> createState() => _WeatherOutputState();
}

const OPENWEATHER_API_KEY = "c20d5071af8d519e52ced0a445aa8a53";

class _WeatherOutputState extends State<WeatherOutput> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  Weather? _weather;

  final latitude = 63.10322133572498;
  final longitude = 21.619669321631353;
  @override
  void initState() {
    super.initState();
    _fetchWeatherByLocation(latitude, longitude);
  }

  void _fetchWeatherByLocation(double latitude, double longitude) {
    _wf.currentWeatherByLocation(latitude, longitude).then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    String weatherInfo =
        "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C, "
        "Wind: ${_weather?.windSpeed?.toStringAsFixed(0)} m/s, "
        "Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%";

    return Center(
      child: Text(
        weatherInfo,
        style: const TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }
}
