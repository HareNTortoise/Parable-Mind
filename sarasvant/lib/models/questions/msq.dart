class MSQ {
  String id;
  String bankId;
  String question;
  List<String> variableIds;
  int points;
  List<String> options;
  List<int> answerIndices;

  MSQ({
    required this.id,
    required this.bankId,
    required this.question,
    required this.variableIds,
    required this.points,
    required this.options,
    required this.answerIndices,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bankId': bankId,
      'question': question,
      'variableIds': variableIds,
      'points': points,
      'options': options,
      'answerIndices': answerIndices,
    };
  }

  factory MSQ.fromJson(Map<String, dynamic> json) {
    return MSQ(
      id: json['id'],
      bankId: json['bankId'],
      question: json['question'],
      variableIds: List<String>.from(json['variableIds']),
      points: json['points'],
      options: List<String>.from(json['options']),
      answerIndices: List<int>.from(json['answerIndices']),
    );
  }
}