import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sarasvant/models/question_bank.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/dummy_data/question_bank.dart';

class QuestionBankPage extends StatefulWidget {
  const QuestionBankPage({super.key});

  @override
  QuestionBankPageState createState() => QuestionBankPageState();
}

class QuestionBankPageState extends State<QuestionBankPage> {
  List<QuestionBank> filteredQuestionBanks = dummyQuestionBanks;
  String searchQuery = "";

  void _filterQuestionBanks(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      filteredQuestionBanks = dummyQuestionBanks.where((bank) {
        return bank.chapter.toLowerCase().contains(searchQuery) ||
            bank.topic.toLowerCase().contains(searchQuery);
      }).toList();
    });
  }

  void _navigateToAddQuestionBankPage() {
    context.go('/add_question_bank');
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: 1920,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _navigateToAddQuestionBankPage,
          child: Icon(Icons.add),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: AutoSizeText(
                    "Question Banks",
                    maxLines: 2,
                    minFontSize: 80,
                    style: GoogleFonts.poppins(
                      fontSize: 80,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Question Banks List Container
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            // Search Bar
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    onChanged: _filterQuestionBanks,
                                    decoration: InputDecoration(
                                      hintText: 'Search by chapter or topic...',
                                      prefixIcon: Icon(Icons.search, color: Colors.teal[700]),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // Question Banks List
                            SizedBox(
                              height: 500, // Fixed height for ListView
                              child: ListView.builder(
                                itemCount: filteredQuestionBanks.length,
                                itemBuilder: (context, index) {
                                  final bank = filteredQuestionBanks[index];
                                  return Card(
                                    margin: const EdgeInsets.symmetric(vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        bank.chapter,
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Text(
                                        'Topic: ${bank.topic}',
                                        style: GoogleFonts.poppins(fontSize: 16),
                                      ),
                                      isThreeLine: false,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Gap between columns
                    const SizedBox(width: 50),
                    // Right Container for Info Panel
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 700,
                        padding: const EdgeInsets.all(40),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Info',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Total Banks: ${dummyQuestionBanks.length}',
                              style: GoogleFonts.poppins(fontSize: 18),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Filtered Banks: ${filteredQuestionBanks.length}',
                              style: GoogleFonts.poppins(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
