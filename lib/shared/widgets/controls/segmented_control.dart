import 'package:flutter/material.dart';

class SegmentedControl extends StatelessWidget {
  final List<String> options;
  final int selectedIndex;
  final ValueChanged<int> onValueChanged;

  const SegmentedControl({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Basic implementation using standard SegmentedButton or custom container
    // Design likely shows a custom look.
    return SegmentedButton<int>(
      segments: List.generate(options.length, (index) {
        return ButtonSegment<int>(
          value: index,
          label: Text(options[index]),
        );
      }),
      selected: {selectedIndex},
      onSelectionChanged: (Set<int> newSelection) {
        onValueChanged(newSelection.first);
      },
      showSelectedIcon: false,
    );
  }
}
