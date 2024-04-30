import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ironmaster_dumbbell_calculator/models/settings.dart';

class SettingsState {
  final bool has120lbsAddOn;
  final bool has165lbsAddOn;
  final bool hasHeavyHandleKit;

  const SettingsState({
    this.has120lbsAddOn = false,
    this.has165lbsAddOn = false,
    this.hasHeavyHandleKit = false,
  });

  SettingsState copyWith({
    bool? has120lbsAddOn,
    bool? has165lbsAddOn,
    bool? hasHeavyHandleKit,
  }) {
    return SettingsState(
      has120lbsAddOn: has120lbsAddOn ?? this.has120lbsAddOn,
      has165lbsAddOn: has165lbsAddOn ?? this.has165lbsAddOn,
      hasHeavyHandleKit: hasHeavyHandleKit ?? this.hasHeavyHandleKit,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(const SettingsState());

  void toggle120lbsAddOn() {
    state = state.copyWith(has120lbsAddOn: !state.has120lbsAddOn);

    Settings(
      has120lbsAddOn: state.has120lbsAddOn,
      has165lbsAddOn: state.has165lbsAddOn,
      hasHeavyHandleKit: state.hasHeavyHandleKit,
    ).update();
  }

  void toggle165lbsAddOn() {
    state = state.copyWith(has165lbsAddOn: !state.has165lbsAddOn);
    Settings(
      has120lbsAddOn: state.has120lbsAddOn,
      has165lbsAddOn: state.has165lbsAddOn,
      hasHeavyHandleKit: state.hasHeavyHandleKit,
    ).update();
  }

  void toggleHeavyHandleKit() {
    state = state.copyWith(hasHeavyHandleKit: !state.hasHeavyHandleKit);
    Settings(
      has120lbsAddOn: state.has120lbsAddOn,
      has165lbsAddOn: state.has165lbsAddOn,
      hasHeavyHandleKit: state.hasHeavyHandleKit,
    ).update();
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>(
  (ref) => SettingsNotifier(),
);
