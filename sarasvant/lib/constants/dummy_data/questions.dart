import 'package:sarasvant/models/questions.dart';
import 'package:sarasvant/models/variable.dart';

final List<Questions> dummyQuestions = [
  Questions(
    qId: 'Q1',
    poolId: 'P1',
    question: 'What is the capital of France?',
    variable: [
      Variable(
        name: 'Paris',
        namePosition: {'en': (0, 5)},
        valuePosition: {'en': (6, 11)},
        unit: '',
        unitPosition: {'en': (12, 12)},
        type: {'typeId': 1},
      ),
      Variable(
        name: 'Berlin',
        namePosition: {'en': (0, 6)},
        valuePosition: {'en': (7, 13)},
        unit: '',
        unitPosition: {'en': (14, 14)},
        type: {'typeId': 1},
      ),
    ],
    points: 10,
  ),
  Questions(
    qId: 'Q2',
    poolId: 'P2',
    question: 'Solve: 5 + 3',
    variable: [
      Variable(
        name: '8',
        namePosition: {'en': (0, 1)},
        valuePosition: {'en': (2, 3)},
        unit: '',
        unitPosition: {'en': (4, 4)},
        type: {'typeId': 2},
      ),
      Variable(
        name: '9',
        namePosition: {'en': (0, 1)},
        valuePosition: {'en': (2, 3)},
        unit: '',
        unitPosition: {'en': (4, 4)},
        type: {'typeId': 2},
      ),
    ],
    points: 5,
  ),
  Questions(
    qId: 'Q3',
    poolId: 'P1',
    question: 'What is the chemical symbol for water?',
    variable: [
      Variable(
        name: 'H2O',
        namePosition: {'en': (0, 3)},
        valuePosition: {'en': (4, 7)},
        unit: '',
        unitPosition: {'en': (8, 8)},
        type: {'typeId': 3},
      ),
      Variable(
        name: 'CO2',
        namePosition: {'en': (0, 3)},
        valuePosition: {'en': (4, 7)},
        unit: '',
        unitPosition: {'en': (8, 8)},
        type: {'typeId': 3},
      ),
    ],
    points: 8,
  ),
  Questions(
    qId: 'Q4',
    poolId: 'P3',
    question: 'Who wrote "Romeo and Juliet"?',
    variable: [
      Variable(
        name: 'William Shakespeare',
        namePosition: {'en': (0, 18)},
        valuePosition: {'en': (19, 37)},
        unit: '',
        unitPosition: {'en': (38, 38)},
        type: {'typeId': 4},
      ),
      Variable(
        name: 'Charles Dickens',
        namePosition: {'en': (0, 15)},
        valuePosition: {'en': (16, 31)},
        unit: '',
        unitPosition: {'en': (32, 32)},
        type: {'typeId': 4},
      ),
    ],
    points: 12,
  ),
  Questions(
    qId: 'Q5',
    poolId: 'P2',
    question: 'What is 10 * 10?',
    variable: [
      Variable(
        name: '100',
        namePosition: {'en': (0, 3)},
        valuePosition: {'en': (4, 7)},
        unit: '',
        unitPosition: {'en': (8, 8)},
        type: {'typeId': 5},
      ),
      Variable(
        name: '101',
        namePosition: {'en': (0, 3)},
        valuePosition: {'en': (4, 7)},
        unit: '',
        unitPosition: {'en': (8, 8)},
        type: {'typeId': 5},
      ),
    ],
    points: 7,
  ),
];
