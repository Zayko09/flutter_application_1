// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Rincones de Colombia';

  @override
  String get addPlace => 'Añadir Lugar';

  @override
  String get editPlace => 'Editar Lugar';

  @override
  String get placeName => 'Nombre del Lugar';

  @override
  String get pleaseEnterName => 'Por favor, introduce un nombre.';

  @override
  String get description => 'Descripción';

  @override
  String get pleaseEnterDescription => 'Por favor, introduce una descripción.';

  @override
  String get imageUrl => 'URL de la Imagen';

  @override
  String get pleaseEnterImageUrl => 'Por favor, introduce una URL de imagen.';

  @override
  String get cityCategory => 'Ciudad/Categoría';

  @override
  String get savePlace => 'Guardar Lugar';

  @override
  String get updatePlace => 'Actualizar Lugar';

  @override
  String get deletePlace => 'Eliminar Lugar';

  @override
  String get myFavorites => 'Mis Favoritos';

  @override
  String get pleaseLogInToViewFavorites =>
      'Por favor, inicia sesión para ver tus favoritos.';

  @override
  String get errorColon => 'Error: ';

  @override
  String get noPlacesToShow => 'No hay lugares para mostrar.';

  @override
  String get noFavoritePlacesYet => 'No tienes lugares favoritos aún.';

  @override
  String get menu => 'Menú';

  @override
  String get home => 'Inicio';

  @override
  String get profile => 'Perfil';

  @override
  String get logout => 'Cerrar Sesión';

  @override
  String get noPlacesFound => 'No se encontraron lugares.';

  @override
  String get loginToSavePlace => 'Inicia sesión para guardar el lugar';

  @override
  String get cannotDeletePlaceWithoutId =>
      'No se puede eliminar el lugar sin un ID';

  @override
  String get likes => 'Me gusta';

  @override
  String get comments => 'Comentarios';

  @override
  String get noCommentsYet => 'Aún no hay comentarios.';

  @override
  String get addAComment => 'Añade un comentario...';

  @override
  String get editComment => 'Editar Comentario';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String commentBy(Object userId) {
    return 'por $userId';
  }

  @override
  String get pleaseEnterAValidUrl => 'Por favor, introduce una URL válida.';

  @override
  String get selectImage => 'Seleccionar Imagen';

  @override
  String get errorUploadingImage => 'Error al subir la imagen: ';

  @override
  String get pleaseSelectAnImage => 'Por favor, selecciona una imagen.';
}
