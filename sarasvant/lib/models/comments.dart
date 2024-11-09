class Comments {
  String commentId;
  String commentBody;

  Comments({
    required this.commentId,
    required this.commentBody,
  });

  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId,
      'commentBody': commentBody,
    };
  }

  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(
      commentId: json['commentId'],
      commentBody: json['commentBody'],
    );
  }
}