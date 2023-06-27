import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_pokedex/components/pill.dart';
import 'package:flutter_pokedex/components/status.dart';
import 'package:flutter_pokedex/themes/colors.dart';
import 'package:flutter_pokedex/themes/icons.dart';
import 'package:flutter_pokedex/themes/typography.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    final types = ["grass", "bug"];
    final mainColor = AppColors.pokeType[types[0]];

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: mainColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                AppIcons.arrowBack,
                colorFilter: ColorFilter.mode(
                  AppColors.grayscale["white"],
                  BlendMode.srcIn,
                ),
                height: 32,
                width: 32,
                fit: BoxFit.fitHeight,
              ),
            ),
            Expanded(
              child: Text(
                "Pokémon Name",
                style: AppTypography.headline.copyWith(
                  color: AppColors.grayscale['white'],
                ),
              ),
            ),
            Text(
              "#999",
              style: AppTypography.subtitle2.copyWith(
                color: AppColors.grayscale['white'],
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            right: 0,
            top: 50,
            child: Opacity(
              opacity: 0.4,
              child: SvgPicture.asset(
                AppIcons.pokeball,
                colorFilter: ColorFilter.mode(
                  AppColors.grayscale["white"],
                  BlendMode.srcIn,
                ),
                height: 208,
                width: 208,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 300,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.grayscale['white'],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 20,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Wrap(
                                spacing: 16,
                                children: [
                                  Pill(type: 'grass'),
                                  Pill(type: "bug"),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            "About",
                            textAlign: TextAlign.center,
                            style: AppTypography.subtitle1.copyWith(
                              color: mainColor,
                              height: 4,
                            ),
                          ),
                          SizedBox(
                            height: 48,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            AppIcons.weight,
                                            width: 16,
                                            height: 16,
                                            colorFilter: ColorFilter.mode(
                                              AppColors.grayscale["dark"],
                                              BlendMode.srcIn,
                                            ),
                                            fit: BoxFit.fitHeight,
                                          ),
                                          const Text("9,9kg"),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "Weight",
                                      style: AppTypography.caption.copyWith(
                                        color: AppColors.grayscale['medium'],
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 1,
                                  height: double.infinity,
                                  color: AppColors.grayscale['dark'],
                                ),
                                Column(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Transform.rotate(
                                            angle: 90 * (pi / 180),
                                            child: SvgPicture.asset(
                                              AppIcons.straigthen,
                                              width: 16,
                                              height: 16,
                                              colorFilter: ColorFilter.mode(
                                                AppColors.grayscale["dark"],
                                                BlendMode.srcIn,
                                              ),
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                          const Text("9,9kg"),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "Height",
                                      style: AppTypography.caption.copyWith(
                                        color: AppColors.grayscale['medium'],
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 1,
                                  height: double.infinity,
                                  color: AppColors.grayscale['dark'],
                                ),
                                Column(
                                  children: [
                                    Expanded(
                                      child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            "Ability 1",
                                            style: AppTypography.body3
                                                .copyWith(height: 0),
                                          ),
                                          Text(
                                            "Ability 2",
                                            style: AppTypography.body3
                                                .copyWith(height: 0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "Moves",
                                      style: AppTypography.caption.copyWith(
                                          color: AppColors.grayscale['medium'],
                                          height: 0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Expanded(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc iaculis eros vitae tellus condimentum maximus sit amet in eros.",
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Base Status",
                            style: AppTypography.subtitle1.copyWith(
                              color: mainColor,
                              height: 0,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 150,
                                  color: AppColors.grayscale['light'],
                                  child: Row(
                                    children: [
                                      Container(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        color: AppColors.grayscale['white'],
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "HP",
                                              style: AppTypography.subtitle3
                                                  .copyWith(color: mainColor),
                                            ),
                                            Text(
                                              "ATK",
                                              style: AppTypography.subtitle3
                                                  .copyWith(color: mainColor),
                                            ),
                                            Text(
                                              "DEF",
                                              style: AppTypography.subtitle3
                                                  .copyWith(color: mainColor),
                                            ),
                                            Text(
                                              "SATK",
                                              style: AppTypography.subtitle3
                                                  .copyWith(color: mainColor),
                                            ),
                                            Text(
                                              "SDEF",
                                              style: AppTypography.subtitle3
                                                  .copyWith(color: mainColor),
                                            ),
                                            Text(
                                              "SPD",
                                              style: AppTypography.subtitle3
                                                  .copyWith(color: mainColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 1,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        color: AppColors.grayscale['white'],
                                        child: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text("999"),
                                            Text("999"),
                                            Text("999"),
                                            Text("999"),
                                            Text("999"),
                                            Text("999"),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          color: AppColors.grayscale['white'],
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Status(
                                                value: 0.5,
                                                type: types[0],
                                              ),
                                              Status(
                                                value: 0.5,
                                                type: types[0],
                                              ),
                                              Status(
                                                value: 0.5,
                                                type: types[0],
                                              ),
                                              Status(
                                                value: 0.5,
                                                type: types[0],
                                              ),
                                              Status(
                                                value: 0.5,
                                                type: types[0],
                                              ),
                                              Status(
                                                value: 0.5,
                                                type: types[0],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(top: 160),
              child: Row(
                children: [
                  InkWell(
                    child: SvgPicture.asset(
                      AppIcons.chevronLeft,
                      colorFilter: ColorFilter.mode(
                        AppColors.grayscale["white"],
                        BlendMode.srcIn,
                      ),
                      height: 24,
                      width: 24,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Expanded(
                    child: Image.network(
                      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  InkWell(
                    child: SvgPicture.asset(
                      AppIcons.chevronRight,
                      colorFilter: ColorFilter.mode(
                        AppColors.grayscale["white"],
                        BlendMode.srcIn,
                      ),
                      height: 24,
                      width: 24,
                      fit: BoxFit.fitHeight,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
