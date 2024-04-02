import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get user_email => 'البريد الإلكتروني للمستخدم';

  @override
  String get password => 'كلمة المرور';

  @override
  String get enter_your_email => 'أدخل بريدك الإلكتروني';

  @override
  String get enter_your_password => 'أدخل كلمة المرور الخاصة بك';
}
