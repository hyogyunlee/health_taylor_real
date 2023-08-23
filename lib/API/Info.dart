class Info {
  final int height;
  final int weight;

  Info({required this.height, required this.weight});

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      height: json['신장(5Cm단위)'],
      weight: json['체중(5Kg 단위)'],
    );
  }
}
