import 'package:flutter/material.dart';
import 'data.dart';

class AppBadge {
  const AppBadge(this.emoji, this.title, this.how, this.earned);
  final String emoji;
  final String title;
  final String how;
  final bool earned;
}

class AppState extends ChangeNotifier {
  String name = '';
  String lang = 'en';
  String goal = '';
  final Set<String> skills = {};
  bool onboarded = false;

  final Set<String> completedCourses = {};
  final Set<String> appliedIds = {};
  final List<Product> products = [];

  String t(String key) => strings[lang]?[key] ?? strings['en']![key] ?? key;

  bool get isBeginner => skills.isEmpty || skills.contains(sNone);

  int get sales => products.fold(0, (sum, p) => sum + p.sold);
  int get revenue => products.fold(0, (sum, p) => sum + p.sold * p.price);

  void finishOnboarding({
    required String name,
    required String lang,
    required Set<String> skills,
    required String goal,
  }) {
    this.name = name.trim();
    this.lang = lang;
    this.skills
      ..clear()
      ..addAll(skills);
    this.goal = goal;
    onboarded = true;
    notifyListeners();
  }

  void setLang(String code) {
    lang = code;
    notifyListeners();
  }

  void completeCourse(String id) {
    completedCourses.add(id);
    notifyListeners();
  }

  void addProduct(Product p) {
    products.insert(0, p);
    notifyListeners();
  }

  void recordSale(Product p) {
    p.sold++;
    notifyListeners();
  }

  void toggleApply(String id) {
    if (!appliedIds.remove(id)) appliedIds.add(id);
    notifyListeners();
  }

  int _courseScore(Course c) {
    var score = 0;
    if (skills.contains(c.skill)) score += 3;
    if (c.category == 'Business' && !isBeginner) score += 1;
    if (isBeginner && c.category == 'Skill') score += 1;
    if (completedCourses.contains(c.id)) score -= 5;
    return score;
  }

  List<Course> get recommendedCourses {
    final list = [...courses];
    list.sort((a, b) => _courseScore(b).compareTo(_courseScore(a)));
    return list;
  }

  bool isRecommended(Course c) => _courseScore(c) >= 3;

  List<Opportunity> get rankedOpportunities {
    final list = [...opportunities];
    int score(Opportunity o) => (skills.contains(o.skill) ? 10 : 0) - o.km;
    list.sort((a, b) => score(b).compareTo(score(a)));
    return list;
  }

  bool matchesSkill(Opportunity o) => skills.contains(o.skill);

  List<AppBadge> get badges => [
        AppBadge('🌟', 'Learning Star', 'Complete your first course', completedCourses.isNotEmpty),
        AppBadge('🛍️', 'First Seller', 'Publish your first product', products.isNotEmpty),
        AppBadge('🎉', 'First Sale', 'Record your first sale', sales >= 1),
        AppBadge('🥈', 'Silver Seller', 'Complete 10 sales', sales >= 10),
        AppBadge('🎓', 'Skill Master', 'Complete 3 courses', completedCourses.length >= 3),
        AppBadge('📍', 'Community Star', 'Apply to a local opportunity', appliedIds.isNotEmpty),
      ];
}

class AppScope extends InheritedNotifier<AppState> {
  const AppScope({super.key, required AppState state, required super.child})
      : super(notifier: state);

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope not found');
    return scope!.notifier!;
  }
}
