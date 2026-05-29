import 'package:flutter/material.dart';

/// Destination item for [BeBottomNavBar].
class BeNavDestination {
  const BeNavDestination({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  final Widget icon;
  final Widget selectedIcon;
  final String label;
}

/// Material 3 navigation bar styled with Beneesse semantic tokens.
class BeBottomNavBar extends StatelessWidget {
  const BeBottomNavBar({
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    super.key,
  });

  final List<BeNavDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: [
        for (final destination in destinations)
          NavigationDestination(
            icon: destination.icon,
            selectedIcon: destination.selectedIcon,
            label: destination.label,
          ),
      ],
    );
  }
}
