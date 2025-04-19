import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/questions/mcq.dart';
import '../../../blocs/mcq_variation_generation/mcq_variation_bloc.dart';

class MCQVariationDialog extends StatefulWidget {
  final MCQ mcq;

  const MCQVariationDialog({super.key, required this.mcq});

  @override
  MCQVariationDialogState createState() => MCQVariationDialogState();
}

class MCQVariationDialogState extends State<MCQVariationDialog> {
  final List<MCQ> _selectedVariations = [];

  void _toggleSelection(MCQ variation) {
    setState(() {
      if (_selectedVariations.contains(variation)) {
        _selectedVariations.remove(variation);
      } else {
        _selectedVariations.add(variation);
      }
    });
  }

  void _addSelectedVariations() {
    /// TODO : Add the selected variations to the MCQ bank

    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${_selectedVariations.length} MCQs added successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        width: 800,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Generate MCQ Variations',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              BlocConsumer<MCQVariationBloc, MCQVariationState>(
                listener: (context, state) {
                  if (state is MCQVariationFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${state.error}')),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is MCQVariationSuccess) {
                    return Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.variations.length,
                              itemBuilder: (context, index) {
                                final variation = state.variations[index];
                                return Card(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: CheckboxListTile(
                                    title: Text(
                                      variation.question,
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Options:"),
                                        ...variation.options.asMap().entries.map((entry) => Text(
                                          "${String.fromCharCode(97 + entry.key)}) ${entry.value}",
                                        )),
                                        Text("Answer: ${variation.options[variation.answerIndex]}"),
                                      ],
                                    ),
                                    value: _selectedVariations.contains(variation),
                                    onChanged: (_) => _toggleSelection(variation),
                                  ),
                                );
                              },
                            ),
                          ),
                          ElevatedButton(
                            onPressed: _selectedVariations.isNotEmpty ? _addSelectedVariations : null,
                            child: Text('Add Selected Questions'),
                          ),
                        ],
                      ),
                    );
                  } else if (state is MCQVariationInitial) {
                    return Column(
                      children: [
                        Text(
                          'Click the button below to generate MCQ variations.',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            context.read<MCQVariationBloc>().add(GenerateMCQVariations(widget.mcq));
                          },
                          child: Text('Generate Variations'),
                        ),
                      ],
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}