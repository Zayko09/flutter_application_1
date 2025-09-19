import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models.dart';
import 'package:flutter_application_1/services.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

class PlaceDetailScreen extends StatefulWidget {
  final Place place;

  const PlaceDetailScreen({super.key, required this.place});

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final TextEditingController _commentController = TextEditingController();
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    if (currentUser != null) {
      isLiked = widget.place.likedBy.contains(currentUser!.uid);
    }
  }

  void _toggleLike() async {
    if (currentUser != null) {
      await _firestoreService.toggleLike(widget.place.id!, currentUser!.uid);
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  void _addComment() async {
    if (_commentController.text.isNotEmpty && currentUser != null) {
      final comment = Comment(
        text: _commentController.text,
        userId: currentUser!.uid,
        timestamp: Timestamp.now(),
      );
      await _firestoreService.addComment(widget.place.id!, comment);
      _commentController.clear();
    }
  }

  void _showEditCommentDialog(Comment comment) {
    if (!mounted) return;
    final l10n = AppLocalizations.of(context)!;
    final editController = TextEditingController(text: comment.text);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.editComment),
        content: TextField(
          controller: editController,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (mounted) {
                Navigator.pop(context);
              }
            },
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              await _firestoreService.updateComment(
                  widget.place.id!, comment.id!, editController.text);
              if (mounted) {
                Navigator.pop(context);
              }
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(widget.place.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.place.imageUrl, fit: BoxFit.cover, height: 250, width: double.infinity),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.place.name, style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 8),
                  Text(widget.place.description),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(widget.place.rating.toStringAsFixed(1), style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border,
                                color: isLiked ? Colors.red : null),
                            onPressed: _toggleLike,
                          ),
                          Text('${widget.place.likedBy.length} ${l10n.likes}'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 10),
                  Text(l10n.comments, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  _buildCommentSection(),
                  _buildCommentInputField(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentSection() {
    final l10n = AppLocalizations.of(context)!;
    return StreamBuilder<List<Comment>>(
      stream: _firestoreService.getComments(widget.place.id!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(child: Text(l10n.noCommentsYet)),
          );
        }

        final comments = snapshot.data!;
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: comments.length,
          itemBuilder: (context, index) {
            final comment = comments[index];
            final isAuthor = currentUser?.uid == comment.userId;
            return ListTile(
              title: Text(comment.text),
              subtitle: Text(l10n.commentBy(comment.userId)),
              trailing: isAuthor
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, size: 20),
                          onPressed: () => _showEditCommentDialog(comment),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, size: 20),
                          onPressed: () => _firestoreService.deleteComment(widget.place.id!, comment.id!),
                        ),
                      ],
                    )
                  : null,
            );
          },
        );
      },
    );
  }

  Widget _buildCommentInputField() {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: l10n.addAComment,
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _addComment,
          ),
        ],
      ),
    );
  }
}
