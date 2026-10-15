import 'package:flutter/material.dart';

import 'screens/onboarding.dart';
import 'screens/shell.dart';
import 'state.dart';

void main() => runApp(const NariNirmanApp());

class NariNirmanApp extends StatefulWidget {
  const NariNirmanApp({super.key});

  @override
  State<NariNirmanApp> createState() => _NariNirmanAppState();
}

class _NariNirmanAppState extends State<NariNirmanApp> {
  final AppState state = AppState();

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      state: state,
      child: MaterialApp(
        title: 'NariNirman',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE59A00)),
        ),
        home: ListenableBuilder(
          listenable: state,
          builder: (context, _) =>
              state.onboarded ? const Shell() : const OnboardingScreen(),
        ),
      ),
    );
  }
}
