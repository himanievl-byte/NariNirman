import 'package:flutter/material.dart';

import '../data.dart';
import '../state.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _name = TextEditingController();
  String _lang = 'en';
  final Set<String> _skills = {};
  String _goal = goalOptions.first;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('🌻 NariNirman', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('Seekho. Kamao. Aage Badho.', style: theme.textTheme.titleMedium),
            const SizedBox(height: 24),
            TextField(
              controller: _name,
              decoration: const InputDecoration(
                labelText: 'Your name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Text('Language', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: [
                for (final e in languages.entries) ButtonSegment(value: e.key, label: Text(e.value)),
              ],
              selected: {_lang},
              onSelectionChanged: (s) => setState(() => _lang = s.first),
            ),
            const SizedBox(height: 20),
            Text('What skills do you already have?', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final s in skillOptions)
                  FilterChip(
                    label: Text(s),
                    selected: _skills.contains(s),
                    onSelected: (v) => setState(() {
                      if (v) {
                        _skills.add(s);
                      } else {
                        _skills.remove(s);
                      }
                    }),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Text('What do you want to achieve?', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final g in goalOptions)
                  ChoiceChip(
                    label: Text(g),
                    selected: _goal == g,
                    onSelected: (_) => setState(() => _goal = g),
                  ),
              ],
            ),
            const SizedBox(height: 28),
            SizedBox(
              height: 56,
              child: FilledButton(
                onPressed: () => AppScope.of(context).finishOnboarding(
                  name: _name.text.isEmpty ? 'Sakhi' : _name.text,
                  lang: _lang,
                  skills: _skills,
                  goal: _goal,
                ),
                child: const Text('Start', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
