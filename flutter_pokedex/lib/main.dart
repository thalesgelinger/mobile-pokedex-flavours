import 'package:flutter/material.dart';
import 'package:flutter_pokedex/icons.dart';
import 'package:flutter_pokedex/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.identity['primary'],
        appBar: AppBar(
          backgroundColor: AppColors.identity['primary'],
          centerTitle: false,
          title: Row(
            children: [
              SvgPicture.asset(
                AppIcons.pokeball,
                colorFilter: ColorFilter.mode(
                    AppColors.grayscale["white"], BlendMode.srcIn),
                height: 30,
                width: 30,
                fit: BoxFit.scaleDown,
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                "Pokédex",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColors.grayscale["white"],
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 32,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    hintText: 'Search',
                    prefixIcon: SvgPicture.asset(
                      AppIcons.search,
                      colorFilter: ColorFilter.mode(
                        AppColors.identity["primary"],
                        BlendMode.srcIn,
                      ),
                      height: 14,
                      width: 14,
                      fit: BoxFit.fitHeight,
                    ),
                    filled: true,
                    fillColor: AppColors.grayscale['white'],
                    contentPadding: const EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                      left: 12,
                      right: 16,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 24, left: 8, right: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.grayscale['white'],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 150,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: 10,
                        itemBuilder: (BuildContext ctx, index) {
                          return Container(
                            height: 40,
                            width: 40,
                            color: Colors.blue,
                          );
                        }),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
