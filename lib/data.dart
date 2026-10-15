// Sample content for the MVP demo. In production this moves to Firestore.

const sCook = 'Cooking & baking';
const sStitch = 'Stitching & embroidery';
const sCrochet = 'Crochet & knitting';
const sBeauty = 'Beauty & makeup';
const sCraft = 'Painting & handicrafts';
const sRangoli = 'Rangoli & decoration';
const sFarm = 'Farming products';
const sNone = 'No specific skill yet';
const sBusiness = 'Business';

const skillOptions = [sCook, sStitch, sCrochet, sBeauty, sCraft, sRangoli, sFarm, sNone];

const goalOptions = [
  'Start a business',
  'Sell what I already make',
  'Get more customers',
  'Learn a new skill',
  'Earn by providing services',
  'Join local events',
];

const languages = {'en': 'English', 'hi': 'हिन्दी', 'pa': 'ਪੰਜਾਬੀ'};

const strings = {
  'en': {
    'hello': 'Sat Sri Akal!',
    'ask': 'What would you like to do today?',
    'learn': 'LEARN',
    'sell': 'SELL',
    'participate': 'PARTICIPATE',
    'grow': 'GROW',
    'home': 'Home',
    'profile': 'Progress',
  },
  'hi': {
    'hello': 'नमस्ते!',
    'ask': 'आज आप क्या करना चाहेंगी?',
    'learn': 'सीखें',
    'sell': 'बेचें',
    'participate': 'भाग लें',
    'grow': 'आगे बढ़ें',
    'home': 'होम',
    'profile': 'प्रगति',
  },
  'pa': {
    'hello': 'ਸਤ ਸ੍ਰੀ ਅਕਾਲ!',
    'ask': 'ਅੱਜ ਤੁਸੀਂ ਕੀ ਕਰਨਾ ਚਾਹੋਗੇ?',
    'learn': 'ਸਿੱਖੋ',
    'sell': 'ਵੇਚੋ',
    'participate': 'ਹਿੱਸਾ ਲਓ',
    'grow': 'ਅੱਗੇ ਵਧੋ',
    'home': 'ਹੋਮ',
    'profile': 'ਤਰੱਕੀ',
  },
};

class Course {
  const Course({
    required this.id,
    required this.title,
    required this.category,
    required this.skill,
    required this.minutes,
    required this.emoji,
    required this.lessons,
    required this.question,
    required this.options,
    required this.answer,
    required this.nextStep,
  });

  final String id;
  final String title;
  final String category; // 'Skill' or 'Business'
  final String skill; // one of the skill constants, or sBusiness
  final int minutes;
  final String emoji;
  final List<String> lessons;
  final String question;
  final List<String> options;
  final int answer;
  final String nextStep;
}

const courses = <Course>[
  Course(
    id: 'c1',
    title: 'Crochet bags for beginners',
    category: 'Skill',
    skill: sCrochet,
    minutes: 6,
    emoji: '🧶',
    lessons: ['Choosing yarn and hook', 'Basic chain and stitches', 'Making the bag base', 'Adding handles'],
    question: 'Which stitch do you start almost every crochet project with?',
    options: ['Chain stitch', 'Satin stitch', 'Running stitch'],
    answer: 0,
    nextStep: 'Now list your first crochet bag in SELL.',
  ),
  Course(
    id: 'c2',
    title: 'Diya decoration & painting',
    category: 'Skill',
    skill: sRangoli,
    minutes: 5,
    emoji: '🪔',
    lessons: ['Preparing plain diyas', 'Colours and patterns', 'Adding mirrors and beads', 'Drying and packing'],
    question: 'What should you do before painting a clay diya?',
    options: ['Soak it in oil', 'Clean it and apply a base coat', 'Heat it on a stove'],
    answer: 1,
    nextStep: 'Take the 7-day Diya Business challenge or list your diyas for Diwali.',
  ),
  Course(
    id: 'c3',
    title: 'Phulkari & basic embroidery',
    category: 'Skill',
    skill: sStitch,
    minutes: 7,
    emoji: '🧵',
    lessons: ['Fabric and thread', 'Darning stitch basics', 'Simple phulkari motif', 'Finishing the edges'],
    question: 'Phulkari is traditionally from which state?',
    options: ['Punjab', 'Kerala', 'Assam'],
    answer: 0,
    nextStep: 'Look for tailoring and embroidery orders in PARTICIPATE.',
  ),
  Course(
    id: 'c4',
    title: 'Homemade snacks & food hygiene',
    category: 'Skill',
    skill: sCook,
    minutes: 6,
    emoji: '🍪',
    lessons: ['Kitchen hygiene', 'Safe storage', 'Packaging food', 'Costing a menu'],
    question: 'When should you wash your hands while preparing food?',
    options: ['Only at the end', 'Before starting and after handling raw items', 'Never, if you wear gloves'],
    answer: 1,
    nextStep: 'Find catering opportunities in PARTICIPATE.',
  ),
  Course(
    id: 'c5',
    title: 'Bridal makeup basics',
    category: 'Skill',
    skill: sBeauty,
    minutes: 7,
    emoji: '💄',
    lessons: ['Skin prep', 'Base and contouring', 'Eyes and lips', 'Hygiene for tools'],
    question: 'What should you always do between clients?',
    options: ['Nothing', 'Clean and sanitise brushes', 'Change the lighting'],
    answer: 1,
    nextStep: 'Promote your beauty services in SELL.',
  ),
  Course(
    id: 'b1',
    title: 'How to price your product',
    category: 'Business',
    skill: sBusiness,
    minutes: 5,
    emoji: '💰',
    lessons: ['Material cost', 'Your labour', 'Packaging', 'Adding profit'],
    question: 'Material ₹100, packaging ₹20, labour ₹80, desired profit ₹100. Selling price?',
    options: ['₹200', '₹300', '₹250'],
    answer: 1,
    nextStep: 'Use the pricing calculator on the Progress tab.',
  ),
  Course(
    id: 'b2',
    title: 'Product photos with your phone',
    category: 'Business',
    skill: sBusiness,
    minutes: 4,
    emoji: '📸',
    lessons: ['Use daylight', 'Plain background', 'Show details', 'Take 3 angles'],
    question: 'What lighting gives the best phone photos?',
    options: ['Natural daylight', 'Dark room', 'Flash in the dark'],
    answer: 0,
    nextStep: 'Add photos to your product listing in SELL.',
  ),
  Course(
    id: 'b3',
    title: 'Sell on WhatsApp',
    category: 'Business',
    skill: sBusiness,
    minutes: 5,
    emoji: '💬',
    lessons: ['Business profile', 'Product catalogue', 'Status updates', 'Handling customers politely'],
    question: 'Which WhatsApp feature lets you show many products in one place?',
    options: ['Catalogue', 'Block list', 'Disappearing messages'],
    answer: 0,
    nextStep: 'Share a ready message from your listing in SELL.',
  ),
];

