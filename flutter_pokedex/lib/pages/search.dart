import 'package:flutter/material.dart';
import 'package:flutter_pokedex/models/pokemon.dart';
import 'package:flutter_pokedex/services/api.dart';
import 'package:flutter_pokedex/themes/typography.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_pokedex/themes/colors.dart';
import 'package:flutter_pokedex/themes/icons.dart';
import 'package:flutter_pokedex/components/pokecard.dart';
import 'package:collection/collection.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Pokemon> pokemons = [];
  List<Pokemon> pokemonsFiltered = [];

  @override
  void initState() {
    fetchPokemons();
    super.initState();
  }

  fetchPokemons() async {
    final result =
        await Api.get("https://pokeapi.co/api/v2/pokemon?limit=50&offset=0");
    final List<dynamic> results = result['results'];
    final List<Pokemon> pokemonsMapped = await Future.wait(
      results.mapIndexed(
        (i, pokemon) async {
          final details = await Api.get(pokemon['url']);

          return Pokemon(
            name: pokemon['name'],
            number: i + 1,
            img: details['sprites']['front_default'],
          );
        },
      ),
    );

    setState(() {
      pokemons = pokemonsMapped;
      pokemonsFiltered = pokemonsMapped;
    });
  }

  handleFilter(String searchTerm) {
    setState(() {
      pokemonsFiltered = pokemons.where((pokemon)=> pokemon.name.contains(searchTerm))
          .toList();
    });
  }

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
              style: AppTypography.headline.copyWith(
                color: AppColors.grayscale["white"],
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
                onChanged: handleFilter,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
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
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.grayscale['medium'],
                      spreadRadius: -2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
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
                    itemCount: pokemonsFiltered.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return PokeCard(
                        pokedata: pokemonsFiltered[index],
                      );
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
