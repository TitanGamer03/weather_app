import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/widgets/additional_info.dart';

import '../widgets/forecast_card.dart';

class WeatherPage extends StatefulWidget{
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
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
            onPressed: (){
              setState(() {});
            },
            icon: const Icon(Icons.refresh)
          ),
        ],
      ),
      body: Padding(
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
                      borderRadius: BorderRadius.all(Radius.circular(16))
                    ),
                    elevation: 10,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                "40 °C",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32
                                ),
                              ),

                              SizedBox(height: 15,),

                              Icon(
                                Icons.cloud,
                                size: 90,
                              ),

                              SizedBox(height: 15,),

                              Text(
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

              const SizedBox(height: 20,),

              Text(
                "Weather Forecast",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                )
              ),

              const SizedBox(height: 16,),

              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:[
                    ForecastCard(),
                    ForecastCard(),
                    ForecastCard(),
                    ForecastCard(),
                    ForecastCard(),
                  ],
                ),
              ),

              const SizedBox(height: 20,),

              Text(
                "Additional Information",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),

              const SizedBox(height: 16,),

              const AdditionalInfo(),
            ],
          ),
        ),
      ),
    );
  }
}