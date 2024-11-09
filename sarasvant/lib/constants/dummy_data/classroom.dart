import 'package:sarasvant/models/classroom.dart';

final List<Classroom> dummyClassrooms = [
  Classroom(
    id: '101',
    subject: 'Mathematics',
    teacherId: '101',
    assignmentIds: ['201', '202'],
    credits: 4,
  ),
  Classroom(
    id: '102',
    subject: 'Science',
    teacherId: '102',
    assignmentIds: ['203'],
    credits: 3,
  ),
  Classroom(
    id: '103',
    subject: 'History',
    teacherId: '103',
    assignmentIds: ['204'],
    credits: 2,
  ),
  Classroom(
    id: '104',
    subject: 'English',
    teacherId: '104',
    assignmentIds: ['205'],
    credits: 3,
  ),
  Classroom(
    id: '105',
    subject: 'Computer Science',
    teacherId: '105',
    assignmentIds: ['202', '205'],
    credits: 5,
  ),
];
