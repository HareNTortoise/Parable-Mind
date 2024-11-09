class Assignments {
  String id;
  String Title;
  String Body;
  List<String> attachments;
  DateTime dueDate;
  DateTime createdAt;
  int points;
  List<String> commentIds;

  Assignments({
    required this.id,
    required this.Title,
    required this.Body,
    required this.attachments,
    required this.dueDate,
    required this.createdAt,
    required this.points,
    required this.commentIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Title': Title,
      'Body': Body,
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
      Title: json['Title'],
      Body: json['Body'],
      attachments: json['attachments'],
      dueDate: json['dueDate'],
      createdAt: json['createdAt'],
      points: json['points'],
      commentIds: json['commentIds'],
    );
  }

}