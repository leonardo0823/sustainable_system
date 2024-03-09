class Software {
  late String name;
  late String rating;
  late int points;

  Software(
      {required this.name, this.rating = 'No Sostenible', this.points = 0});

  Software.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    rating = map['rating'] ?? 'No Sostenible';
    points = map['points'] ?? 0;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rating': rating,
      'points': points,
    };
  }

  @override
  String toString() =>
      'Software(name: $name, rating: $rating, points: $points)';
}
