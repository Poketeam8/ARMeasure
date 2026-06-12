class MeasurementRecord {
  final double value;
  final String imagePath;
  final List<String> jokes;

  MeasurementRecord({
    required this.value,
    required this.imagePath,
    required this.jokes,
  });

  Map<String, dynamic> toJson() => {
        "value": value,
        "imagePath": imagePath,
        "jokes": jokes,
      };

  factory MeasurementRecord.fromJson(Map<String, dynamic> json) {
    return MeasurementRecord(
      value: json["value"],
      imagePath: json["imagePath"],
      jokes: List<String>.from(json["jokes"] ?? []),
    );
  }
}