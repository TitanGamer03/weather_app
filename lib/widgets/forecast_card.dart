import 'package:flutter/material.dart';

class ForecastCard extends StatelessWidget{

  final String time;
  final IconData icon;
  final String temp;

  const ForecastCard({
    super.key,
    required this.time,
    required this.icon,
    required this.temp,
  });

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
        child: Column(
          children: [
            Text(
              time,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 10,),

            Icon(
              icon,
              size: 60,
            ),

            const SizedBox(height: 10,),

            Text(
              "$temp °C",
            ),
          ],
        ),
      ),
    );
  }

}