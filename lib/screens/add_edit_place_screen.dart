import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models.dart';
import 'package:flutter_application_1/services.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

class AddEditPlaceScreen extends StatefulWidget {
  final Place? place;

  const AddEditPlaceScreen({super.key, this.place});

  @override
  State<AddEditPlaceScreen> createState() => _AddEditPlaceScreenState();
}

class _AddEditPlaceScreenState extends State<AddEditPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  String _selectedCategory = colombianMainCities.first;

  // State for both URL and File Upload
  Uint8List? _imageBytes;
  String _imageUrlForPreview = '';
  bool _isUploading = false;
  double _uploadProgress = 0;

  final FirestoreService _firestoreService = FirestoreService();
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    if (widget.place != null) {
      _nameController.text = widget.place!.name;
      _descriptionController.text = widget.place!.description;
      _selectedCategory = widget.place!.category;
      _imageUrlController.text = widget.place!.imageUrl;
      _imageUrlForPreview = widget.place!.imageUrl;
    }
    _imageUrlController.addListener(_updateImagePreviewFromUrl);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _updateImagePreviewFromUrl() {
    // If we are typing a URL, we are not using the file upload.
    if (_imageBytes != null) {
      setState(() {
        _imageBytes = null;
      });
    }
    setState(() {
      _imageUrlForPreview = _imageUrlController.text;
    });
  }

  Future<void> _pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true, // Ensure bytes are loaded
      );
      if (result != null && result.files.single.bytes != null) {
        setState(() {
          _imageBytes = result.files.single.bytes;
          // Clear the URL field because file upload takes precedence
          _imageUrlController.clear();
          _imageUrlForPreview = '';
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al seleccionar imagen: $e')),
        );
      }
    }
  }

  Future<String?> _uploadFile() async {
    if (_imageBytes == null) return null;
    final l10n = AppLocalizations.of(context)!;

    setState(() {
      _isUploading = true;
      _uploadProgress = 0;
    });

    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final reference = FirebaseStorage.instance.ref().child('places/$fileName');
      final uploadTask = reference.putData(_imageBytes!);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        setState(() {
          _uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
        });
      });

      final snapshot = await uploadTask.timeout(const Duration(seconds: 60));
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${l10n.errorUploadingImage}$e')),
        );
      }
      return null;
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  void _savePlace() async {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return;
    if (_formKey.currentState?.validate() != true) return;

    if (currentUser == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.loginToSavePlace)),
        );
      }
      return;
    }

    String? finalImageUrl;

    // Priority 1: Uploaded file
    if (_imageBytes != null) {
      finalImageUrl = await _uploadFile();
      if (finalImageUrl == null) {
        // Upload failed, error is shown in _uploadFile
        return;
      }
    } 
    // Priority 2: URL from text field
    else if (_imageUrlController.text.isNotEmpty) {
      finalImageUrl = _imageUrlController.text;
    }

    // If after all checks, we have no image, show error
    if (finalImageUrl == null || finalImageUrl.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, sube una imagen o introduce una URL.')),
        );
      }
      return;
    }

    final place = Place(
      id: widget.place?.id,
      name: _nameController.text,
      description: _descriptionController.text,
      category: _selectedCategory,
      imageUrl: finalImageUrl,
      userId: currentUser!.uid,
      rating: widget.place?.rating ?? 0.0,
      likedBy: widget.place?.likedBy ?? [],
    );

    try {
      if (widget.place == null) {
        await _firestoreService.addPlace(place);
      } else {
        await _firestoreService.updatePlace(place);
      }
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar el lugar: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) {
      return const Scaffold(
        body: Center(
          child: Text('Error: AppLocalizations not found.'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(widget.place == null ? l10n.addPlace : l10n.editPlace)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // --- Image Section ---
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _imageBytes != null
                    ? Image.memory(_imageBytes!, fit: BoxFit.cover)
                    : (_imageUrlForPreview.isNotEmpty
                        ? Image.network(
                            _imageUrlForPreview,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Center(child: Text('No se pudo cargar la imagen.')),
                          )
                        : const Center(child: Icon(Icons.image, size: 50, color: Colors.grey))),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'Pegar URL de la Imagen'),
                validator: (value) {
                  if (_imageBytes == null && (value == null || value.isEmpty)) {
                    return 'Introduce una URL o selecciona un archivo.';
                  }
                  if (value != null && value.isNotEmpty && !(Uri.tryParse(value)?.isAbsolute ?? false)) {
                    return 'Introduce una URL válida.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'o',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.upload_file),
                label: const Text('Seleccionar Archivo de Imagen'),
              ),
              if (_isUploading)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: LinearProgressIndicator(value: _uploadProgress),
                ),
              const SizedBox(height: 24),
              // --- Details Section ---
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: l10n.placeName),
                validator: (value) => (value == null || value.isEmpty) ? l10n.pleaseEnterName : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: l10n.description),
                maxLines: 4,
                validator: (value) => (value == null || value.isEmpty) ? l10n.pleaseEnterDescription : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: InputDecoration(labelText: l10n.cityCategory),
                items: colombianMainCities.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue ?? colombianMainCities.first;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isUploading ? null : _savePlace,
                child: _isUploading
                    ? const CircularProgressIndicator()
                    : Text(widget.place == null ? l10n.savePlace : l10n.updatePlace),
              ),
            ],
          ),
        ),
      ),
    );
  }
}