class NAT {
  String id;
  String bankId;
  String question;
  List<String> variableIds;
  int points;
  double answer;

  NAT({
    required this.id,
    required this.bankId,
    required this.question,
    required this.variableIds,
    required this.points,
    required this.answer,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bankId': bankId,
      'question': question,
      'variableIds': variableIds,
      'points': points,
      'answer': answer,
    };
  }

  factory NAT.fromJson(Map<String, dynamic> json) {
    return NAT(
      id: json['id'],
      bankId: json['bankId'],
      question: json['question'],
      variableIds: List<String>.from(json['variableIds']),
      points: json['points'],
      answer: json['answer'].toDouble(),
    );
  }
}