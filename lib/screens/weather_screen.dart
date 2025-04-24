import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/widgets/additional_info_card.dart';
import '../widgets/forecast_card.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  double? temp;
  String? errorMsg;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future<void> getCurrentWeather() async {
    try {
      String cityName = "Surendranagar";
      String apiKey = "e9d63fcba2f51abf66714da4a3ed480c";
      final response = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$apiKey"
        )
      );
      final data = jsonDecode(response.body);
      if (data['cod'] != "200") {
        throw "An unexpected error occurred";
      }

      temp = data['list'][0]['main']['temp'];
    } catch (e) {
      errorMsg = e.toString();
    } finally {
      isLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isLoading = true;
                errorMsg = null;
              });
              getCurrentWeather();
            },
            icon: const Icon(Icons.refresh)
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMsg != null
            ? Center(child: Text("Error: $errorMsg"))
            : Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 250,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    elevation: 10,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16)
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10, sigmaY: 10
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Text(
                                "${(temp! - 273.15).toStringAsFixed(2)} °C",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32
                                ),
                              ),
                              const SizedBox(height: 15),
                              const Icon(
                                Icons.cloud,
                                size: 90,
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                "Clear",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Weather Forecast",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ForecastCard(
                      time: "00:00",
                      temp: 30,
                      icon: Icons.ac_unit_sharp
                    ),
                    ForecastCard(
                      time: "03:00",
                      temp: 30,
                      icon: Icons.sunny
                    ),
                    ForecastCard(
                      time: "06:00",
                      temp: 30,
                      icon: Icons.cloud
                    ),
                    ForecastCard(
                      time: "09:00",
                      temp: 30,
                      icon: Icons.sunny
                    ),
                    ForecastCard(
                      time: "12:00",
                      temp: 30,
                      icon: Icons.foggy
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Additional Information",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AdditionalInfoCard(
                    icon: Icons.water_drop,
                    label: "Humidity",
                    value: 50
                  ),
                  AdditionalInfoCard(
                    icon: Icons.air,
                    label: "Wind Speed",
                    value: 7.9
                  ),
                  AdditionalInfoCard(
                    icon: Icons.beach_access,
                    label: "Pressure",
                    value: 1009
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
