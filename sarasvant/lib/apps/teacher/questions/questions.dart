import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sarasvant/models/questions/mcq.dart';
import 'package:sarasvant/models/questions/msq.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/dummy_data/questions/mcq.dart';
import '../../../constants/dummy_data/questions/msq.dart';
import '../../../constants/dummy_data/questions/nat.dart';
import '../../../constants/dummy_data/questions/subjective.dart';

class Questions extends StatefulWidget {
  const Questions({super.key});

  @override
  QuestionsState createState() => QuestionsState();
}

class QuestionsState extends State<Questions> {
  List<dynamic> allQuestions = [
    ...dummyMCQs,
    ...dummyMSQs,
    ...dummyNATs,
    ...dummySubjectives
  ];
  List<dynamic> filteredQuestions = [];
  String searchQuery = "";
  String searchMode = "Search by question";
  String selectedType = "All";
  double minPoints = 0;
  double maxPoints = 100;

  @override
  void initState() {
    super.initState();
    filteredQuestions = allQuestions;
  }

  void _filterQuestions(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      _applyFilters();
    });
  }

  void _applyFilters() {
    setState(() {
      filteredQuestions = allQuestions.where((question) {
        bool matchesSearch = searchMode == "Search by question" ? question.question.toLowerCase().contains(searchQuery) : true;
        bool matchesPoints = searchMode == "Filter by points" ? (question.points >= minPoints && question.points <= maxPoints) : true;
        bool matchesType = selectedType == "All" || question.runtimeType.toString() == selectedType;
        return matchesSearch && matchesPoints && matchesType;
      }).toList();
    });
  }

  void _updateSearchMode(String mode) {
    setState(() {
      searchMode = mode;
      searchQuery = "";
      filteredQuestions = allQuestions;

      if (mode == "Filter by points") {
        minPoints = 0;
        maxPoints = 100;
        _applyFilters();
      }
    });
  }

  void _updateQuestionType(String type) {
    setState(() {
      selectedType = type;
      _applyFilters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: 1920,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.go('/add-question'),
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
                    "Questions",
                    maxLines: 2,
                    minFontSize: 80,
                    style: GoogleFonts.poppins(
                      fontSize: 80,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    onChanged: _filterQuestions,
                                    decoration: InputDecoration(
                                      hintText: 'Search questions...',
                                      prefixIcon: Icon(Icons.search,
                                          color: Colors.teal[700]),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                PopupMenuButton<String>(
                                  onSelected: _updateSearchMode,
                                  icon: Icon(Icons.filter_list,
                                      color: Colors.teal[700]),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: "Search by question",
                                      child: Text("Search by question"),
                                    ),
                                    PopupMenuItem(
                                      value: "Filter by points",
                                      child: Text("Filter by points"),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                DropdownButton<String>(
                                  value: selectedType,
                                  onChanged: (value) => _updateQuestionType(value!),
                                  items: ["All", "MCQ", "MSQ", "NAT", "Subjective"]
                                      .map((type) => DropdownMenuItem(
                                    value: type,
                                    child: Text(type),
                                  ))
                                      .toList(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 500,
                              child: ListView.builder(
                                itemCount: filteredQuestions.length,
                                itemBuilder: (context, index) {
                                  final question = filteredQuestions[index];
                                  return Card(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        question.question,
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text("Type: ${question.runtimeType}",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500)),
                                          if (question is MCQ ||
                                              question is MSQ) ...[
                                            Text("Options:",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.w500)),
                                            ...question.options
                                                .asMap()
                                                .entries
                                                .map((entry) => Text(
                                                "${String.fromCharCode(97 + entry.key as int)}) ${entry.value}",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 16))),
                                          ],
                                          Text("Points: ${question.points}",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                      isThreeLine: true,
                                    ),
                                  );
                                },
                              ),
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