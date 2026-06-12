class MeasurementRecord {
  final double value;
  final String imagePath;

  MeasurementRecord({
    required this.value,
    required this.imagePath,
  });

  Map<String, dynamic> toJson() => {
        "value": value,
        "imagePath": imagePath,
      };

  factory MeasurementRecord.fromJson(Map<String, dynamic> json) {
    return MeasurementRecord(
      value: json["value"],
      imagePath: json["imagePath"],
    );
  }
}