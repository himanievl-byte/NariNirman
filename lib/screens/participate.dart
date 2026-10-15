import 'package:flutter/material.dart';

import '../data.dart';
import '../state.dart';

class ParticipateScreen extends StatefulWidget {
  const ParticipateScreen({super.key});

  @override
  State<ParticipateScreen> createState() => _ParticipateScreenState();
}

class _ParticipateScreenState extends State<ParticipateScreen> {
  bool _within10 = false;
  bool _mySkills = false;

  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    var list = s.rankedOpportunities;
    if (_within10) list = list.where((o) => o.km <= 10).toList();
    if (_mySkills) list = list.where(s.matchesSkill).toList();

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Wrap(
          spacing: 8,
          children: [
            FilterChip(
              label: const Text('Within 10 km'),
              selected: _within10,
              onSelected: (v) => setState(() => _within10 = v),
            ),
            FilterChip(
              label: const Text('Matches my skills'),
              selected: _mySkills,
              onSelected: (v) => setState(() => _mySkills = v),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Card(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Safety tip: check the organizer and payment details before you go. '
              'Tell a trusted person where you are going. Sample data shown for demo.',
            ),
          ),
        ),
        if (list.isEmpty) const Padding(padding: EdgeInsets.all(24), child: Center(child: Text('Nothing matches these filters.'))),
        for (final o in list) _OpportunityCard(o: o),
      ],
    );
  }
}

class _OpportunityCard extends StatelessWidget {
  const _OpportunityCard({required this.o});
  final Opportunity o;

  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    final applied = s.appliedIds.contains(o.id);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(o.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Wrap(
              spacing: 6,
              children: [
                Chip(label: Text(o.type)),
                if (o.verified) const Chip(avatar: Icon(Icons.verified, size: 18), label: Text('Verified organizer')),
                if (!o.verified) const Chip(label: Text('Not yet verified')),
                if (s.matchesSkill(o)) const Chip(label: Text('Matches your skill')),
              ],
            ),
            Text('${o.place} • ${o.km == 0 ? 'Work from home' : '${o.km} km'}'),
            Text('Date: ${o.date}  •  Apply by ${o.deadline}'),
            Text('Pay: ${o.pay}'),
            Text('Organizer: ${o.organizer}'),
            const SizedBox(height: 8),
            applied
                ? OutlinedButton.icon(
                    onPressed: () => s.toggleApply(o.id),
                    icon: const Icon(Icons.check),
                    label: const Text('Applied (tap to withdraw)'),
                  )
                : FilledButton(onPressed: () => s.toggleApply(o.id), child: const Text('Apply')),
          ],
        ),
      ),
    );
  }
}
