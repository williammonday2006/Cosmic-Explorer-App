import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const CosmicExplorerApp());
}

class Planet {
  final String name;
  final String type;
  final String description;

  const Planet({
    required this.name,
    required this.type,
    required this.description,
  });
}

class PlanetCatalog {
  static const List<Planet> planets = [
    Planet(
      name: 'Mercury',
      type: 'Terrestrial',
      description: 'Mercury is the smallest planet in the Solar System. '
          'It has a rocky surface and extreme temperature changes.',
    ),
    Planet(
      name: 'Mars',
      type: 'Terrestrial',
      description: 'Mars is known as the Red Planet. Scientists study '
          'its surface for evidence of ancient water and possible life.',
    ),
    Planet(
      name: 'Jupiter',
      type: 'Gas Giant',
      description: 'Jupiter is the largest planet in the Solar System. '
          'It has powerful storms and many natural satellites.',
    ),
    Planet(
      name: 'Kepler-186f',
      type: 'Terrestrial',
      description: 'Kepler-186f is an exoplanet orbiting a star outside '
          'our Solar System. It is studied for its potential habitability.',
    ),
    Planet(
      name: 'Proxima Centauri b',
      type: 'Exoplanet',
      description: 'Proxima Centauri b orbits Proxima Centauri, the '
          'nearest known stellar neighbor to our Solar System.',
    ),
  ];
}

final GoRouter myRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MissionControl(),
    ),
    GoRoute(
      path: '/docking-bay',
      builder: (context, state) => const DockingBay(),
    ),
    GoRoute(
      path: '/planet/:id',
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '');

        if (id == null ||
            id < 0 ||
            id >= PlanetCatalog.planets.length) {
          return const InvalidPlanet();
        }

        return PlanetDetail(
          planet: PlanetCatalog.planets[id],
        );
      },
    ),
  ],
);

class CosmicExplorerApp extends StatelessWidget {
  const CosmicExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: myRouter,
    );
  }
}

class MissionControl extends StatelessWidget {
  const MissionControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cosmic Explorer - Mission Control'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'IEA Command Systems',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Mission Control'),
              onTap: () {
                Navigator.pop(context);
                context.go('/');
              },
            ),
            ListTile(
              leading: const Icon(Icons.rocket_launch),
              title: const Text('Docking Bay'),
              onTap: () {
                Navigator.pop(context);
                context.go('/docking-bay');
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: PlanetCatalog.planets.length,
        itemBuilder: (context, index) {
          final planet = PlanetCatalog.planets[index];

          return ListTile(
            leading: const Icon(Icons.public),
            title: Text(planet.name),
            subtitle: Text(planet.type),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () async {
              final result = await context.push<String>(
                '/planet/$index',
              );

              if (!context.mounted) return;

              if (result != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result)),
                );
              }
            },
          );
        },
      ),
    );
  }
}

class DockingBay extends StatelessWidget {
  const DockingBay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Docking Bay Telemetry'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.go('/');
          },
          child: const Text('Return to Control'),
        ),
      ),
    );
  }
}

class PlanetDetail extends StatelessWidget {
  final Planet planet;

  const PlanetDetail({
    super.key,
    required this.planet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(planet.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Planet Type: ${planet.type}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              planet.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.pop('You visited ${planet.name}!');
              },
              child: const Text('Confirm Visit'),
            ),
          ],
        ),
      ),
    );
  }
}

class InvalidPlanet extends StatelessWidget {
  const InvalidPlanet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unknown Planet'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'The requested planet could not be found.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.go('/');
                },
                child: const Text('Return to Mission Control'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}