import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sarasvant/apps/teacher/assignments/widget/question_tile.dart';
import '../../../constants/dummy_data/questions/mcq.dart';
import '../../../constants/dummy_data/questions/msq.dart';
import '../../../constants/dummy_data/questions/nat.dart';
import '../../../constants/dummy_data/questions/subjective.dart';
import '../../../models/assignments.dart';

class AssignmentDetailPage extends StatelessWidget {
  final Assignments assignment;

  const AssignmentDetailPage({super.key, required this.assignment});

  @override
  Widget build(BuildContext context) {
    final mcqs = dummyMCQs.where((q) => (assignment.mcqIds ?? []).contains(q.id)).toList();
    final msqs = dummyMSQs.where((q) => (assignment.msqIds ?? []).contains(q.id)).toList();
    final nats = dummyNATs.where((q) => (assignment.natIds ?? []).contains(q.id)).toList();
    final subjectives = dummySubjectives.where((q) => (assignment.subjectiveIds ?? []).contains(q.id)).toList();

    return Scaffold(
      appBar: AppBar(title: Text(assignment.title, style: GoogleFonts.poppins())),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(assignment.body, style: GoogleFonts.poppins(fontSize: 14)),
            const SizedBox(height: 16),
            Text("Due: ${assignment.dueDate.toLocal().toString().split(' ')[0]}",
                style: GoogleFonts.poppins(fontSize: 13, color: Colors.red[400])),
            const SizedBox(height: 24),
            ...mcqs.map((q) => QuestionTile(question: q.question, options: q.options, points: q.points)),
            ...msqs.map((q) => QuestionTile(question: q.question, options: q.options, points: q.points)),
            ...nats.map((q) => QuestionTile(question: q.question, points: q.points)),
            ...subjectives.map((q) => QuestionTile(question: q.question, points: q.points)),
          ],
        ),
      ),
    );
  }
}
