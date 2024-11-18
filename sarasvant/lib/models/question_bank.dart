class QuestionBank {
  String id;
  String name;
  String subject;
  String topic;
  List<String> tags;

  QuestionBank({
    required this.id,
    required this.name,
    required this.subject,
    required this.topic,
    required this.tags,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'subject': subject,
      'topic': topic,
      'tags': tags,
    };
  }

  factory QuestionBank.fromJson(Map<String, dynamic> json) {
    return QuestionBank(
      id: json['id'],
      name: json['name'],
      subject: json['subject'],
      topic: json['topic'],
      tags: json['tags'],
    );
  }
}