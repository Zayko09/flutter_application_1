// lib/models.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Place {
  final String? id;
  final String name;
  final String description;
  final String category;
  final String imageUrl;
  final String userId;
  final double rating;
  final List<String> likedBy;

  Place({
    this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.userId,
    this.rating = 0.0,
    this.likedBy = const [],
  });

  factory Place.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    return Place(
      id: doc.id,
      name: data?['name'] ?? '',
      description: data?['description'] ?? '',
      category: data?['category'] ?? '',
      imageUrl: data?['imageUrl'] ?? '',
      userId: data?['userId'] ?? '',
      rating: data?['rating'] is int ? (data?['rating'] as int).toDouble() : data?['rating'] ?? 0.0,
      likedBy: List<String>.from(data?['likedBy'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'category': category,
      'imageUrl': imageUrl,
      'userId': userId,
      'rating': rating,
      'likedBy': likedBy,
    };
  }
}

class Comment {
  final String? id;
  final String text;
  final String userId;
  final Timestamp timestamp;

  Comment({
    this.id,
    required this.text,
    required this.userId,
    required this.timestamp,
  });

  factory Comment.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    return Comment(
      id: doc.id,
      text: data?['text'] ?? '',
      userId: data?['userId'] ?? '',
      timestamp: data?['timestamp'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'userId': userId,
      'timestamp': timestamp,
    };
  }
}


// Lista de lugares predefinidos con imágenes de dominio público
final List<Place> predefinedPlaces = [
 Place(
    id: null,
    name: 'Puente de Boyacá',
    description: 'Lugar histórico donde se libró la batalla que selló la independencia de Colombia.',
    category: 'Historia',
    imageUrl: 'https://images.unsplash.com/photo-1628104860164-16a7f5b35c6f?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    userId: 'admin_test',
  ),
  Place(
    id: null,
    name: 'Caño Cristales',
    description: 'Conocido como el "río de los cinco colores", un espectáculo natural único en el mundo.',
    category: 'Naturaleza',
    imageUrl: 'https://images.unsplash.com/photo-1549419163-9524a8661642?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    userId: 'admin_test',
  ),
  Place(
    id: null,
    name: 'Desierto de la Tatacoa',
    description: 'Un impresionante desierto de tonos ocres y rojizos, ideal para la observación de estrellas.',
    category: 'Aventura',
    imageUrl: 'https://images.unsplash.com/photo-1596707436214-41d1d84b655f?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    userId: 'admin_test',
  ),
  Place(
    id: null,
    name: 'San Andrés',
    description: 'Una isla paradisíaca con el "mar de los siete colores" y playas de arena blanca.',
    category: 'Playa',
    imageUrl: 'https://images.unsplash.com/photo-1573800383176-30843823c3a7?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    userId: 'admin_test',
  ),
    Place(
    id: null,
    name: 'Parque Nacional Natural Tayrona',
    description: 'Un parque con una biodiversidad increíble, playas de arena blanca y ruinas arqueológicas.',
    category: 'Naturaleza',
    imageUrl: 'https://images.unsplash.com/photo-1587922432135-278ab07455d3?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    userId: 'admin_test',
  ),
  Place(
    id: null,
    name: 'Cartagena de Indias',
    description: 'Ciudad amurallada con encanto colonial, calles coloridas y una rica historia caribeña.',
    category: 'Historia',
    imageUrl: 'https://images.unsplash.com/photo-1592529689129-a19b2086b28e?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    userId: 'admin_test',
  ),
  Place(
    id: null,
    name: 'Medellín (Plaza Botero)',
    description: 'La ciudad de la eterna primavera, famosa por sus esculturas de Fernando Botero y su vibrante vida cultural.',
    category: 'Cultura',
    imageUrl: 'https://images.unsplash.com/photo-1602216056096-3b40cb5547ea?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    userId: 'admin_test',
  ),
  Place(
    id: null,
    name: 'Eje Cafetero (Valle del Cocora)',
    description: 'Paisajes impresionantes con palmas de cera gigantes, hogar de la cultura cafetera colombiana.',
    category: 'Naturaleza',
    imageUrl: 'https://images.unsplash.com/photo-1587502537000-9b9b9b9b9b9b?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    userId: 'admin_test',
  ),
  Place(
    id: null,
    name: 'Villa de Leyva',
    description: 'Un hermoso pueblo colonial con la plaza más grande de Colombia, arquitectura bien conservada y fósiles.',
    category: 'Historia',
    imageUrl: 'https://images.unsplash.com/photo-1613909208088-f5b5b5b5b5b5?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    userId: 'admin_test',
  ),
  Place(
    id: null,
    name: 'Bogotá (Monserrate)',
    description: 'El cerro tutelar de Bogotá, ofrece vistas panorámicas de la ciudad y un santuario religioso.',
    category: 'Cultura',
    imageUrl: 'https://images.unsplash.com/photo-1592529689129-a19b2086b28e?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    userId: 'admin_test',
  ),
];

const List<String> colombianMainCities = [
  'Bogotá', 'Medellín', 'Cali', 'Barranquilla', 'Cartagena', 'Santa Marta', 'Bucaramanga', 'Pasto',
];