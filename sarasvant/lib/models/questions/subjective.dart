import 'package:sarasvant/models/variable.dart';

class Subjective {
  String id;
  String bankId;
  String question;
  List <Variable> variable;
  int points;
  String? idealAnswer;
  List<String>? gradingCriteria;

  Subjective({
    required this.id,
    required this.bankId,
    required this.question,
    required this.variable,
    required this.points,
    this.idealAnswer,
    this.gradingCriteria,
  });

  Map<String, dynamic> toJson() {
    return {
      'qi': id,
      'bankId': bankId,
      'question': question,
      'variable': variable,
      'points': points,
      'idealAnswer': idealAnswer,
      'gradingCriteria': gradingCriteria,
    };
  }

  factory Subjective.fromJson(Map<String, dynamic> json) {
    return Subjective(
      id: json['qIid'],
      bankId: json['bankId'],
      question: json['question'],
      variable: json['variable'],
      points: json['points'],
      idealAnswer: json['idealAnswer'],
      gradingCriteria: json['gradingCriteria'],
    );
  }

}