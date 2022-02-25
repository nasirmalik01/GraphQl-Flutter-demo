class Character {
  String name;
  Character({required this.name});

  factory Character.fromJSON(Map<String, dynamic> parsedJson) {
    return Character(
        name: parsedJson['name']
    );
  }
}