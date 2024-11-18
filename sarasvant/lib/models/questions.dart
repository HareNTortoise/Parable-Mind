import 'package:sarasvant/models/variable.dart';

class Question {
  String id;
  String bankId;
  String question;
  List <String> tags;
  List <Variable> variable;
  int points;

  Question({
    required this.id,
    required this.bankId,
    required this.question,
    required this.tags,
    required this.variable,
    required this.points,
  });

  Map<String, dynamic> toJson() {
    return {
      'qi': id,
      'bankId': bankId,
      'question': question,
      'tags': tags,
      'variable': variable,
      'points': points,
    };
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['qIid'],
      bankId: json['bankId'],
      question: json['question'],
      tags: json['tags'],
      variable: json['variable'],
      points: json['points'],
    );
  }

}