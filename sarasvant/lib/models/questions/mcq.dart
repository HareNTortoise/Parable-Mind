import '../variable.dart';

class MCQ {
  String id;
  String bankId;
  String question;
  List <Variable> variable;
  int points;
  List <String> options;
  String answer;

  MCQ({
    required this.id,
    required this.bankId,
    required this.question,
    required this.variable,
    required this.points,
    required this.options,
    required this.answer,
  });

  Map<String, dynamic> toJson() {
    return {
      'qi': id,
      'bankId': bankId,
      'question': question,
      'variable': variable,
      'points': points,
      'options': options,
      'answer': answer,
    };
  }

  factory MCQ.fromJson(Map<String, dynamic> json) {
    return MCQ(
      id: json['qIid'],
      bankId: json['bankId'],
      question: json['question'],
      variable: json['variable'],
      points: json['points'],
      options: json['options'],
      answer: json['answer'],
    );
  }
}