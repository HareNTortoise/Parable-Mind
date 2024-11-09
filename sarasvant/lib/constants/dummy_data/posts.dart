import 'package:sarasvant/models/posts.dart';

final List<Posts> dummyPosts = [
  Posts(
    id: '501',
    Title: 'Understanding Calculus',
    Body: 'Can anyone help me with limits and derivatives?',
    attachments: ['calculus_notes.pdf'],
    studentId: '301',
    commentIds: ['601', '602'],
  ),
  Posts(
    id: '502',
    Title: 'Science Project Ideas',
    Body: 'Looking for ideas for my upcoming science fair project.',
    attachments: [],
    studentId: '302',
    commentIds: ['603', '604'],
  ),
  Posts(
    id: '503',
    Title: 'History Presentation',
    Body: 'Sharing my presentation slides on World War II.',
    attachments: ['ww2_presentation.pptx'],
    studentId: '303',
    commentIds: ['605'],
  ),
  Posts(
    id: '504',
    Title: 'Essay Writing Tips',
    Body: 'Does anyone have tips for writing a good essay?',
    attachments: [],
    studentId: '304',
    commentIds: ['606', '607'],
  ),
  Posts(
    id: '505',
    Title: 'Python Programming Challenge',
    Body: 'Participate in this week’s coding challenge on recursion.',
    attachments: ['challenge_details.txt'],
    studentId: '305',
    commentIds: ['608', '609', '610'],
  ),
];
