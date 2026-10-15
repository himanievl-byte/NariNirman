import 'package:flutter/material.dart';

import '../state.dart';
import 'home.dart';
import 'learn.dart';
import 'participate.dart';
import 'profile.dart';
import 'sell.dart';

class Shell extends StatefulWidget {
  const Shell({super.key});

  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    final pages = <Widget>[
      HomeScreen(onGo: (i) => setState(() => _index = i)),
      const LearnScreen(),
      const SellScreen(),
      const ParticipateScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      body: SafeArea(child: pages[_index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: [
          NavigationDestination(icon: const Icon(Icons.home), label: s.t('home')),
          NavigationDestination(icon: const Icon(Icons.menu_book), label: s.t('learn')),
          NavigationDestination(icon: const Icon(Icons.storefront), label: s.t('sell')),
          NavigationDestination(icon: const Icon(Icons.place), label: s.t('participate')),
          NavigationDestination(icon: const Icon(Icons.trending_up), label: s.t('profile')),
        ],
      ),
    );
  }
}
