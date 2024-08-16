import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

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

  /// No description provided for @bg_images.
  ///
  /// In en, this message translates to:
  /// **'Background images'**
  String get bg_images;

  /// No description provided for @image_source.
  ///
  /// In en, this message translates to:
  /// **'Image source'**
  String get image_source;

  /// No description provided for @local_image.
  ///
  /// In en, this message translates to:
  /// **'Local image'**
  String get local_image;

  /// No description provided for @folder.
  ///
  /// In en, this message translates to:
  /// **'Folder'**
  String get folder;

  /// No description provided for @path_already_exists.
  ///
  /// In en, this message translates to:
  /// **'Path already exists'**
  String get path_already_exists;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @theme_mode.
  ///
  /// In en, this message translates to:
  /// **'Theme mode'**
  String get theme_mode;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @follow_system.
  ///
  /// In en, this message translates to:
  /// **'Follow system'**
  String get follow_system;

  /// No description provided for @theme_color.
  ///
  /// In en, this message translates to:
  /// **'Theme color'**
  String get theme_color;

  /// No description provided for @custom_color.
  ///
  /// In en, this message translates to:
  /// **'Custom color'**
  String get custom_color;

  /// No description provided for @show_clock.
  ///
  /// In en, this message translates to:
  /// **'Show clock'**
  String get show_clock;

  /// No description provided for @shadow_color.
  ///
  /// In en, this message translates to:
  /// **'Shadow color'**
  String get shadow_color;

  /// No description provided for @date_text.
  ///
  /// In en, this message translates to:
  /// **'Date text'**
  String get date_text;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @verison.
  ///
  /// In en, this message translates to:
  /// **'Verison'**
  String get verison;

  /// No description provided for @confirm_del_file.
  ///
  /// In en, this message translates to:
  /// **'Confirm delete the file?'**
  String get confirm_del_file;

  /// No description provided for @confirm_del.
  ///
  /// In en, this message translates to:
  /// **'Confirm delete?'**
  String get confirm_del;

  /// No description provided for @confirm_close.
  ///
  /// In en, this message translates to:
  /// **'Confirm close?'**
  String get confirm_close;

  /// No description provided for @confirm_brfore_close.
  ///
  /// In en, this message translates to:
  /// **'Confirm before close'**
  String get confirm_brfore_close;

  /// No description provided for @show_sed.
  ///
  /// In en, this message translates to:
  /// **'Show seconds'**
  String get show_sed;

  /// No description provided for @clock_size.
  ///
  /// In en, this message translates to:
  /// **'Clock size'**
  String get clock_size;

  /// No description provided for @open_launcher.
  ///
  /// In en, this message translates to:
  /// **'Open launcher'**
  String get open_launcher;

  /// No description provided for @uninstall_game.
  ///
  /// In en, this message translates to:
  /// **'Uninstall'**
  String get uninstall_game;

  /// No description provided for @path_not_exists.
  ///
  /// In en, this message translates to:
  /// **'Path does not exist'**
  String get path_not_exists;

  /// No description provided for @start_with_full.
  ///
  /// In en, this message translates to:
  /// **'Start with full screen'**
  String get start_with_full;

  /// No description provided for @minimize_after_launch.
  ///
  /// In en, this message translates to:
  /// **'Minimize after launch'**
  String get minimize_after_launch;

  /// No description provided for @random_swich.
  ///
  /// In en, this message translates to:
  /// **'Random switch'**
  String get random_swich;

  /// No description provided for @swich_interval.
  ///
  /// In en, this message translates to:
  /// **'Switch interval'**
  String get swich_interval;

  /// No description provided for @animate_duration.
  ///
  /// In en, this message translates to:
  /// **'Animate duration'**
  String get animate_duration;

  /// No description provided for @net_image.
  ///
  /// In en, this message translates to:
  /// **'Network image'**
  String get net_image;
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
