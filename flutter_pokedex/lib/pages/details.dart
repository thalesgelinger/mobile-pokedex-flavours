import 'package:flutter/material.dart';
import 'package:flutter_pokedex/colors.dart';
import 'package:flutter_pokedex/components/pill.dart';
import 'package:flutter_pokedex/themes/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.pokeType["bug"],
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
                  AppColors.grayscale["dark"],
                  BlendMode.srcIn,
                ),
                height: 32,
                width: 32,
                fit: BoxFit.fitHeight,
              ),
            ),
            const Expanded(
              child: Text("Pokémon Name"),
            ),
            const Text("#999")
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
                                  Pill(),
                                  Pill(),
                                ],
                              ),
                            ],
                          ),
                          const Text(
                            "About",
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Row(
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
                                  const Text("Weight"),
                                ],
                              ),
                              Container(
                                width: 1,
                                height: 48,
                                color: AppColors.grayscale['dark'],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppIcons.straigthen,
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
                                  const Text("Height"),
                                ],
                              ),
                              Container(
                                width: 1,
                                height: 48,
                                color: AppColors.grayscale['dark'],
                              ),
                              const Column(
                                children: [
                                  Text("Ability 1"),
                                  Text("Ability 2"),
                                  Text("Moves"),
                                ],
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc iaculis eros vitae tellus condimentum maximus sit amet in eros.",
                            ),
                          ),
                          const Text("Base Status"),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: double.infinity,
                                  color: AppColors.grayscale['medium'],
                                  child: Row(
                                    children: [
                                      Container(
                                        color: AppColors.grayscale['white'],
                                        child: const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text("HP"),
                                            Text("ATK"),
                                            Text("DEF"),
                                            Text("SATK"),
                                            Text("SDEF"),
                                            Text("SPD"),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 1,
                                      ),
                                      Container(
                                        color: AppColors.grayscale['white'],
                                        child: const Column(
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
                                        child: Column(
                                          children: [
                                            LinearProgressIndicator(
                                              value: 0.5,
                                              backgroundColor: AppColors
                                                  .grayscale['light'],
                                              color:
                                                  AppColors.pokeType['bug'],
                                            ),
                                            LinearProgressIndicator(
                                              value: 0.5,
                                              backgroundColor: AppColors
                                                  .grayscale['light'],
                                              color:
                                                  AppColors.pokeType['bug'],
                                            ),
                                            LinearProgressIndicator(
                                              value: 0.5,
                                              backgroundColor: AppColors
                                                  .grayscale['light'],
                                              color:
                                                  AppColors.pokeType['bug'],
                                            ),
                                            LinearProgressIndicator(
                                              value: 0.5,
                                              backgroundColor: AppColors
                                                  .grayscale['light'],
                                              color:
                                                  AppColors.pokeType['bug'],
                                            ),
                                            LinearProgressIndicator(
                                              value: 0.5,
                                              backgroundColor: AppColors
                                                  .grayscale['light'],
                                              color:
                                                  AppColors.pokeType['bug'],
                                            ),
                                            LinearProgressIndicator(
                                              value: 0.5,
                                              backgroundColor: AppColors
                                                  .grayscale['light'],
                                              color:
                                                  AppColors.pokeType['bug'],
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
