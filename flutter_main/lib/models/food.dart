class Food {
  final String name;
  final String picUrl;
  final double calories;

  const Food({
    required this.name,
    required this.picUrl,
    required this.calories,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
        name: json['nama'],
        picUrl: json['pic_url'],
        calories: json['calories'],
    );
  }
}