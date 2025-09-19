
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models.dart';
import 'package:flutter_application_1/services.dart';
import 'package:flutter_application_1/screens/place_detail_screen.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/screens/add_edit_place_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final FirestoreService firestoreService = FirestoreService();
    final l10n = AppLocalizations.of(context)!;

    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.myFavorites)),
        body: Center(child: Text(l10n.pleaseLogInToViewFavorites)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.myFavorites)),
      body: StreamBuilder<List<Place>>(
        stream: firestoreService.getPlaces(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('${l10n.errorColon}${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text(l10n.noPlacesToShow));
          }

          final favoritePlaces = snapshot.data!
              .where((place) => place.likedBy.contains(currentUser.uid))
              .toList();

          if (favoritePlaces.isEmpty) {
            return Center(child: Text(l10n.noFavoritePlacesYet));
          }

          return ListView.builder(
            itemCount: favoritePlaces.length,
            itemBuilder: (context, index) {
              final place = favoritePlaces[index];
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEditPlaceScreen(place: place),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          if (place.id != null) {
                            firestoreService.deletePlace(place.id!);
                          }
                        },
                      ),
                    ],
                  ),
                  onTap: () {
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
      ),
    );
  }
}
