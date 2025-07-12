import 'package:flutter/material.dart';
import '../services/weather_service.dart';

class WeatherCard extends StatefulWidget {
  const WeatherCard({super.key});

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  final WeatherService _weatherService = WeatherService();
  late Future<Map<String, dynamic>> _weatherFuture;

  @override
  void initState() {
    super.initState();
    _weatherFuture = _weatherService.getCurrentWeather("Colombo");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _weatherFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 170,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return const SizedBox(
            height: 170,
            child: Center(child: Text("Failed to load weather")),
          );
        }

        final data = snapshot.data!;
        final location = data['location']['name'];
        final temp = data['current']['temperature'];
        final desc = data['current']['weather_descriptions'][0];
        final iconUrl = data['current']['weather_icons'][0];

        return SizedBox(
          height: 170,
          child: Card(
            color: Colors.green.shade50,
            elevation: 0.1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Image.network(iconUrl, width: 60),
                  const SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$location Weather",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        "$temp°C, $desc",
                        style: TextStyle(color: Colors.green.shade700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
