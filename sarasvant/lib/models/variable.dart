class Variable {
  String id;
  String name;
  Map<String, (int, int)> namePosition;
  Map<String, (int, int)> valuePosition;
  String unit;
  Map<String, (int, int)> unitPosition;
  String variableType;

  Variable({
    required this.id,
    required this.name,
    required this.namePosition,
    required this.valuePosition,
    required this.unit,
    required this.unitPosition,
    required this.variableType,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'namePosition': namePosition,
      'valuePosition': valuePosition,
      'unit': unit,
      'unitPosition': unitPosition,
      'variableType': variableType,
    };
  }

  factory Variable.fromJson(Map<String, dynamic> json) {
    return Variable(
      id: json['id'],
      name: json['name'],
      namePosition: json['namePosition'],
      valuePosition: json['valuePosition'],
      unit: json['unit'],
      unitPosition: json['unitPosition'],
      variableType: json['variableType'],
    );
  }
}