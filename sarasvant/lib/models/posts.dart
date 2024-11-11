class Posts {
  String id;
  String title;
  String body;
  List<String> attachments;
  String studentId;
  List<String> commentIds;

  Posts({
    required this.id,
    required this.title,
    required this.body,
    required this.attachments,
    required this.studentId,
    required this.commentIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'attachments': attachments,
      'studentId': studentId,
      'commentIds': commentIds,
    };
  }

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      attachments: json['attachments'],
      studentId: json['studentId'],
      commentIds: json['commentIds'],
    );
  }
}