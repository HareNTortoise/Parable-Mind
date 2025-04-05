import 'package:sarasvant/models/classroom.dart';

final List<Classroom> dummyClassrooms = [
  Classroom(
    id: '101',
    subject: 'Mathematics',
    teacherIds: ['101'],
    assignmentIds: ['201', '202'],
    credits: 4,
  ),
  Classroom(
    id: '102',
    subject: 'Science',
    teacherIds: ['102'],
    assignmentIds: ['203'],
    credits: 3,
  ),
  Classroom(
    id: '103',
    subject: 'History',
    teacherIds: ['103'],
    assignmentIds: ['204'],
    credits: 2,
  ),
  Classroom(
    id: '104',
    subject: 'English',
    teacherIds: ['104'],
    assignmentIds: ['205'],
    credits: 3,
  ),
  Classroom(
    id: '105',
    subject: 'Computer Science',
    teacherIds: ['105'],
    assignmentIds: ['202', '205'],
    credits: 5,
  ),
];