import 'package:sarasvant/models/questions.dart';
import 'package:sarasvant/models/variable.dart';

final List<Question> dummyQuestions = [
  // Questions for Algebra Basics (bankId: '101')
  Question(
    id: 'Q1',
    bankId: '101',
    question: 'What is the value of x if 2x + 3 = 7?',
    tags: ['algebra', 'linear', 'mathematics'],
    variable: [
      Variable(
        id: 'V1',
        name: 'x',
        namePosition: {'en': (0, 1)},
        valuePosition: {'en': (2, 3)},
        unit: '',
        unitPosition: {'en': (4, 4)},
        variableType: 'int',
      ),
    ],
    points: 5,
  ),
  Question(
    id: 'Q2',
    bankId: '101',
    question: 'Solve for y in the equation: y - 5 = 10',
    tags: ['algebra', 'linear', 'mathematics'],
    variable: [
      Variable(
        id: 'V2',
        name: 'y',
        namePosition: {'en': (0, 1)},
        valuePosition: {'en': (2, 3)},
        unit: '',
        unitPosition: {'en': (4, 4)},
        variableType: 'int',
      ),
    ],
    points: 6,
  ),

  // Questions for Physics Fundamentals (bankId: '102')
  Question(
    id: 'Q3',
    bankId: '102',
    question: 'What is the force if mass is 10kg and acceleration is 5m/s²?',
    tags: ['physics', 'force', 'newton'],
    variable: [
      Variable(
        id: 'V3',
        name: 'Force',
        namePosition: {'en': (0, 5)},
        valuePosition: {'en': (6, 11)},
        unit: 'N',
        unitPosition: {'en': (12, 12)},
        variableType: 'double',
      ),
    ],
    points: 8,
  ),
  Question(
    id: 'Q4',
    bankId: '102',
    question: 'State Newton’s Second Law of Motion.',
    tags: ['physics', 'laws of motion'],
    variable: [],
    points: 4,
  ),

  // Questions for Chemical Reactions (bankId: '103')
  Question(
    id: 'Q5',
    bankId: '103',
    question: 'What is the pH level of a neutral solution?',
    tags: ['chemistry', 'acid', 'base', 'reactions'],
    variable: [
      Variable(
        id: 'V5',
        name: 'pH',
        namePosition: {'en': (0, 2)},
        valuePosition: {'en': (3, 4)},
        unit: '',
        unitPosition: {'en': (5, 5)},
        variableType: 'double',
      ),
    ],
    points: 7,
  ),
  Question(
    id: 'Q6',
    bankId: '103',
    question: 'Identify the products of HCl + NaOH reaction.',
    tags: ['chemistry', 'reactions'],
    variable: [],
    points: 9,
  ),

  // Questions for World War II (bankId: '104')
  Question(
    id: 'Q7',
    bankId: '104',
    question: 'What were the main causes of World War II?',
    tags: ['history', 'war', 'politics', 'WWII'],
    variable: [],
    points: 6,
  ),
  Question(
    id: 'Q8',
    bankId: '104',
    question: 'Who was the leader of Germany during World War II?',
    tags: ['history', 'war', 'WWII'],
    variable: [],
    points: 5,
  ),

  // Questions for Computer Basics (bankId: '105')
  Question(
    id: 'Q9',
    bankId: '105',
    question: 'Define algorithm in computer science.',
    tags: ['computers', 'algorithms', 'programming'],
    variable: [],
    points: 4,
  ),
  Question(
    id: 'Q10',
    bankId: '105',
    question: 'What is the purpose of a flowchart?',
    tags: ['computers', 'logic', 'programming'],
    variable: [],
    points: 6,
  ),
];
