import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('es')];

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'Rincones de Colombia'**
  String get appTitle;

  /// No description provided for @addPlace.
  ///
  /// In es, this message translates to:
  /// **'Añadir Lugar'**
  String get addPlace;

  /// No description provided for @editPlace.
  ///
  /// In es, this message translates to:
  /// **'Editar Lugar'**
  String get editPlace;

  /// No description provided for @placeName.
  ///
  /// In es, this message translates to:
  /// **'Nombre del Lugar'**
  String get placeName;

  /// No description provided for @pleaseEnterName.
  ///
  /// In es, this message translates to:
  /// **'Por favor, introduce un nombre.'**
  String get pleaseEnterName;

  /// No description provided for @description.
  ///
  /// In es, this message translates to:
  /// **'Descripción'**
  String get description;

  /// No description provided for @pleaseEnterDescription.
  ///
  /// In es, this message translates to:
  /// **'Por favor, introduce una descripción.'**
  String get pleaseEnterDescription;

  /// No description provided for @imageUrl.
  ///
  /// In es, this message translates to:
  /// **'URL de la Imagen'**
  String get imageUrl;

  /// No description provided for @pleaseEnterImageUrl.
  ///
  /// In es, this message translates to:
  /// **'Por favor, introduce una URL de imagen.'**
  String get pleaseEnterImageUrl;

  /// No description provided for @cityCategory.
  ///
  /// In es, this message translates to:
  /// **'Ciudad/Categoría'**
  String get cityCategory;

  /// No description provided for @savePlace.
  ///
  /// In es, this message translates to:
  /// **'Guardar Lugar'**
  String get savePlace;

  /// No description provided for @updatePlace.
  ///
  /// In es, this message translates to:
  /// **'Actualizar Lugar'**
  String get updatePlace;

  /// No description provided for @deletePlace.
  ///
  /// In es, this message translates to:
  /// **'Eliminar Lugar'**
  String get deletePlace;

  /// No description provided for @myFavorites.
  ///
  /// In es, this message translates to:
  /// **'Mis Favoritos'**
  String get myFavorites;

  /// No description provided for @pleaseLogInToViewFavorites.
  ///
  /// In es, this message translates to:
  /// **'Por favor, inicia sesión para ver tus favoritos.'**
  String get pleaseLogInToViewFavorites;

  /// No description provided for @errorColon.
  ///
  /// In es, this message translates to:
  /// **'Error: '**
  String get errorColon;

  /// No description provided for @noPlacesToShow.
  ///
  /// In es, this message translates to:
  /// **'No hay lugares para mostrar.'**
  String get noPlacesToShow;

  /// No description provided for @noFavoritePlacesYet.
  ///
  /// In es, this message translates to:
  /// **'No tienes lugares favoritos aún.'**
  String get noFavoritePlacesYet;

  /// No description provided for @menu.
  ///
  /// In es, this message translates to:
  /// **'Menú'**
  String get menu;

  /// No description provided for @home.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get home;

  /// No description provided for @profile.
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get profile;

  /// No description provided for @logout.
  ///
  /// In es, this message translates to:
  /// **'Cerrar Sesión'**
  String get logout;

  /// No description provided for @noPlacesFound.
  ///
  /// In es, this message translates to:
  /// **'No se encontraron lugares.'**
  String get noPlacesFound;

  /// No description provided for @loginToSavePlace.
  ///
  /// In es, this message translates to:
  /// **'Inicia sesión para guardar el lugar'**
  String get loginToSavePlace;

  /// No description provided for @cannotDeletePlaceWithoutId.
  ///
  /// In es, this message translates to:
  /// **'No se puede eliminar el lugar sin un ID'**
  String get cannotDeletePlaceWithoutId;

  /// No description provided for @likes.
  ///
  /// In es, this message translates to:
  /// **'Me gusta'**
  String get likes;

  /// No description provided for @comments.
  ///
  /// In es, this message translates to:
  /// **'Comentarios'**
  String get comments;

  /// No description provided for @noCommentsYet.
  ///
  /// In es, this message translates to:
  /// **'Aún no hay comentarios.'**
  String get noCommentsYet;

  /// No description provided for @addAComment.
  ///
  /// In es, this message translates to:
  /// **'Añade un comentario...'**
  String get addAComment;

  /// No description provided for @editComment.
  ///
  /// In es, this message translates to:
  /// **'Editar Comentario'**
  String get editComment;

  /// No description provided for @cancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get save;

  /// No description provided for @commentBy.
  ///
  /// In es, this message translates to:
  /// **'por {userId}'**
  String commentBy(Object userId);

  /// No description provided for @pleaseEnterAValidUrl.
  ///
  /// In es, this message translates to:
  /// **'Por favor, introduce una URL válida.'**
  String get pleaseEnterAValidUrl;

  /// No description provided for @selectImage.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar Imagen'**
  String get selectImage;

  /// No description provided for @errorUploadingImage.
  ///
  /// In es, this message translates to:
  /// **'Error al subir la imagen: '**
  String get errorUploadingImage;

  /// No description provided for @pleaseSelectAnImage.
  ///
  /// In es, this message translates to:
  /// **'Por favor, selecciona una imagen.'**
  String get pleaseSelectAnImage;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
