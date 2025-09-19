
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Collection references
  late final CollectionReference _placesRef;

  FirestoreService() {
    _placesRef = _db.collection('places').withConverter<Place>(
          fromFirestore: (snapshot, _) => Place.fromFirestore(snapshot),
          toFirestore: (place, _) => place.toMap(),
        );
  }

  // Seed the database with predefined places if it's empty
  Future<void> seedDatabase() async {
    final snapshot = await _placesRef.limit(1).get();
    if (snapshot.docs.isEmpty) {
      for (final place in predefinedPlaces) {
        await _placesRef.add(place);
      }
    }
  }

  // Get a stream of all places
  Stream<List<Place>> getPlaces() {
    return _placesRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data() as Place).toList();
    });
  }

  // Add a new place
  Future<void> addPlace(Place place) {
    return _placesRef.add(place);
  }

  // Update a place
  Future<void> updatePlace(Place place) {
    if (place.id == null) return Future.value();
    return _placesRef.doc(place.id).update(place.toMap());
  }

  // Delete a place
  Future<void> deletePlace(String id) {
    return _placesRef.doc(id).delete();
  }

  // Get a stream of comments for a specific place
  Stream<List<Comment>> getComments(String placeId) {
    return _placesRef
        .doc(placeId)
        .collection('comments')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Comment.fromFirestore(doc)).toList();
    });
  }

  // Add a new comment to a place
  Future<void> addComment(String placeId, Comment comment) {
    return _placesRef.doc(placeId).collection('comments').add(comment.toMap());
  }

  // Update a comment
  Future<void> updateComment(String placeId, String commentId, String newText) {
    return _placesRef
        .doc(placeId)
        .collection('comments')
        .doc(commentId)
        .update({'text': newText});
  }

  // Delete a comment
  Future<void> deleteComment(String placeId, String commentId) {
    return _placesRef.doc(placeId).collection('comments').doc(commentId).delete();
  }

  // Toggle a like on a place
  Future<void> toggleLike(String placeId, String userId) async {
    final docRef = _placesRef.doc(placeId);
    final snapshot = await docRef.get();
    if (snapshot.exists) {
      final place = snapshot.data() as Place;
      List<String> likedBy = List<String>.from(place.likedBy);
      if (likedBy.contains(userId)) {
        likedBy.remove(userId);
      } else {
        likedBy.add(userId);
      }
      return docRef.update({'likedBy': likedBy});
    }
  }
}