class Opportunity {
  const Opportunity({
    required this.id,
    required this.title,
    required this.type,
    required this.skill,
    required this.place,
    required this.km,
    required this.date,
    required this.pay,
    required this.organizer,
    required this.deadline,
    this.verified = true,
  });

  final String id;
  final String title;
  final String type; // Paid, Competition, Stall, Voluntary
  final String skill;
  final String place;
  final int km;
  final String date;
  final String pay;
  final String organizer;
  final String deadline;
  final bool verified;
}

const opportunities = <Opportunity>[
  Opportunity(
    id: 'o1',
    title: 'Diwali Rangoli & Decoration',
    type: 'Competition',
    skill: sRangoli,
    place: 'Community hall',
    km: 4,
    date: '18 Oct',
    pay: 'Prize money, set by organizer',
    organizer: 'Gram Panchayat (sample)',
    deadline: '15 Oct',
  ),
  Opportunity(
    id: 'o2',
    title: 'Handicraft Mela - stall applications',
    type: 'Stall',
    skill: sCraft,
    place: 'District fairground',
    km: 12,
    date: '2 Nov',
    pay: 'Stall fee ₹200',
    organizer: 'Self-Help Group Federation (sample)',
    deadline: '25 Oct',
  ),
  Opportunity(
    id: 'o3',
    title: 'Wedding function catering help',
    type: 'Paid',
    skill: sCook,
    place: 'Nearby village',
    km: 7,
    date: '29 Oct',
    pay: '₹1,500 per day',
    organizer: 'Local caterer (sample)',
    deadline: '24 Oct',
  ),
  Opportunity(
    id: 'o4',
    title: 'Bridal makeup assistant',
    type: 'Paid',
    skill: sBeauty,
    place: 'Town salon',
    km: 9,
    date: '5 Nov',
    pay: '₹800 per booking',
    organizer: 'Glow Parlour (sample)',
    deadline: '30 Oct',
    verified: false,
  ),
  Opportunity(
    id: 'o5',
    title: 'School craft workshop',
    type: 'Paid',
    skill: sCrochet,
    place: 'Government school',
    km: 5,
    date: '10 Nov',
    pay: '₹1,000 honorarium',
    organizer: 'School Management (sample)',
    deadline: '5 Nov',
  ),
  Opportunity(
    id: 'o6',
    title: 'Bulk order: 200 festival gift bags',
    type: 'Paid',
    skill: sStitch,
    place: 'Work from home',
    km: 0,
    date: '20 Nov',
    pay: '₹60 per bag',
    organizer: 'NGO (sample)',
    deadline: '10 Nov',
  ),
  Opportunity(
    id: 'o7',
    title: 'Organic produce stall at kisan mela',
    type: 'Stall',
    skill: sFarm,
    place: 'Mandi ground',
    km: 15,
    date: '12 Nov',
    pay: 'Free stall',
    organizer: 'Agriculture Dept (sample)',
    deadline: '8 Nov',
  ),
];

class Product {
  Product({
    required this.name,
    required this.price,
    required this.description,
    required this.qty,
    required this.isService,
  });

  final String name;
  final int price;
  final String description;
  final int qty;
  final bool isService;
  int enquiries = 0;
  int sold = 0;
}
