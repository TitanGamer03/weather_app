import 'package:flutter/material.dart';

class AdditionalInfo extends StatelessWidget{
  const AdditionalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Icon(
              Icons.water_drop,
              size: 40,
            ),
            SizedBox(height: 10,),
            Text(
              "Humidity",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10,),
            Text(
              "50",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        Column(
          children: [
            Icon(
              Icons.air,
              size: 40,
            ),
            SizedBox(height: 10,),
            Text(
              "Wind Speed",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10,),
            Text(
              "7.9",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        Column(
          children: [
            Icon(
              Icons.accessibility_new_rounded,
              size: 40,
            ),
            SizedBox(height: 10,),
            Text(
              "Pressure",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10,),
            Text(
              "1009",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

}