import 'package:sarasvant/models/variable.dart';

class Questions {
  String id;
  String bankId;
  String question;
  List <Variable> variable;
  int points;

  Questions({
    required this.id,
    required this.bankId,
    required this.question,
    required this.variable,
    required this.points,
  });

  Map<String, dynamic> toJson() {
    return {
      'qi': id,
      'bankId': bankId,
      'question': question,
      'variable': variable,
      'points': points,
    };
  }

  factory Questions.fromJson(Map<String, dynamic> json) {
    return Questions(
      id: json['qIid'],
      bankId: json['bankId'],
      question: json['question'],
      variable: json['variable'],
      points: json['points'],
    );
  }

}