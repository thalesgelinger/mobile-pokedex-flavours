class Pokemon {
  final String name;
  final int number;
  final String img;

  Pokemon({required this.name, required this.number, required this.img});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      number: json['number'],
      img: json['img'],
    );
  }
}
