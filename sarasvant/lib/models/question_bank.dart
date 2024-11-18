class QuestionBank {
  String id;
  String chapter;
  String topic;

  QuestionBank({
    required this.id,
    required this.chapter,
    required this.topic,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chapter': chapter,
      'topic': topic,
    };
  }

  factory QuestionBank.fromJson(Map<String, dynamic> json) {
    return QuestionBank(
      id: json['id'],
      chapter: json['chapter'],
      topic: json['topic'],
    );
  }
}