import 'package:sarasvant/models/variable.dart';

class Questions {
  String qId;
  String poolId;
  String question;
  List <Variable> variable;
  int points;

  Questions({
    required this.qId,
    required this.poolId,
    required this.question,
    required this.variable,
    required this.points,
  });

  Map<String, dynamic> toJson() {
    return {
      'qId': qId,
      'poolId': poolId,
      'question': question,
      'variable': variable,
      'points': points,
    };
  }

  factory Questions.fromJson(Map<String, dynamic> json) {
    return Questions(
      qId: json['qId'],
      poolId: json['poolId'],
      question: json['question'],
      variable: json['variable'],
      points: json['points'],
    );
  }

}