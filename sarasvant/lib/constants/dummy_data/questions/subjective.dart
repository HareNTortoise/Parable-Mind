import '../../../models/questions/subjective.dart';

final List<Subjective> dummySubjectives = [
  Subjective(
    id: 'sub_1',
    bankId: '401',
    question: 'Explain Newton’s First Law of Motion with an example.',
    variableIds: [],
    points: 10,
    idealAnswer: 'Newton’s First Law states that an object will remain at rest or in uniform motion unless acted upon by an external force. For example, a book on a table stays at rest until pushed.',
    gradingCriteria: [
      'Defines Newton’s First Law correctly',
      'Provides a clear example',
      'Explanation is coherent and well-structured',
    ],
  ),
  Subjective(
    id: 'sub_2',
    bankId: '402',
    question: 'Discuss the impact of climate change on global agriculture.',
    variableIds: [],
    points: 15,
    idealAnswer: 'Climate change has led to unpredictable weather patterns, affecting crop yields. Increased CO2 levels can enhance photosynthesis in some plants but cause stress in others due to extreme heat and water scarcity.',
    gradingCriteria: [
      'Mentions key effects like temperature, rainfall changes, and crop yields',
      'Includes a discussion on CO2 levels and their dual impact',
      'Provides examples or statistics to support the argument',
    ],
  ),
  Subjective(
    id: 'sub_3',
    bankId: '403',
    question: 'What is the importance of biodiversity in maintaining ecosystem balance?',
    variableIds: [],
    points: 12,
    idealAnswer: 'Biodiversity ensures ecosystem stability by maintaining food chains and nutrient cycles. It helps in pollination, climate regulation, and provides resilience against environmental changes.',
    gradingCriteria: [
      'Explains the role of biodiversity in ecosystems',
      'Mentions at least three specific examples or benefits',
      'Demonstrates understanding of ecosystem balance',
    ],
  ),
  Subjective(
    id: 'sub_4',
    bankId: '404',
    question: 'Describe the process of photosynthesis and its significance for life on Earth.',
    variableIds: [],
    points: 10,
    idealAnswer: 'Photosynthesis is the process by which green plants convert sunlight, carbon dioxide, and water into glucose and oxygen. It is vital as it produces oxygen and forms the base of the food chain.',
    gradingCriteria: [
      'Defines photosynthesis accurately',
      'Details the inputs (sunlight, CO2, water) and outputs (glucose, oxygen)',
      'Mentions its importance for oxygen production and food chains',
    ],
  ),
  Subjective(
    id: 'sub_5',
    bankId: '405',
    question: 'Explain the economic principle of supply and demand with a real-world example.',
    variableIds: [],
    points: 8,
    idealAnswer: 'Supply and demand describe the relationship between the availability of a product and its price. For example, during the COVID-19 pandemic, the high demand for masks and limited supply led to price increases.',
    gradingCriteria: [
      'Defines the principle of supply and demand',
      'Uses a real-world example to illustrate the concept',
      'Shows an understanding of the relationship between supply, demand, and price',
    ],
  ),
];