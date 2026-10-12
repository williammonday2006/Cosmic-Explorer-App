import 'package:flutter/material.dart';

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

class CosmicExplorerApp extends StatelessWidget {
  const CosmicExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MissionControl(),
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
      body: ListView.builder(
        itemCount: PlanetCatalog.planets.length,
        itemBuilder: (context, index) {
          final planet = PlanetCatalog.planets[index];

          return ListTile(
            leading: const Icon(Icons.public),
            title: Text(planet.name),
            subtitle: Text(planet.type),
            onTap: () async {
              final result = await Navigator.push<String>(
                context,
                MaterialPageRoute(
                  builder: (context) => PlanetDetail(planet: planet),
                ),
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

class PlanetDetail extends StatelessWidget {
  final Planet planet;

  const PlanetDetail({
    super.key,
    required this.planet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(planet.name)),
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
                Navigator.pop(
                  context,
                  'You visited ${planet.name}!',
                );
              },
              child: const Text('Confirm Visit'),
            ),
          ],
        ),
      ),
    );
  }
}