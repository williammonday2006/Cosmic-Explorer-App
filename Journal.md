# Phase 1
The navigation stack works like a stack of screens. When I use Navigator.push(), DockingBay is placed on top of MissionControl. When I use Navigator.pop(), DockingBay is removed from the stack and MissionControl becomes visible again.

# Phase 2
ListView.builder creates list items as they are needed, making it more efficient for larger collections than manually creating every widget. Each planet is stored in PlanetCatalog.planets. When a user selects an item, the selected Planet object is passed directly to PlanetDetail through its required constructor parameter.

# Phase 3
When the user taps a planet, MissionControl awaits the Future returned by Navigator.push(). PlanetDetail returns a message through Navigator.pop(context, result). The awaited call receives that result after the detail screen closes. I check context.mounted before showing the SnackBar so the app does not use a context belonging to a widget that has been removed.