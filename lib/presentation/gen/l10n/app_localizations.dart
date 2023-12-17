import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh')
  ];

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'Hoyo Launcher'**
  String get app_name;

  /// No description provided for @launcher.
  ///
  /// In en, this message translates to:
  /// **'Launcher'**
  String get launcher;

  /// No description provided for @create_info.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create_info;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @icon.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get icon;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get info;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @launch_path.
  ///
  /// In en, this message translates to:
  /// **'Launch path'**
  String get launch_path;

  /// No description provided for @execution_path.
  ///
  /// In en, this message translates to:
  /// **'Execution path'**
  String get execution_path;

  /// No description provided for @game_name.
  ///
  /// In en, this message translates to:
  /// **'Game name'**
  String get game_name;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @start_game.
  ///
  /// In en, this message translates to:
  /// **'Start game'**
  String get start_game;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @confirm_delete.
  ///
  /// In en, this message translates to:
  /// **'Confirm delete?'**
  String get confirm_delete;

  /// No description provided for @more_actions.
  ///
  /// In en, this message translates to:
  /// **'More actions'**
  String get more_actions;

  /// No description provided for @add_action.
  ///
  /// In en, this message translates to:
  /// **'Add a action'**
  String get add_action;

  /// No description provided for @action_name.
  ///
  /// In en, this message translates to:
  /// **'Action name'**
  String get action_name;

  /// No description provided for @plz_fill_game_name.
  ///
  /// In en, this message translates to:
  /// **'Please fill in the game name'**
  String get plz_fill_game_name;

  /// No description provided for @plz_select_game_path.
  ///
  /// In en, this message translates to:
  /// **'Please select the game path'**
  String get plz_select_game_path;

  /// No description provided for @plz_fill_execution_path.
  ///
  /// In en, this message translates to:
  /// **'Please fill in the execution path'**
  String get plz_fill_execution_path;

  /// No description provided for @plz_fill_name.
  ///
  /// In en, this message translates to:
  /// **'Please fill in the name'**
  String get plz_fill_name;

  /// No description provided for @plz_complete_info.
  ///
  /// In en, this message translates to:
  /// **'Please complete the information'**
  String get plz_complete_info;

  /// No description provided for @plz_select_game_icon.
  ///
  /// In en, this message translates to:
  /// **'Please select a game icon'**
  String get plz_select_game_icon;

  /// No description provided for @bg_type.
  ///
  /// In en, this message translates to:
  /// **'Background type'**
  String get bg_type;

  /// No description provided for @one_image_per_line.
  ///
  /// In en, this message translates to:
  /// **'One picture per line'**
  String get one_image_per_line;

  /// No description provided for @single_image.
  ///
  /// In en, this message translates to:
  /// **'Single image'**
  String get single_image;

  /// No description provided for @folder_loop.
  ///
  /// In en, this message translates to:
  /// **'Folder loop'**
  String get folder_loop;

  /// No description provided for @list_loop.
  ///
  /// In en, this message translates to:
  /// **'List loop'**
  String get list_loop;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
