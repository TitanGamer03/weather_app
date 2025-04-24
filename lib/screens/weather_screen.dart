import 'dart:convert';
import 'dart:ui';
import 'package:intl/intl.dart';
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

  Future<Map<String,dynamic>> getCurrentWeather() async {
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

      return data;
    }
    catch (e) {
      throw e.toString();
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
              setState(() {});
            },
            icon: const Icon(Icons.refresh)
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }

          final data = snapshot.data!;
          final currentWeatherData = data['list'][0];
          final currentTemp = currentWeatherData['main']['temp'];
          final currentSky = currentWeatherData['weather'][0]['main'];
          final currentPressure = currentWeatherData['main']['pressure'];
          final currentHumidity = currentWeatherData['main']['humidity'];
          final currentWindSpeed = currentWeatherData['wind']['speed'];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
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
                                    "${(currentTemp - 273.15).toStringAsFixed(2)} °C",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Icon(
                                    currentSky == "Clouds" || currentSky == "Rain" ? Icons.cloud : Icons.sunny,
                                    size: 90,
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    currentSky,
                                    style: const TextStyle(
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
                    "Hourly Forecast",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    height: 151,
                    child: ListView.builder(
                      itemCount: 8,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final hourlyForecast = data['list'][index+1];
                        final hourlyTime = hourlyForecast['dt_txt'];
                        final hourlyTemp = hourlyForecast['main']['temp'];
                        final hourlySky = hourlyForecast['weather'][0]['main'];
                        final time = DateTime.parse(hourlyTime);
                        return ForecastCard(
                          time: DateFormat.j().format(time),
                          temp: (hourlyTemp - 273.15).toStringAsFixed(2),
                          icon: hourlySky == "Clouds" || hourlySky == "Rain" ? Icons.cloud : Icons.sunny,
                        );
                      },
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AdditionalInfoCard(
                        icon: Icons.water_drop,
                        label: "Humidity",
                        value: currentHumidity.toDouble(),
                      ),
                      AdditionalInfoCard(
                        icon: Icons.air,
                        label: "Wind Speed",
                        value: currentWindSpeed.toDouble(),
                      ),
                      AdditionalInfoCard(
                        icon: Icons.beach_access,
                        label: "Pressure",
                        value: currentPressure.toDouble(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
