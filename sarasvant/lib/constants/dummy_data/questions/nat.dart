import 'package:sarasvant/models/variable.dart';
import '../../../models/questions/nat.dart';

final List<NAT> dummyNATs = [
  NAT(
    id: 'nat_1',
    bankId: '301',
    question: 'What is the value of π (up to 2 decimal places)?',
    variable: [],
    points: 5,
    answer: 314, // Represented as 3.14 * 100 for scaling
  ),
  NAT(
    id: 'nat_2',
    bankId: '302',
    question: 'Calculate the acceleration (m/s²) of an object if force is 20 N and mass is 4 kg.',
    variable: [
      Variable(
        id: 'var_1',
        name: 'Force',
        namePosition: {'start': (0, 0), 'end': (0, 5)},
        valuePosition: {'start': (0, 7), 'end': (0, 9)},
        unit: 'N',
        unitPosition: {'start': (0, 10), 'end': (0, 11)},
        variableType: 'numeric',
      ),
      Variable(
        id: 'var_2',
        name: 'Mass',
        namePosition: {'start': (1, 0), 'end': (1, 4)},
        valuePosition: {'start': (1, 6), 'end': (1, 7)},
        unit: 'kg',
        unitPosition: {'start': (1, 8), 'end': (1, 10)},
        variableType: 'numeric',
      ),
    ],
    points: 8,
    answer: 5, // Answer: 5 m/s²
  ),
  NAT(
    id: 'nat_3',
    bankId: '303',
    question: 'What is the boiling point of water at sea level (in Celsius)?',
    variable: [],
    points: 3,
    answer: 100,
  ),
  NAT(
    id: 'nat_4',
    bankId: '304',
    question: 'Find the value of 7 × 8.',
    variable: [],
    points: 2,
    answer: 56,
  ),
  NAT(
    id: 'nat_5',
    bankId: '305',
    question: 'If the side of a square is 5 cm, calculate its area (in cm²).',
    variable: [
      Variable(
        id: 'var_3',
        name: 'Side Length',
        namePosition: {'start': (0, 0), 'end': (0, 11)},
        valuePosition: {'start': (0, 13), 'end': (0, 14)},
        unit: 'cm',
        unitPosition: {'start': (0, 15), 'end': (0, 17)},
        variableType: 'numeric',
      ),
    ],
    points: 4,
    answer: 25,
  ),
];
