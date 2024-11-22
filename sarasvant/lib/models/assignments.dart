import 'package:sarasvant/models/questions/mcq.dart';
import 'package:sarasvant/models/questions/msq.dart';
import 'package:sarasvant/models/questions/nat.dart';
import 'package:sarasvant/models/questions/subjective.dart';

class Assignments {
  String id;
  String title;
  String body;
  DateTime dueDate;
  DateTime createdAt;
  int points;
  List<String> commentIds;
  List<MCQ>? mcqs;
  List<MSQ>? msqs;
  List<NAT>? nats;
  List<Subjective>? subjectives;

  Assignments({
    required this.id,
    required this.title,
    required this.body,
    required this.dueDate,
    required this.createdAt,
    required this.points,
    required this.commentIds,
    this.mcqs,
    this.msqs,
    this.nats,
    this.subjectives,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'dueDate': dueDate,
      'createdAt': createdAt,
      'points': points,
      'commentIds': commentIds,
      'mcqs': mcqs,
      'msqs': msqs,
      'nats': nats,
      'subjectives': subjectives,
    };
  }

  factory Assignments.fromJson(Map<String, dynamic> json) {
    return Assignments(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      dueDate: json['dueDate'],
      createdAt: json['createdAt'],
      points: json['points'],
      commentIds: json['commentIds'],
      mcqs: json['mcqs'],
      msqs: json['msqs'],
      nats: json['nats'],
      subjectives: json['subjectives'],
    );
  }
}