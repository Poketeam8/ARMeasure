class MeasurementRecord {
  final double distance;
  final String imagePath;

  MeasurementRecord({
    required this.distance,
    required this.imagePath,
  });

  Map<String, dynamic> toJson() {
    return {
      'distance': distance,
      'imagePath': imagePath,
    };
  }

  factory MeasurementRecord.fromJson(
    Map<String, dynamic> json,
  ) {
    return MeasurementRecord(
      distance: (json['distance'] as num).toDouble(),
      imagePath: json['imagePath'],
    );
  }
}