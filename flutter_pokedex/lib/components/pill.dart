import 'package:flutter/material.dart';
import 'package:flutter_pokedex/themes/colors.dart';
import 'package:flutter_pokedex/themes/typography.dart';

class Pill extends StatelessWidget {
  final String type;

  const Pill({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.pokeType[type],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 2,
        ),
        child: Text(
          type.substring(0, 1).toUpperCase() + type.substring(1).toLowerCase(),
          style: AppTypography.subtitle3
              .copyWith(color: AppColors.grayscale['white'], height: 0),
        ),
      ),
    );
  }
}
