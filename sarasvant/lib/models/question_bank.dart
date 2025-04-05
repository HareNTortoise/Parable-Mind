class QuestionBank {
  String id;
  String chapter;
  String topic;
  String teacherId;

  QuestionBank({
    required this.id,
    required this.chapter,
    required this.topic,
    required this.teacherId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chapter': chapter,
      'topic': topic,
      'teacherId': teacherId,
    };
  }

  factory QuestionBank.fromJson(Map<String, dynamic> json) {
    return QuestionBank(
      id: json['id'],
      chapter: json['chapter'],
      topic: json['topic'],
      teacherId: json['teacherId'],
    );
  }
}