# Phase 1
The navigation stack works like a stack of screens. When I use Navigator.push(), DockingBay is placed on top of MissionControl. When I use Navigator.pop(), DockingBay is removed from the stack and MissionControl becomes visible again.

# Phase 2
ListView.builder creates list items as they are needed, making it more efficient for larger collections than manually creating every widget. Each planet is stored in PlanetCatalog.planets. When a user selects an item, the selected Planet object is passed directly to PlanetDetail through its required constructor parameter.