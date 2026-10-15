import 'package:flutter/material.dart';

import '../data.dart';
import '../state.dart';
import 'learn.dart';
import 'sell.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onGo});

  final void Function(int) onGo;

  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    final theme = Theme.of(context);

    // Personalisation: beginners see Sell last with a gentler hint.
    final tiles = <_Tile>[
      _Tile('📚', s.t('learn'), 'Learn a skill', 1, false),
      _Tile('🛍️', s.t('sell'), s.isBeginner ? 'After your first course' : 'List products & services', 2, s.isBeginner),
      _Tile('📍', s.t('participate'), 'Events & stalls near you', 3, false),
      _Tile('🌱', s.t('grow'), 'Badges & progress', 4, false),
    ];
    if (s.isBeginner) {
      final sell = tiles.removeAt(1);
      tiles.add(sell);
    }

    final courseList = s.recommendedCourses.take(2).toList();
    final oppList = s.rankedOpportunities.take(2).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('${s.t('hello')} ${s.name}', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        Text(s.t('ask'), style: theme.textTheme.titleMedium),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.15,
          children: [
            for (final t in tiles)
              Card(
                color: t.dim ? theme.colorScheme.surfaceContainerHighest : theme.colorScheme.primaryContainer,
                child: InkWell(
                  onTap: () => onGo(t.tab),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(t.emoji, style: const TextStyle(fontSize: 34)),
                        const SizedBox(height: 6),
                        Text(t.title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                        Text(t.subtitle, textAlign: TextAlign.center, style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddProductScreen(startWithVoice: true)),
          ),
          icon: const Icon(Icons.mic),
          label: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text('Add a product by speaking'),
          ),
        ),
        const SizedBox(height: 20),
        Text('Recommended for you', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        for (final c in courseList) CourseCard(course: c),
        const SizedBox(height: 12),
        Text('Opportunities near you', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        for (final o in oppList) _OppTile(o: o, onTap: () => onGo(3)),
      ],
    );
  }
}

class _Tile {
  _Tile(this.emoji, this.title, this.subtitle, this.tab, this.dim);
  final String emoji;
  final String title;
  final String subtitle;
  final int tab;
  final bool dim;
}

class _OppTile extends StatelessWidget {
  const _OppTile({required this.o, required this.onTap});
  final Opportunity o;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(o.title),
        subtitle: Text('${o.type} • ${o.km == 0 ? 'Work from home' : '${o.km} km'} • ${o.date}'),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
