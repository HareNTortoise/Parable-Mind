class Assignments {
  String id;
  String title;
  String body;
  List<String> attachments;
  DateTime dueDate;
  DateTime createdAt;
  int points;
  List<String> commentIds;

  Assignments({
    required this.id,
    required this.title,
    required this.body,
    required this.attachments,
    required this.dueDate,
    required this.createdAt,
    required this.points,
    required this.commentIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'attachments': attachments,
      'dueDate': dueDate,
      'createdAt': createdAt,
      'points': points,
      'commentIds': commentIds,
    };
  }

  factory Assignments.fromJson(Map<String, dynamic> json) {
    return Assignments(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      attachments: json['attachments'],
      dueDate: json['dueDate'],
      createdAt: json['createdAt'],
      points: json['points'],
      commentIds: json['commentIds'],
    );
  }

}