class PokemonDetails {
  final String name;
  final int number;
  final String img;
  final int weight;
  final int height;
  final List<dynamic> abilities;
  final List<dynamic> types;
  final Map<dynamic, dynamic> stats;

  PokemonDetails({
    required this.name,
    required this.number,
    required this.img,
    required this.weight,
    required this.height,
    required this.abilities,
    required this.types,
    required this.stats,
  });

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    return PokemonDetails(
      name: json['name'],
      number: json['number'],
      img: json['img'],
      weight: json['weight'],
      height: json['height'],
      abilities: json['abilities'],
      types: json['types'],
      stats: json['stats'],
    );
  }
}
