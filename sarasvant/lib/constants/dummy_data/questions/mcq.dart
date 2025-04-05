import '../../../models/questions/mcq.dart';

final List<MCQ> dummyMCQs = [
  MCQ(
    id: 'mcq_1',
    bankId: '202',
    question: 'What is the acceleration of an object when a force of 20N is applied to a mass of 5kg?',
    variableIds: [],
    points: 5,
    options: ['2 m/s²', '4 m/s²', '5 m/s²', '10 m/s²'],
    answerIndex: 1,
  ),
  MCQ(
    id: 'mcq_2',
    bankId: '202',
    question: 'What is the frequency of a wave with a speed of 300 m/s and a wavelength of 5 m?',
    variableIds: [],
    points: 5,
    options: ['10 Hz', '50 Hz', '60 Hz', '75 Hz'],
    answerIndex: 2,
  ),
  MCQ(
    id: 'mcq_3',
    bankId: '206',
    question: 'Calculate the area of a rectangle with length 10m and width 5m.',
    variableIds: [],
    points: 5,
    options: ['50 m²', '100 m²', '200 m²', '300 m²'],
    answerIndex: 0,
  ),
  MCQ(
    id: 'mcq_4',
    bankId: '206',
    question: 'What is the potential energy of a 10kg object lifted to a height of 5m? (g = 9.8 m/s²)',
    variableIds: [],
    points: 6,
    options: ['490 J', '980 J', '1960 J', '2940 J'],
    answerIndex: 0,
  ),
  MCQ(
    id: 'mcq_5',
    bankId: '207',
    question: 'What is the volume of a cylinder with radius 2m and height 10m? (Use π = 3.14)',
    variableIds: [],
    points: 6,
    options: ['125.6 m³', '314 m³', '502.4 m³', '628 m³'],
    answerIndex: 0,
  ),
];