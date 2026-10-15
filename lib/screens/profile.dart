import 'package:flutter/material.dart';

import '../data.dart';
import '../services.dart';
import '../state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('🌱 ${s.name}\'s progress', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          children: [
            _Stat('Courses', s.completedCourses.length),
            _Stat('Listings', s.products.length),
            _Stat('Sales', s.sales),
            _Stat('Applied', s.appliedIds.length),
          ],
        ),
        const SizedBox(height: 8),
        Text('Recorded revenue: ₹${s.revenue}  (revenue is before costs; use the calculator to see profit)'),
        const SizedBox(height: 20),
        Text('Badges', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final b in s.badges)
              Tooltip(
                message: b.how,
                child: Chip(
                  avatar: Text(b.emoji),
                  label: Text(b.title),
                  backgroundColor: b.earned ? theme.colorScheme.primaryContainer : theme.colorScheme.surfaceContainerHighest,
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Text('Faded badges are not earned yet. Long-press a badge to see how to earn it.', style: theme.textTheme.bodySmall),
        const SizedBox(height: 20),
        const _PriceCalculator(),
        const SizedBox(height: 20),
        Text('Language', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SegmentedButton<String>(
          segments: [for (final e in languages.entries) ButtonSegment(value: e.key, label: Text(e.value))],
          selected: {s.lang},
          onSelectionChanged: (v) => s.setLang(v.first),
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat(this.label, this.value);
  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              Text('$value', style: Theme.of(context).textTheme.headlineSmall),
              Text(label, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}

class _PriceCalculator extends StatefulWidget {
  const _PriceCalculator();

  @override
  State<_PriceCalculator> createState() => _PriceCalculatorState();
}

class _PriceCalculatorState extends State<_PriceCalculator> {
  final _materials = TextEditingController();
  final _packaging = TextEditingController();
  final _labour = TextEditingController();
  final _profit = TextEditingController();

  @override
  void dispose() {
    for (final c in [_materials, _packaging, _labour, _profit]) {
      c.dispose();
    }
    super.dispose();
  }

  int _v(TextEditingController c) => int.tryParse(c.text) ?? 0;

  Widget _field(String label, TextEditingController c) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: TextField(
          controller: c,
          keyboardType: TextInputType.number,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final cost = _v(_materials) + _v(_packaging) + _v(_labour);
    final price = suggestedPrice(
      materials: _v(_materials),
      packaging: _v(_packaging),
      labour: _v(_labour),
      profit: _v(_profit),
    );
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price calculator', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _field('Materials (₹)', _materials),
            _field('Packaging (₹)', _packaging),
            _field('Your labour (₹)', _labour),
            _field('Profit you want (₹)', _profit),
            Text('Total cost: ₹$cost'),
            Text('Suggested price: ₹$price', style: const TextStyle(fontWeight: FontWeight.bold)),
            const Text('This is only a suggestion. You decide your final price.'),
          ],
        ),
      ),
    );
  }
}
