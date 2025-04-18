class QuestionBank {
  String id;
  String name;
  String topic;
  String teacherId;

  QuestionBank({
    required this.id,
    required this.name,
    required this.topic,
    required this.teacherId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'topic': topic,
      'teacherId': teacherId,
    };
  }

  factory QuestionBank.fromJson(Map<String, dynamic> json) {
    return QuestionBank(
      id: json['id'],
      name: json['name'],
      topic: json['topic'],
      teacherId: json['teacherId'],
    );
  }
}