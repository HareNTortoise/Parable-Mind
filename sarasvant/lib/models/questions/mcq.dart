import '../variable.dart';

class MCQ {
  String id;
  String bankId;
  String question;
  List<Variable> variable;
  int points;
  List<String> options;
  int answerIndex;

  MCQ({
    required this.id,
    required this.bankId,
    required this.question,
    required this.variable,
    required this.points,
    required this.options,
    required this.answerIndex,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bankId': bankId,
      'question': question,
      'variable': variable,
      'points': points,
      'options': options,
      'answerIndex': answerIndex,
    };
  }

  factory MCQ.fromJson(Map<String, dynamic> json) {
    return MCQ(
      id: json['id'],
      bankId: json['bankId'],
      question: json['question'],
      variable: json['variable'],
      points: json['points'],
      options: json['options'],
      answerIndex: json['answerIndex'],
    );
  }
}