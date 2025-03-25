import 'package:flutter/material.dart';

class ForecastCard extends StatelessWidget{
  const ForecastCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Column(
          children: [
            Text(
              "03:00",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            SizedBox(height: 10,),

            Icon(
              Icons.cloud,
              size: 60,
            ),

            SizedBox(height: 10,),

            Text(
              "40 °C",
            ),
          ],
        ),
      ),
    );
  }

}