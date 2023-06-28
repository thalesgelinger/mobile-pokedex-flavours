import 'package:flutter/material.dart';
import 'package:flutter_pokedex/models/pokemon.dart';
import 'package:flutter_pokedex/themes/colors.dart';

class PokeCard extends StatelessWidget {
  final Pokemon pokedata;

  const PokeCard({super.key, required this.pokedata});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/details',
          arguments: pokedata.number,
        );
      },
      child: Container(
        height: 108.0,
        width: 104,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.grayscale['white'],
          boxShadow: [
            BoxShadow(
              color: AppColors.grayscale['medium'],
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  "#${pokedata.number}",
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.grayscale["background"],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Align(
                alignment: Alignment.center,
                child: Image.network(
                  pokedata.img,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(pokedata.name),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
