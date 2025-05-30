import 'package:myapp/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherServices {
  final String _apiKey = '50add1b5e274523e73f638cb530b0f79';
  final String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Weather> featchWeather(String cityName) async {
    final url = Uri.parse('$_baseUrl?q=$cityName&appid=$_apiKey&units=metric');

    try {
      final response = await http.get(url);

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Weather.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        throw Exception('City not found. Please enter a valid city name.');
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      rethrow;
    }
  }
}
