import 'package:flutter/material.dart';
import 'package:flutter_pokedex/themes/colors.dart';

class Status extends StatelessWidget {
  final double value;
  final String type;

  const Status({super.key, required this.value, required this.type});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 4,
      child: LinearProgressIndicator(
        value: value,
        backgroundColor: AppColors.grayscale['light'],
        color: AppColors.pokeType[type],
      ),
    );
  }
}

