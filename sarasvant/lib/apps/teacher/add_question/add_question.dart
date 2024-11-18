import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:logger/logger.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sarasvant/apps/teacher/add_question/widgets/search_dropdown.dart';
import '../../../constants/app_constants.dart';

class AddQuestion extends StatelessWidget {
  const AddQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: 1920,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: AutoSizeText(
                    AppConstants.appName,
                    maxLines: 2,
                    minFontSize: 80,
                    style: GoogleFonts.poppins(
                      fontSize: 80,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        height: 700,
                        margin: const EdgeInsets.only(right: 50),
                        padding: const EdgeInsets.all(40),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Q.',
                              style: GoogleFonts.jost(fontSize: 32),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: TextFormField(
                                controller: HighlightTextEditingController(
                                  highlightRanges: [
                                    Range(0, 3), // Highlights indices 0 to 2
                                    Range(5, 10), // Highlights indices 5 to 9
                                  ],
                                  onTextSelectionChanged: (start, end) {
                                    // Do something with the selection range
                                  },
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Enter your question here',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: const EdgeInsets.all(30),
                                ),
                                maxLines: 15,
                                style: GoogleFonts.poppins(fontSize: 24),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 700,
                        margin: const EdgeInsets.only(left: 50),
                        padding: const EdgeInsets.all(40),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            SearchDropdown(
                              items: ['MCQ', 'Short Answer', 'Long Answer'],
                              selectedValue: 'MCQ',
                              onChanged: (value) {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HighlightTextEditingController extends TextEditingController {
  final List<Range> highlightRanges;
  final Function(int start, int end)? onTextSelectionChanged;

  HighlightTextEditingController({
    required this.highlightRanges,
    this.onTextSelectionChanged,
  }) : super() {
    // Add a listener to detect text selection changes
    this.addListener(_onSelectionChange);
  }

  // Callback to be triggered when the selection changes
  void _onSelectionChange() {
    final selection = this.selection;
    if (selection != null && selection.isValid) {
      // Call the provided callback with the start and end indices
      onTextSelectionChanged?.call(selection.start, selection.end);
    }
  }

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    bool? withComposing,
  }) {
    style ??= const TextStyle();
    final children = <InlineSpan>[];

    int currentIndex = 0;

    for (final range in highlightRanges) {
      // Skip this range if its end index exceeds the current text length
      if (range.end > text.length) {
        continue;
      }

      // Add non-highlighted text before the current highlight range
      if (currentIndex < range.start) {
        children.add(TextSpan(
          text: text.substring(currentIndex, range.start),
          style: style,
        ));
      }

      // Add highlighted text for the current range as a WidgetSpan
      children.add(WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 1.0),
          child: Text(
            text.substring(range.start, range.end),
            style: style,
          ),
        ),
      ));

      // Update the current index to the end of the highlighted range
      currentIndex = range.end;
    }

    // Add any remaining non-highlighted text after the last highlight range
    if (currentIndex < text.length) {
      children.add(TextSpan(
        text: text.substring(currentIndex),
        style: style,
      ));
    }

    return TextSpan(style: style, children: children);
  }
}

class Range {
  final int start;
  final int end;

  Range(this.start, this.end);
}
