import '../../../models/questions/msq.dart';

final List<MSQ> dummyMSQs = [
  MSQ(
    id: 'msq_1',
    bankId: '201',
    question: 'Which of the following are prime numbers?',
    variableIds: [],
    points: 5,
    options: ['2', '4', '7', '9'],
    answerIndices: [0, 2],
  ),
  MSQ(
    id: 'msq_2',
    bankId: '202',
    question: 'Select all the Newton’s Laws of Motion.',
    variableIds: [],
    points: 6,
    options: [
      'Law of Inertia',
      'F = ma',
      'For every action, there is an equal and opposite reaction',
      'Energy cannot be created or destroyed',
    ],
    answerIndices: [0, 1, 2],
  ),
  MSQ(
    id: 'msq_3',
    bankId: '203',
    question: 'Which of the following programming languages are statically typed?',
    variableIds: [],
    points: 5,
    options: ['Java', 'Python', 'C++', 'Ruby'],
    answerIndices: [0, 2],
  ),
  MSQ(
    id: 'msq_4',
    bankId: '204',
    question: 'Identify the renewable sources of energy.',
    variableIds: [],
    points: 4,
    options: ['Solar', 'Wind', 'Coal', 'Natural Gas'],
    answerIndices: [0, 1],
  ),
  MSQ(
    id: 'msq_5',
    bankId: '205',
    question: 'Which of the following are considered acids in chemistry?',
    variableIds: [],
    points: 6,
    options: ['HCl', 'NaOH', 'CH3COOH', 'KOH'],
    answerIndices: [0, 2],
  ),
];