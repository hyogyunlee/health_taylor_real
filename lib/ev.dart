class Ev {
  final int height;
  final int weight;

  Ev({required this.height, required this.weight});

  factory Ev.fromJson(Map<String, dynamic> json) {
    return Ev(
      height: json['신장(5Cm단위)'],
      weight: json['체중(5Kg 단위)'],
    );
  }
}
