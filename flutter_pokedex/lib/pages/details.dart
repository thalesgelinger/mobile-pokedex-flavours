import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_pokedex/components/pill.dart';
import 'package:flutter_pokedex/components/status.dart';
import 'package:flutter_pokedex/models/pokemondetails.dart';
import 'package:flutter_pokedex/services/api.dart';
import 'package:flutter_pokedex/themes/colors.dart';
import 'package:flutter_pokedex/themes/icons.dart';
import 'package:flutter_pokedex/themes/typography.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  PokemonDetails? detailsFetched;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchDetails();
  }

  fetchDetails() async {
    final pokeId = ModalRoute.of(context)!.settings.arguments;

    final pokemonDetailsJson =
        await Api.get("https://pokeapi.co/api/v2/pokemon/${pokeId.toString()}");

    final pokemonDetails = PokemonDetails(
      name: pokemonDetailsJson['species']['name'],
      number: pokeId as int,
      img: pokemonDetailsJson["sprites"]["front_default"],
      weight: pokemonDetailsJson['weight'],
      height: pokemonDetailsJson['height'],
      abilities: pokemonDetailsJson['abilities']
          .map((d) => d["ability"]["name"])
          .toList(),
      types: pokemonDetailsJson['types'].map((d) => d["type"]["name"]).toList(),
      stats: pokemonDetailsJson["stats"].fold(
        {},
        (acc, el) => {...acc, el["stat"]["name"]: el["base_stat"]},
      ),
    );

    setState(() {
      detailsFetched = pokemonDetails;
    });
  }

  toPercentage(int value) {
    return value / 255;
  }

  @override
  Widget build(BuildContext context) {
    if (detailsFetched == null) {
      return const Center(child: CircularProgressIndicator());
    }

    PokemonDetails details = detailsFetched!;

    final mainColor = AppColors.pokeType[details.types[0]];

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
                details.name,
                style: AppTypography.headline.copyWith(
                  color: AppColors.grayscale['white'],
                ),
              ),
            ),
            Text(
              "#${details.number}",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Wrap(
                                spacing: 16,
                                children: details.types
                                    .map(
                                      (type) => Pill(type: type),
                                    )
                                    .toList(),
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
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
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
                                          Text(
                                            "${details.weight.toString()}kg",
                                          ),
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
                                          Text(
                                              "${details.height.toString()}m"),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: details.abilities
                                              .map((ability) => Text(
                                                    ability,
                                                    style: AppTypography.body3
                                                        .copyWith(height: 0),
                                                  ))
                                              .toList()),
                                    ),
                                    Text(
                                      "Moves",
                                      style: AppTypography.caption.copyWith(
                                          color:
                                              AppColors.grayscale['medium'],
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
                                  textAlign: TextAlign.center,
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
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              details.stats['hp'].toString(),
                                            ),
                                            Text(
                                              details.stats['attack']
                                                  .toString(),
                                            ),
                                            Text(
                                              details.stats['defense']
                                                  .toString(),
                                            ),
                                            Text(
                                              details.stats['special-attack']
                                                  .toString(),
                                            ),
                                            Text(
                                              details.stats['special-defense']
                                                  .toString(),
                                            ),
                                            Text(
                                              details.stats['speed']
                                                  .toString(),
                                            ),
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
                                                value: toPercentage(
                                                  details.stats['hp'],
                                                ),
                                                type: details.types[0],
                                              ),
                                              Status(
                                                value: toPercentage(
                                                  details.stats['attack'],
                                                ),
                                                type: details.types[0],
                                              ),
                                              Status(
                                                value: toPercentage(
                                                  details.stats['defense'],
                                                ),
                                                type: details.types[0],
                                              ),
                                              Status(
                                                value: toPercentage(
                                                  details.stats[
                                                      'special-attack'],
                                                ),
                                                type: details.types[0],
                                              ),
                                              Status(
                                                value: toPercentage(
                                                  details.stats[
                                                      'special-defense'],
                                                ),
                                                type: details.types[0],
                                              ),
                                              Status(
                                                value: toPercentage(
                                                  details.stats['speed'],
                                                ),
                                                type: details.types[0],
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
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/details",
                          arguments: details.number - 1);
                    },
                    child: details.number - 1 > 0
                        ? SvgPicture.asset(
                            AppIcons.chevronLeft,
                            colorFilter: ColorFilter.mode(
                              AppColors.grayscale["white"],
                              BlendMode.srcIn,
                            ),
                            height: 24,
                            width: 24,
                            fit: BoxFit.fitHeight,
                          )
                        : const SizedBox(
                            width: 24,
                          ),
                  ),
                  Expanded(
                    child: Image.network(
                      details.img,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/details",
                          arguments: details.number + 1);
                    },
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
