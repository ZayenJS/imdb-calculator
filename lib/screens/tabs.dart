import 'package:flutter/material.dart';
import 'package:ironmaster_dumbbell_calculator/screens/home.dart';
import 'package:ironmaster_dumbbell_calculator/screens/settings.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );

    _tabController.animation!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: const [
            HomeScreen(),
            SettingsScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _tabController.index,
        selectedItemColor: Theme.of(context).colorScheme.onSecondary,
        unselectedItemColor:
            Theme.of(context).colorScheme.onSecondary.withOpacity(0.5),
        onTap: (index) {
          setState(() {
            _tabController.animateTo(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            _tabController.index = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
