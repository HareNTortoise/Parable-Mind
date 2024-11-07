import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../constants/app_constants.dart';
import 'components/wide_tile.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: 1920,
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  SizedBox(
                    width: 200,
                    height: 60,
                    child: FilledButton.tonal(
                      onPressed: () {},
                      child: Text('Logout', style: GoogleFonts.poppins(fontSize: 24)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: WideTile(
                            title: AutoSizeText(
                              "Question Banks",
                              style: GoogleFonts.poppins(
                                  fontSize: 46
                              ),
                            ),
                            subTitle: AutoSizeText(
                              "Manage your questions banks",
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                            description: AutoSizeText(
                              "Questions banks serve as a repository for all of your subjects whether organized by class, subjects, difficulties etc.",
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                            backgroundColor: Colors.redAccent[100]!,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.push('/home/add_question'),
                          child: WideTile(
                            title: AutoSizeText(
                              "Questions",
                              style: GoogleFonts.poppins(
                                fontSize: 46,
                              ),
                            ),
                            subTitle: AutoSizeText(
                              "Add a new question",
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                            description: AutoSizeText(
                              "A special question entry powered by AI to help you create questions faster.",
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                            backgroundColor: Colors.deepPurpleAccent[100]!,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => context.push('/home/classrooms'),
                          child: WideTile(
                            title: AutoSizeText(
                              "Classrooms",
                              style: GoogleFonts.poppins(
                                fontSize: 46,
                              ),
                            ),
                            subTitle: AutoSizeText(
                              "Manage classrooms",
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                            description: AutoSizeText(
                              "Manager your classrooms, add students, teachers, and assign subjects to them.",
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                            backgroundColor: Colors.orangeAccent[100]!,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.push('/home/assignments'),
                          child: WideTile(
                            title: AutoSizeText(
                              "Assignments",
                              style: GoogleFonts.poppins(
                                fontSize: 46,
                              ),
                            ),
                            subTitle: AutoSizeText(
                              "Create and export assignments",
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                            description: AutoSizeText(
                              "Use AI powered assignment creator to create randomized assignments.",
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                            backgroundColor: Colors.greenAccent[200]!,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
