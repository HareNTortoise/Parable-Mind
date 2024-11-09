class QuestionBank {
  String id;
  String qId;
  String chapter;
  String topic;

  QuestionBank({
    required this.id,
    required this.qId,
    required this.chapter,
    required this.topic,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'qId': qId,
      'chapter': chapter,
      'topic': topic,
    };
  }

  factory QuestionBank.fromJson(Map<String, dynamic> json) {
    return QuestionBank(
      id: json['id'],
      qId: json['qId'],
      chapter: json['chapter'],
      topic: json['topic'],
    );
  }
}