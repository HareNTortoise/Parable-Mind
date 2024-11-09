class Classroom {
  String id;
  String subject;
  String teacherId;
  List<String> assignmentIds;
  int credits;

  Classroom({
    required this.id,
    required this.subject,
    required this.teacherId,
    required this.assignmentIds,
    required this.credits,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject': subject,
      'teacherId': teacherId,
      'assignmentIds': assignmentIds,
      'credits': credits,
    };
  }

  factory Classroom.fromJson(Map<String, dynamic> json) {
    return Classroom(
      id: json['id'],
      subject: json['subject'],
      teacherId: json['teacherId'],
      assignmentIds: json['assignmentIds'],
      credits: json['credits'],
    );
  }
}