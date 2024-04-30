import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Settings",
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
            Column(
              children: [
                // TODO: link to riverpod state + sql
                Card(
                  child: SwitchListTile(
                    value: true,
                    onChanged: (value) {},
                    title: const Text('120 lbs add-on'),
                  ),
                ),
                Card(
                  child: SwitchListTile(
                    value: false,
                    onChanged: (value) {},
                    title: const Text('165 lbs add-on'),
                  ),
                ),
                Card(
                  child: SwitchListTile(
                    value: false,
                    onChanged: (value) {},
                    title: const Text('Heavy Handle Kit'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
