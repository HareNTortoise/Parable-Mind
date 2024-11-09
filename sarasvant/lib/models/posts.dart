class Posts {
  String id;
  String Title;
  String Body;
  List<String> attachments;
  String studentId;
  List<String> commentIds;

  Posts({
    required this.id,
    required this.Title,
    required this.Body,
    required this.attachments,
    required this.studentId,
    required this.commentIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Title': Title,
      'Body': Body,
      'attachments': attachments,
      'studentId': studentId,
      'commentIds': commentIds,
    };
  }

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
      id: json['id'],
      Title: json['Title'],
      Body: json['Body'],
      attachments: json['attachments'],
      studentId: json['studentId'],
      commentIds: json['commentIds'],
    );
  }
}