import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sarasvant/models/question_bank.dart';
import 'package:go_router/go_router.dart';
import '../../../constants/dummy_data/question_bank.dart';

class QuestionBankPage extends StatefulWidget {
  const QuestionBankPage({super.key});

  @override
  QuestionBankPageState createState() => QuestionBankPageState();
}

class QuestionBankPageState extends State<QuestionBankPage> {
  List<QuestionBank> filteredQuestionBanks = dummyQuestionBanks;
  String searchQuery = "";
  String searchMode = "Search by name"; // Default search mode

  // All tags from dummy data
  final List<String> allTags = dummyQuestionBanks
      .expand((bank) => bank.tags)
      .toSet()
      .toList();

  void _filterQuestionBanks(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      _applyFilters();
    });
  }

  void _applyFilters() {
    setState(() {
      if (searchMode == "Search by name") {
        filteredQuestionBanks = dummyQuestionBanks.where((bank) {
          return bank.name.toLowerCase().contains(searchQuery);
        }).toList();
      } else if (searchMode == "Filter by tags" && searchQuery.isNotEmpty) {
        filteredQuestionBanks = dummyQuestionBanks.where((bank) {
          return bank.tags.contains(searchQuery);
        }).toList();
      } else {
        filteredQuestionBanks = dummyQuestionBanks;
      }
    });
  }

  void _navigateToAddQuestionBankPage() {
    context.go('/add_question_bank');
  }

  void _updateSearchMode(String mode) {
    setState(() {
      searchMode = mode;
      searchQuery = ""; // Reset search query
      filteredQuestionBanks = dummyQuestionBanks; // Reset filtered question banks
    });
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
                            // Search Bar and Filter Options
                            Row(
                              children: [
                                // Conditional Search or Filter Widgets
                                Expanded(
                                  child: SearchBar(
                                    onChanged: _filterQuestionBanks,
                                    hintText: searchMode == "Search by name"
                                        ? 'Search by name...'
                                        : 'Search by tags...',
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
                                      value: "Search by name",
                                      child: Text("Search by name"),
                                    ),
                                    PopupMenuItem(
                                      value: "Filter by tags",
                                      child: Text("Filter by tags"),
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
                            // Question Banks List with SizedBox for Constraining Height
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
                                        bank.name,
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Text(
                                        'Subject: ${bank.subject}\nTopic: ${bank.topic}\nTags: ${bank.tags.join(", ")}',
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
                            const SizedBox(height: 10),
                            Text(
                              'Unique Tags: ${allTags.length}',
                              style: GoogleFonts.poppins(fontSize: 18),
                            ),
                            const SizedBox(height: 20),
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
                                children: filteredQuestionBanks
                                    .expand((bank) => bank.tags)
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
