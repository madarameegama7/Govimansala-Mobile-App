import 'dart:convert';
import 'package:http/http.dart' as http;
class WeatherService {
  final String apiKey = '2830dba2260d7291dcbe6d8f2fc9999f';

  Future<Map<String, dynamic>> getCurrentWeather(String city) async {
    final url = Uri.parse(
      'http://api.weatherstack.com/current?access_key=$apiKey&query=$city',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['success'] == false) {
        throw Exception(data['error']['info']);
      }

      return data;
    } else {
      throw Exception('Failed to load weather');
    }
  }
}

