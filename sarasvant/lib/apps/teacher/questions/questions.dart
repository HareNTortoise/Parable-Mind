import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sarasvant/models/questions.dart';
import 'package:go_router/go_router.dart';
import '../../../constants/dummy_data/questions.dart';

class Questions extends StatefulWidget {
  const Questions({super.key});

  @override
  QuestionsState createState() => QuestionsState();
}

class QuestionsState extends State<Questions> {
  List<Question> filteredQuestions = dummyQuestions;
  String searchQuery = "";
  String searchMode = "Search by question"; // Default search mode
  double minPoints = 0;
  double maxPoints = 100;

  // All tags from dummy data
  final List<String> allTags = dummyQuestions
      .expand((question) => question.tags)
      .toSet()
      .toList();

  // Calculating additional details for the "Info" panel
  int get totalMarks => filteredQuestions.fold(0, (sum, question) => sum + question.points);

  double get averagePoints => filteredQuestions.isNotEmpty
      ? totalMarks / filteredQuestions.length
      : 0.0;

  int get totalTags => filteredQuestions.expand((q) => q.tags).toSet().length;

  void _filterQuestions(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      _applyFilters();
    });
  }

  void _applyFilters() {
    setState(() {
      if (searchMode == "Search by question") {
        filteredQuestions = dummyQuestions.where((question) {
          return question.question.toLowerCase().contains(searchQuery);
        }).toList();
      } else if (searchMode == "Filter by tags" && searchQuery.isNotEmpty) {
        filteredQuestions = dummyQuestions.where((question) {
          return question.tags.contains(searchQuery);
        }).toList();
      } else if (searchMode == "Filter by points") {
        filteredQuestions = dummyQuestions.where((question) {
          return question.points >= minPoints && question.points <= maxPoints;
        }).toList();
      } else {
        filteredQuestions = dummyQuestions;
      }
    });
  }

  void _navigateToAddQuestionPage() {
    context.go('/add_question');
  }

  void _updateSearchMode(String mode) {
    setState(() {
      searchMode = mode;
      searchQuery = ""; // Reset search query
      filteredQuestions = dummyQuestions; // Reset filtered questions

      if (mode == "Filter by points") {
        // Show all questions within default points range
        minPoints = 0;
        maxPoints = 100;
        _applyFilters();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: 1920,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _navigateToAddQuestionPage,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Questions List Container
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
                            // Search Bar and Filter Options
                            Row(
                              children: [
                                // Conditional Search or Filter Widgets
                                Expanded(
                                  child: searchMode == "Filter by points"
                                      ? Column(
                                    children: [
                                      Text(
                                        "Points Range",
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.teal[900],
                                        ),
                                      ),
                                      RangeSlider(
                                        values: RangeValues(minPoints, maxPoints),
                                        min: 0,
                                        max: 100,
                                        divisions: 20,
                                        labels: RangeLabels(
                                          minPoints.toStringAsFixed(0),
                                          maxPoints.toStringAsFixed(0),
                                        ),
                                        onChanged: (values) {
                                          setState(() {
                                            minPoints = values.start;
                                            maxPoints = values.end;
                                            _applyFilters();
                                          });
                                        },
                                      ),
                                    ],
                                  )
                                      : SearchBar(
                                    onChanged: _filterQuestions,
                                    hintText: searchMode == "Search by question"
                                        ? 'Search questions...'
                                        : 'Search tags...',
                                    leading: Icon(Icons.search, color: Colors.teal[700]),
                                    padding: WidgetStateProperty.all(
                                      EdgeInsets.symmetric(horizontal: 20),
                                    ),
                                    textStyle: WidgetStateProperty.all(
                                      GoogleFonts.poppins(color: Colors.teal[900]),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                // Filter Options Menu
                                PopupMenuButton<String>(
                                  onSelected: _updateSearchMode,
                                  icon: Icon(Icons.filter_list, color: Colors.teal[700]),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: "Search by question",
                                      child: Text("Search by question"),
                                    ),
                                    PopupMenuItem(
                                      value: "Filter by tags",
                                      child: Text("Filter by tags"),
                                    ),
                                    PopupMenuItem(
                                      value: "Filter by points",
                                      child: Text("Filter by points"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // Tags filter display when "Filter by tags" is selected
                            if (searchMode == "Filter by tags")
                              Wrap(
                                spacing: 8.0,
                                runSpacing: 4.0,
                                children: allTags.map((tag) {
                                  return ChoiceChip(
                                    label: Text(tag),
                                    selected: searchQuery == tag,
                                    onSelected: (selected) {
                                      setState(() {
                                        searchQuery = selected ? tag : "";
                                        _applyFilters();
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                            const SizedBox(height: 20),
                            // Questions List with SizedBox for Constraining Height
                            SizedBox(
                              height: 500, // Fixed height for ListView
                              child: ListView.builder(
                                itemCount: filteredQuestions.length,
                                itemBuilder: (context, index) {
                                  final question = filteredQuestions[index];
                                  return Card(
                                    margin: const EdgeInsets.symmetric(vertical: 10),
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
                                      subtitle: Text(
                                        'Tags: ${question.tags.join(", ")}\nPoints: ${question.points}',
                                        style: GoogleFonts.poppins(fontSize: 16),
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
                          borderRadius: BorderRadius.circular(50),
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
                              'Total Questions: ${dummyQuestions.length}',
                              style: GoogleFonts.poppins(fontSize: 18),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Filtered Questions: ${filteredQuestions.length}',
                              style: GoogleFonts.poppins(fontSize: 18),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Total Marks: $totalMarks',
                              style: GoogleFonts.poppins(fontSize: 18),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Average Points per Question: ${averagePoints.toStringAsFixed(1)}',
                              style: GoogleFonts.poppins(fontSize: 18),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Unique Tags: $totalTags',
                              style: GoogleFonts.poppins(fontSize: 18),
                            ),
                            const SizedBox(height: 20),
                            // Additional insights can be added here
                            Text(
                              'Tags Summary:',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              child: ListView(
                                children: filteredQuestions
                                    .expand((q) => q.tags)
                                    .toSet()
                                    .map((tag) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 2),
                                  child: Text(
                                    '• $tag',
                                    style: GoogleFonts.poppins(fontSize: 16),
                                  ),
                                ))
                                    .toList(),
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
