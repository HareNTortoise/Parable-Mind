class Variable {
  String name;
  Map<String, (int, int)> namePosition;
  Map<String, (int, int)> valuePosition;
  String unit;
  Map<String, (int, int)> unitPosition;
  Map<String, int> type;

  Variable({
    required this.name,
    required this.namePosition,
    required this.valuePosition,
    required this.unit,
    required this.unitPosition,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'namePosition': namePosition,
      'valuePosition': valuePosition,
      'unit': unit,
      'unitPosition': unitPosition,
      'type': type,
    };
  }

  factory Variable.fromJson(Map<String, dynamic> json) {
    return Variable(
      name: json['name'],
      namePosition: json['namePosition'],
      valuePosition: json['valuePosition'],
      unit: json['unit'],
      unitPosition: json['unitPosition'],
      type: json['type'],
    );
  }
}