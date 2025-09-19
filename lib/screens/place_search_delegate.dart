import 'package:flutter/material.dart';
import 'package:flutter_application_1/models.dart';
import 'package:flutter_application_1/services.dart';
import 'package:flutter_application_1/screens/place_detail_screen.dart';

class PlaceSearchDelegate extends SearchDelegate<Place?> {
  final FirestoreService firestoreService;

  PlaceSearchDelegate(this.firestoreService);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<List<Place>>(
      stream: firestoreService.getPlaces(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay lugares para mostrar.'));
        }

        final results = snapshot.data!
            .where((place) =>
                place.name.toLowerCase().contains(query.toLowerCase()) ||
                place.description.toLowerCase().contains(query.toLowerCase()))
            .toList();

        if (results.isEmpty) {
          return const Center(child: Text('No se encontraron resultados.'));
        }

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final place = results[index];
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Image.network(
                  place.imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 60),
                ),
                title: Text(place.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(
                  place.description.length > 50
                      ? '${place.description.substring(0, 50)}...'
                      : place.description,
                ),
                onTap: () {
                  close(context, place);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaceDetailScreen(place: place),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<List<Place>>(
      stream: firestoreService.getPlaces(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay lugares para mostrar.'));
        }

        final suggestions = snapshot.data!
            .where((place) =>
                place.name.toLowerCase().contains(query.toLowerCase()) ||
                place.description.toLowerCase().contains(query.toLowerCase()))
            .toList();

        return ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final place = suggestions[index];
            return ListTile(
              leading: const Icon(Icons.location_on),
              title: Text(place.name),
              subtitle: Text(place.description),
              onTap: () {
                query = place.name;
                showResults(context);
              },
            );
          },
        );
      },
    );
  }
}