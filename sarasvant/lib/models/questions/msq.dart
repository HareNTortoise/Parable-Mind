import 'package:sarasvant/models/variable.dart';

class MSQ {
  String id;
  String bankId;
  String question;
  List<Variable> variable;
  int points;
  List<String> options;
  List<int> answerIndices;

  MSQ({
    required this.id,
    required this.bankId,
    required this.question,
    required this.variable,
    required this.points,
    required this.options,
    required this.answerIndices,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bankId': bankId,
      'question': question,
      'variable': variable,
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
      variable: json['variable'],
      points: json['points'],
      options: json['options'],
      answerIndices: json['answerIndices'],
    );
  }
}