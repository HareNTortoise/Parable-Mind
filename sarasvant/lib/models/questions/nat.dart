import 'package:sarasvant/models/variable.dart';

class NAT {
  String id;
  String bankId;
  String question;
  List<Variable> variable;
  int points;
  double answer;

  NAT({
    required this.id,
    required this.bankId,
    required this.question,
    required this.variable,
    required this.points,
    required this.answer,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bankId': bankId,
      'question': question,
      'variable': variable,
      'points': points,
      'answer': answer,
    };
  }

  factory NAT.fromJson(Map<String, dynamic> json) {
    return NAT(
      id: json['id'],
      bankId: json['bankId'],
      question: json['question'],
      variable: json['variable'],
      points: json['points'],
      answer: json['answer'].toDouble(),
    );
  }
}