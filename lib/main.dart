// main.dart
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

void main() {
  runApp(const MonApplication());
}

/// ======================================================
/// 1) APPLICATION
/// ======================================================
class MonApplication extends StatelessWidget {
  const MonApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application d'émissions de streaming",
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.amber),
      home: const MapremierePage(),
    );
  }
}

/// ======================================================
/// 2) PAGE D’ACCUEIL
/// ======================================================
class MapremierePage extends StatefulWidget {
  const MapremierePage({super.key});

  @override
  State<MapremierePage> createState() => _MapremierePageState();
}

class _MapremierePageState extends State<MapremierePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Vos émissions en streaming"),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 10),
          Icon(Icons.list),
          SizedBox(width: 10),
        ],
      ),
      body: const Center(
        child: Padding(padding: EdgeInsets.all(12), child: PartieGrilleImage()),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Recherche"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}

/// ======================================================
/// 3) MODÈLE DE DONNÉES
/// ======================================================
class Emission {
  final String tagStream;
  final String imageStream;
  final String nomStream;
  final String chaineRadio;

  const Emission({
    required this.tagStream,
    required this.imageStream,
    required this.nomStream,
    required this.chaineRadio,
  });
}

/// ======================================================
/// 4) DONNÉES (IMAGES LOCALES)
// ======================================================
const List<Emission> emissions = [
  Emission(
    tagStream: "doc",
    imageStream: "assets/images/stream1.jpg",
    nomStream: "Documentaires",
    chaineRadio: "Radio 4",
  ),
  Emission(
    tagStream: "mode",
    imageStream: "assets/images/stream2.jpg",
    nomStream: "Tendances Mode",
    chaineRadio: "Radio 3",
  ),
  Emission(
    tagStream: "crime",
    imageStream: "assets/images/stream4.jpg",
    nomStream: "Enquêtes Criminelles",
    chaineRadio: "Radio 2",
  ),
  Emission(
    tagStream: "foot",
    imageStream: "assets/images/stream3.jpeg",
    nomStream: "Match de Foot",
    chaineRadio: "Radio 5",
  ),
  Emission(
    tagStream: "meteo",
    imageStream: "assets/images/stream5.jpeg",
    nomStream: "Streaming Météo",
    chaineRadio: "Radio 1",
  ),
  Emission(
    tagStream: "news",
    imageStream: "assets/images/stream6.jpeg",
    nomStream: "Que des news",
    chaineRadio: "Radio 4",
  ),
];

/// ======================================================
/// 5) GRILLE RESPONSIVE
/// ======================================================
class PartieGrilleImage extends StatelessWidget {
  const PartieGrilleImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridList(
      desiredItemWidth: 160,
      minSpacing: 12,
      children: emissions
          .map((e) => IdentificationStreaming(emission: e))
          .toList(),
    );
  }
}

/// ======================================================
/// 6) ITEM STREAMING
/// ======================================================
class IdentificationStreaming extends StatelessWidget {
  final Emission emission;

  const IdentificationStreaming({super.key, required this.emission});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AlbumStreaming(emission: emission)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
          boxShadow: const [BoxShadow(blurRadius: 6, color: Colors.black26)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: emission.tagStream,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(14),
                  ),
                  child: Image.asset(emission.imageStream, fit: BoxFit.cover),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    emission.nomStream,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    emission.chaineRadio,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ======================================================
/// 7) PAGE DÉTAIL (ALBUM STREAMING)
/// ======================================================
class AlbumStreaming extends StatelessWidget {
  final Emission emission;

  const AlbumStreaming({super.key, required this.emission});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(emission.nomStream),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          Hero(
            tag: emission.tagStream,
            child: Image.asset(
              emission.imageStream,
              height: 240,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.deepPurple,
            child: Text(
              emission.nomStream,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.volume_up),
                  title: Text("Diffusion ${index + 1}"),
                  trailing: Text("Date : 2023-0${index + 1}-2$index"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
