import 'package:flutter/material.dart';
import 'package:flutter_application_1/models.dart';
import 'package:flutter_application_1/services.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Added import

class PlaceDetailScreen extends StatefulWidget {
  final Place place;

  const PlaceDetailScreen({super.key, required this.place});

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.place.likedBy.contains(FirebaseAuth.instance.currentUser?.uid); // Updated initialization
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser; // Get current user
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.place.name),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : null,
            ),
            onPressed: () {
              if (user == null) {
                // Handle case where user is not logged in
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Debes iniciar sesión para marcar como favorito')),
                );
                return;
              }
              setState(() {
                _isFavorite = !_isFavorite;
              });
              _firestoreService.toggleLike(widget.place.id!, user.uid); // Changed to toggleLike
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.place.imageUrl),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.place.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8.0),
                  Text(widget.place.description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}