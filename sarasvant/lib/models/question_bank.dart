class QuestionBank {
  String id;
  String bankId;
  String chapter;
  String topic;

  QuestionBank({
    required this.id,
    required this.bankId,
    required this.chapter,
    required this.topic,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bankId': bankId,
      'chapter': chapter,
      'topic': topic,
    };
  }

  factory QuestionBank.fromJson(Map<String, dynamic> json) {
    return QuestionBank(
      id: json['id'],
      bankId: json['bankId'],
      chapter: json['chapter'],
      topic: json['topic'],
    );
  }
}