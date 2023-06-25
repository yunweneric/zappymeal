
class CounterModel {
  CounterModel({
    required this.title,
    required this.value,
  });

  String title;
  int value;

  factory CounterModel.fromJson(Map<String, dynamic> json) => CounterModel(
        title: json["title"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "value": value,
      };
}
