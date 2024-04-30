import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ironmaster_dumbbell_calculator/providers/settings.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SettingsState settingsState = ref.watch(settingsProvider);
    final SettingsNotifier settingsNotifier =
        ref.watch(settingsProvider.notifier);

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
                    value: settingsState.has120lbsAddOn,
                    onChanged: (value) {
                      if (!value && settingsState.has165lbsAddOn) {
                        settingsNotifier.toggle165lbsAddOn();
                      }

                      settingsNotifier.toggle120lbsAddOn();
                    },
                    title: const Text('120 lbs add-on'),
                  ),
                ),
                Card(
                  child: SwitchListTile(
                    value: settingsState.has165lbsAddOn,
                    onChanged: (value) {
                      if (value && !settingsState.has120lbsAddOn) {
                        settingsNotifier.toggle120lbsAddOn();
                      }

                      settingsNotifier.toggle165lbsAddOn();
                    },
                    title: const Text('165 lbs add-on'),
                  ),
                ),
                Card(
                  child: SwitchListTile(
                    value: settingsState.hasHeavyHandleKit,
                    onChanged: (value) {
                      settingsNotifier.toggleHeavyHandleKit();
                    },
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
