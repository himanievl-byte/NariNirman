import 'package:flutter/material.dart';

import '../data.dart';
import '../state.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    final all = s.recommendedCourses;
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(tabs: [Tab(text: 'Skills'), Tab(text: 'Business')]),
          Expanded(
            child: TabBarView(
              children: [
                _list(all.where((c) => c.category == 'Skill').toList()),
                _list(all.where((c) => c.category == 'Business').toList()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _list(List<Course> items) => ListView(
        padding: const EdgeInsets.all(12),
        children: [for (final c in items) CourseCard(course: c)],
      );
}

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.course});
  final Course course;

  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    final done = s.completedCourses.contains(course.id);
    return Card(
      child: ListTile(
        leading: Text(course.emoji, style: const TextStyle(fontSize: 30)),
        title: Text(course.title),
        subtitle: Text([
          '${course.lessons.length} lessons • ${course.minutes} min',
          if (s.isRecommended(course) && !done) 'Recommended for you',
        ].join('\n')),
        isThreeLine: s.isRecommended(course) && !done,
        trailing: done ? const Icon(Icons.verified, color: Colors.green) : const Icon(Icons.chevron_right),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => CourseScreen(course: course)),
        ),
      ),
    );
  }
}

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key, required this.course});
  final Course course;

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  int? _picked;
  String? _feedback;

  void _submit() {
    final c = widget.course;
    if (_picked == c.answer) {
      AppScope.of(context).completeCourse(c.id);
      showDialog<void>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('🎓 Course complete!'),
          content: Text('Certificate of completion\n\n${c.title}\n\nNext step: ${c.nextStep}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Done'),
            ),
          ],
        ),
      );
    } else {
      setState(() => _feedback = 'Not quite. Review the lessons and try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.course;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(c.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('${c.emoji}  ${c.minutes} minutes • audio & pictures coming soon', style: theme.textTheme.bodyMedium),
          const SizedBox(height: 12),
          for (var i = 0; i < c.lessons.length; i++)
            ListTile(
              leading: CircleAvatar(child: Text('${i + 1}')),
              title: Text(c.lessons[i]),
              trailing: const Icon(Icons.play_circle_outline),
            ),
          const Divider(height: 32),
          Text('Quick quiz', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(c.question),
          for (var i = 0; i < c.options.length; i++)
            ListTile(
              leading: Icon(_picked == i ? Icons.radio_button_checked : Icons.radio_button_off),
              title: Text(c.options[i]),
              onTap: () => setState(() {
                _picked = i;
                _feedback = null;
              }),
            ),
          if (_feedback != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(_feedback!, style: TextStyle(color: theme.colorScheme.error)),
            ),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: _picked == null ? null : _submit,
            child: const Padding(padding: EdgeInsets.all(12), child: Text('Submit answer')),
          ),
        ],
      ),
    );
  }
}
