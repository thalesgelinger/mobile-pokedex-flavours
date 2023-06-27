import 'package:flutter/material.dart';
import 'package:flutter_pokedex/colors.dart';

class Pill extends StatelessWidget {
  const Pill({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.pokeType['bug'],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 2,
        ),
        child: Text("Type"),
      ),
    );
  }
}
