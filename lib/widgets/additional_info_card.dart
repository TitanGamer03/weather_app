import 'package:flutter/material.dart';

class AdditionalInfoCard extends StatelessWidget{

  final String label;
  final IconData icon;
  final double value;

  const AdditionalInfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 40,
        ),
        SizedBox(height: 10,),
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        SizedBox(height: 10,),
        Text(
          "$value",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}