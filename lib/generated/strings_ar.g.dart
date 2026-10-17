///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsAr with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsAr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ar,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ar>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key);

	late final TranslationsAr _root = this; // ignore: unused_field

	@override 
	TranslationsAr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsAr(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$googleAuthErrors$ar googleAuthErrors = _Translations$googleAuthErrors$ar._(_root);
	@override late final _Translations$privacyPolicy$ar privacyPolicy = _Translations$privacyPolicy$ar._(_root);
	@override String get menu => 'القائمة';
	@override String get closeMenu => 'إغلاق القائمة';
	@override String get myAppointments => 'مواعيدي';
	@override String get appName => 'Doctor Hunt';
	@override String get onboardingTitleOne => 'ابحث عن أطباء موثوقين';
	@override String get onboardingDescriptionOne => 'على عكس الاعتقاد السائد، فإن لوريم إيبسوم ليس مجرد نص عشوائي، بل يعود جذوره إلى الأدب اللاتيني الكلاسيكي.';
	@override String get onboardingTitleTwo => 'اختر أفضل الأطباء';
	@override String get onboardingDescriptionTwo => 'على عكس الاعتقاد السائد، فإن لوريم إيبسوم ليس مجرد نص عشوائي، بل يعود جذوره إلى الأدب اللاتيني الكلاسيكي.';
	@override String get onboardingTitleThree => 'مواعيد سهلة وميسرة';
	@override String get onboardingDescriptionThree => 'على عكس الاعتقاد السائد، فإن لوريم إيبسوم ليس مجرد نص عشوائي، بل يعود جذوره إلى الأدب اللاتيني الكلاسيكي.';
	@override String get next => 'التالي';
	@override String get skip => 'تخطي';
	@override String get getStarted => 'ابدأ الآن';
	@override String get chooseRoleTitle => 'اختر دورك';
	@override String get chooseRoleDescription => 'حدد كيف تريد الاستمرار في التطبيق';
	@override String get patient => 'مريض';
	@override String get patientDescription => 'ابحث عن الأطباء واحجز المواعيد بسهولة';
	@override String get admin => 'مسؤول';
	@override String get adminDescription => 'متابعة كمسؤول النظام';
	@override String get continueText => 'متابعة';
	@override String homeGreeting({required Object name}) => 'مرحباً ${name}!';
	@override String get findYourDoctor => 'ابحث عن طبيبك';
	@override String get searchDoctor => 'بحث...';
	@override String get liveDoctors => 'أطباء متصلون الان';
	@override String get seeAll => 'عرض الكل';
	@override String get popularDoctors => 'الأطباء الأكثر شعبية';
	@override String get categories => 'الأقسام';
	@override String get featureDoctors => 'أطباء مميزون';
	@override String get findDoctors => 'البحث عن أطباء';
	@override String get doctorDetails => 'تفاصيل الطبيب';
	@override String get dentistSearch => 'طبيب أسنان';
	@override String get nextAvailable => 'الموعد المتاح التالي';
	@override String get bookNow => 'احجز الآن';
	@override String get perHour => '/ساعة';
	@override String get noDoctorsFound => 'لم يتم العثور على أطباء';
	@override String get running => 'جاري';
	@override String get ongoing => 'مستمر';
	@override String get patients => 'المرضى';
	@override String get services => 'الخدمات';
	@override String get serviceOne => 'رعاية المريض هي أولويتنا القصوى دائماً.';
	@override String get serviceTwo => 'نستمع إليك بصلابة ونشرح كل خطوة علاجية بوضوح.';
	@override String get serviceThree => 'رعاية حديثة يدعمها طاقم طبي ذو خبرة عالية.';
	@override String get location => 'الموقع';
	@override String get dental => 'أسنان';
	@override String get cardiology => 'أمراض القلب';
	@override String get ophthalmology => 'العيون';
	@override String get generalMedicine => 'طب عام';
	@override String get home => 'الرئيسية';
	@override String get favorites => 'المفضلة';
	@override String get messages => 'الرسائل';
	@override String get profile => 'الملف الشخصي';
	@override String get selecttime => 'اختر الوقت';
	@override String get today => 'اليوم';
	@override String get noSlotsAvailable => 'لا توجد أوقات متاحة';
	@override String get afternoon => 'بعد الظهر';
	@override String get evening => 'المساء';
	@override String get slots => 'أوقات';
	@override String get tomorrow => 'غداً';
	@override String get slotsAvailable => 'أوقات متاحة';
	@override String get nextAvailabilityOn => 'الموعد المتاح التالي في';
	@override String get orText => 'أو';
	@override String get contactClinic => 'التواصل مع العيادة';
	@override String get bookAppointment => 'تأكيد';
	@override String get thankYou => 'شكراً لك!';
	@override String get appointmentSuccessful => 'تم حجز موعدك بنجاح';
	@override String get done => 'تم';
	@override String get editAppointment => 'تعديل الموعد';
	@override String appointmentConfirmation({required Object doctorName, required Object date, required Object time}) => 'لقد قمت بحجز موعد مع ${doctorName} بتاريخ ${date} الساعة ${time}';
	@override String get noFavoriteDoctors => 'لا يوجد أطباء مفضلون';
	@override String get email => 'البريد الإلكتروني';
	@override String get enterEmail => 'أدخل بريدك الإلكتروني';
	@override String get password => 'كلمة المرور';
	@override String get enterPassword => 'أدخل كلمة المرور';
	@override String get welcome => 'مرحباً بعودتك';
	@override String get loginAdmin => 'تسجيل الدخول لحساب المسؤول';
	@override String get botnlogin => 'تسجيل الدخول';
	@override String get loginTitle => 'تسجيل الدخول إلى حسابك';
	@override String get adminLoginTitle => 'تسجيل دخول المسؤول';
	@override String get forgotPassword => 'هل نسيت كلمة المرور؟';
	@override String get orDivider => 'أو';
	@override String get signInWithGoogle => 'تسجيل الدخول بواسطة Google';
	@override String get doctor => 'الأطباء';
	@override String get searchDoctors => 'البحث عن الأطباء';
	@override String get totalDoctors => 'إجمالي الأطباء';
	@override String get activeDoctors => 'الأطباء النشطون';
	@override String get active => 'نشط';
	@override String get inactive => 'غير نشط';
	@override String get addDoctor => 'إضافة طبيب';
	@override String get createDoctor => 'إنشاء طبيب';
	@override String get doctorName => 'اسم الطبيب';
	@override String get enterDoctorName => 'أدخل اسم الطبيب';
	@override String get doctorImage => 'صورة الطبيب';
	@override String get uploadDoctorImage => 'رفع صورة الطبيب';
	@override String get supportedImageFormats => 'صيغ PNG أو JPG بحجم حتى 5 ميجابايت';
	@override String get editDoctor => 'تعديل بيانات الطبيب';
	@override String get deleteDoctor => 'حذف الطبيب';
	@override String get cancel => 'إلغاء';
	@override String get save => 'حفظ';
	@override String get doctorCreatedSuccessfully => 'تم إنشاء حساب الطبيب بنجاح';
	@override String get doctorUpdatedSuccessfully => 'تم تحديث بيانات الطبيب بنجاح';
	@override String get doctorDeletedSuccessfully => 'تم حذف الطبيب بنجاح';
	@override String get failedToCreateDoctor => 'فشل إنشاء حساب الطبيب';
	@override String get noDoctorsAvailable => 'لا يوجد أطباء متاحون حالياً';
	@override String get specialization => 'التخصص';
	@override String get selectSpecialization => 'اختر التخصص';
	@override String get doctorNameRequired => 'اسم الطبيب مطلوب';
	@override String get specializationRequired => 'التخصص مطلوب';
	@override String get failedToLoadDoctors => 'فشل تحميل قائمة الأطباء';
	@override late final _Translations$auth$ar auth = _Translations$auth$ar._(_root);
	@override late final _Translations$roles$ar roles = _Translations$roles$ar._(_root);
	@override late final _Translations$common$ar common = _Translations$common$ar._(_root);
	@override late final _Translations$doctors$ar doctors = _Translations$doctors$ar._(_root);
	@override String get dontHaveAccount => 'ليس لديك حساب؟';
	@override String get signUp => 'إنشاء حساب';
	@override String get signUpTitle => 'حساب جديد';
	@override String get fullName => 'الاسم الكامل';
	@override String get enterFullName => 'أدخل اسمك الكامل';
	@override String get alreadyHaveAccount => 'لديك حساب بالفعل؟';
	@override late final _Translations$errors$ar errors = _Translations$errors$ar._(_root);
	@override String get resetPasswordTitle => 'إعادة تعيين كلمة المرور';
	@override String get resetPasswordDescription => 'أدخلي بريدك الإلكتروني لاستلام رابط إعادة تعيين كلمة المرور.';
	@override String get sendResetLink => 'إرسال رابط إعادة التعيين';
	@override String get resetEmailSent => 'إذا كان هناك حساب مرتبط بهذا البريد، فسيصلك رابط إعادة تعيين كلمة المرور.';
	@override String get resetPasswordFailed => 'تعذّر إرسال رابط إعادة تعيين كلمة المرور. حاولي مرة أخرى.';
	@override String get requiredField => 'هذا الحقل مطلوب.';
	@override String get invalidEmail => 'أدخلي بريدًا إلكترونيًا صحيحًا.';
	@override String get tooManyRequests => 'عدد المحاولات كبير جدًا. حاولي مرة أخرى لاحقًا.';
	@override String get networkError => 'حدث خطأ في الشبكة. تحققي من الاتصال وحاولي مرة أخرى.';
	@override String get nouser => 'لم يُرجع نظام المصادقة أي مستخدم.';
	@override String get noAuthenticatedUser => 'لا يوجد مستخدم مسجل الدخول.';
	@override String get noEmailAddress => 'الحساب الحالي لا يحتوي على عنوان بريد إلكتروني.';
	@override String get newPasswordMustBeDifferent => 'يجب أن تختلف كلمة المرور الجديدة عن الحالية.';
	@override String get passwordTooShort => 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل.';
	@override String get passwordsDoNotMatch => 'كلمتا المرور غير متطابقتين.';
	@override String get changePasswordDescription => 'أدخل كلمة المرور الحالية واختاري كلمة مرور جديدة.';
	@override late final _Translations$profileForm$ar profileForm = _Translations$profileForm$ar._(_root);
	@override late final _Translations$preferences$ar preferences = _Translations$preferences$ar._(_root);
	@override late final _Translations$doctorReviews$ar doctorReviews = _Translations$doctorReviews$ar._(_root);
	@override String get changePasswordTitle => 'تغيير كلمة المرور';
	@override String get currentPassword => 'كلمة المرور الحالية';
	@override String get newPassword => 'كلمة المرور الجديدة';
	@override String get confirmNewPassword => 'تأكيد كلمة المرور الجديدة';
	@override String get passwordChanged => 'تم تغيير كلمة المرور';
	@override String get changePasswordFailed => 'تعذر تغيير كلمة المرور. حاول مجددًا.';
	@override String get retry => 'حاول مجددًا';
	@override String get wrongCurrentPassword => 'كلمة المرور الحالية غير صحيحة';
	@override String get requiresRecentLogin => 'سجل الدخول مجددًا قبل تغيير كلمة المرور';
	@override late final _Translations$mvp$ar mvp = _Translations$mvp$ar._(_root);
	@override late final _Translations$commonUi$ar commonUi = _Translations$commonUi$ar._(_root);
}

// Path: googleAuthErrors
class _Translations$googleAuthErrors$ar implements Translations$googleAuthErrors$en {
	_Translations$googleAuthErrors$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get providerUnavailable => 'خدمات تسجيل الدخول عبر Google غير متاحة على هذا الجهاز. تحقّق من تحديث خدمات Google Play، وأعد تشغيل الجهاز ثم حاول مجددًا.';
	@override String get configuration => 'إعداد تسجيل الدخول عبر Google غير صحيح. يرجى التواصل مع الدعم.';
	@override String get cancelled => 'أُلغي تسجيل الدخول عبر Google. إذا لم تلغِ العملية، حاول مجددًا أو تواصل مع الدعم.';
	@override String get interrupted => 'انقطع تسجيل الدخول عبر Google. حاول مجددًا.';
	@override String get unavailable => 'تعذر فتح تسجيل الدخول عبر Google حاليًا. حاول مجددًا.';
	@override String get failed => 'تعذر تسجيل الدخول عبر Google. حاول مجددًا.';
	@override String get providerDisabled => 'طريقة تسجيل الدخول هذه غير مفعّلة. يرجى التواصل مع الدعم.';
	@override String get existingAccount => 'يوجد حساب بهذا البريد يستخدم طريقة دخول أخرى. سجّل الدخول بالطريقة الأصلية أولًا.';
	@override String get popupBlocked => 'اسمح لنافذة تسجيل الدخول المنبثقة في المتصفح ثم حاول مجددًا.';
	@override String get unsupportedPlatform => 'تسجيل الدخول عبر Google متاح حاليًا على Android وiOS وmacOS والويب، وغير مدعوم على هذه المنصة.';
}

// Path: privacyPolicy
class _Translations$privacyPolicy$ar implements Translations$privacyPolicy$en {
	_Translations$privacyPolicy$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'سياسة الخصوصية';
	@override String get heading => 'سياسة خصوصية تطبيق Doctor Hunt';
	@override String get draftNotice => 'نص تجريبي مُقدّم لتصميم الشاشة، وليس سياسة خصوصية نهائية.';
	@override String get introduction => 'توجد نسخ عديدة من مقاطع لوريم إيبسوم، لكن أغلبها خضع لتعديلات بإضافة عبارات فكاهية أو كلمات عشوائية. من المعروف أن المحتوى المقروء للصفحة قد يشتت القارئ عند النظر إلى تخطيطها. الغرض من استخدام لوريم إيبسوم هو توفير نص تجريبي. من المعروف أن المحتوى المقروء للصفحة قد يشتت القارئ عند النظر إلى تخطيطها. الغرض من استخدام لوريم إيبسوم هو توفير نص تجريبي.';
	@override String get bulletOne => 'يُعرض أدناه المقطع القياسي من لوريم إيبسوم المستخدم منذ القرن السادس عشر لمن يرغب في الاطلاع عليه.';
	@override String get bulletTwo => 'القسمان 1.10.32 و1.10.33 من كتاب «في غايات الخير والشر». الغرض من استخدام النص.';
	@override String get bulletThree => 'لوريم إيبسوم نص تجريبي. من المعروف أن القارئ قد يتشتت.';
	@override String get bulletFour => 'الغرض من استخدام لوريم إيبسوم هو توفير نص تجريبي. من المعروف أن القارئ قد يتشتت.';
	@override String get conclusion => 'من المعروف أن المحتوى المقروء للصفحة قد يشتت القارئ عند النظر إلى تخطيطها. الغرض من استخدام لوريم إيبسوم هو توفير نص تجريبي.';
}

// Path: auth
class _Translations$auth$ar implements Translations$auth$en {
	_Translations$auth$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get login => 'تسجيل الدخول';
	@override String get email => 'عنوان البريد الإلكتروني';
	@override String get password => 'كلمة المرور';
	@override String get loginSuccess => 'تم تسجيل الدخول بنجاح';
	@override String get loginError => 'حدث خطأ أثناء تسجيل الدخول';
}

// Path: roles
class _Translations$roles$ar implements Translations$roles$en {
	_Translations$roles$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get chooseRole => 'اختر دورك';
	@override String get patient => 'مريض';
	@override String get admin => 'مسؤول';
}

// Path: common
class _Translations$common$ar implements Translations$common$en {
	_Translations$common$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'إلغاء';
	@override String get confirm => 'تأكيد';
}

// Path: doctors
class _Translations$doctors$ar implements Translations$doctors$en {
	_Translations$doctors$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get notFound => 'لم يتم العثور على الطبيب';
}

// Path: errors
class _Translations$errors$ar implements Translations$errors$en {
	_Translations$errors$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get noPatientRole => 'هذا الحساب لا يملك صلاحية مريض.';
	@override String get noAdminRole => 'هذا الحساب لا يملك صلاحية مسؤول.';
	@override String get loginFailed => 'فشل تسجيل الدخول.';
}

// Path: profileForm
class _Translations$profileForm$ar implements Translations$profileForm$en {
	_Translations$profileForm$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get edit => 'تعديل الملف الشخصي';
	@override String get name => 'الاسم الكامل';
	@override String get email => 'البريد الإلكتروني';
	@override String get phone => 'رقم التواصل';
	@override String get birthDate => 'تاريخ الميلاد';
	@override String get gender => 'الجنس';
	@override String get male => 'ذكر';
	@override String get female => 'أنثى';
	@override String get other => 'آخر';
	@override String get save => 'حفظ التغييرات';
	@override String get saved => 'تم تحديث الملف الشخصي';
	@override String get photo => 'اضغط لتغيير الصورة';
	@override String get personalInfo => 'المعلومات الشخصية';
}

// Path: preferences
class _Translations$preferences$ar implements Translations$preferences$en {
	_Translations$preferences$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get buildVersion => 'إصدار التطبيق';
	@override String get versionUnavailable => 'غير متاح';
	@override String get title => 'الإعدادات';
	@override String get notifications => 'الإشعارات';
	@override String get language => 'اللغة';
	@override String get logout => 'تسجيل الخروج';
	@override String get logoutQuestion => 'هل تريد تسجيل الخروج؟';
	@override String get cancel => 'إلغاء';
	@override String get security => 'إعدادات الحساب';
	@override String get more => 'خيارات إضافية';
}

// Path: doctorReviews
class _Translations$doctorReviews$ar implements Translations$doctorReviews$en {
	_Translations$doctorReviews$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'أحدث المراجعات';
	@override String get empty => 'لا توجد مراجعات بعد';
	@override String get rating => 'التقييم';
	@override String get count => 'مراجعات';
}

// Path: mvp
class _Translations$mvp$ar implements Translations$mvp$en {
	_Translations$mvp$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get all => 'الكل';
	@override String get appointments => 'المواعيد';
	@override String get upcoming => 'قادمة';
	@override String get completed => 'مكتملة';
	@override String get cancelled => 'ملغاة';
	@override String get workingDays => 'أيام العمل';
	@override String get workingHours => 'ساعات العمل (الرياض)';
	@override String get startTime => 'وقت البداية';
	@override String get endTime => 'وقت النهاية';
	@override String get slotDuration => 'مدة الموعد (دقائق)';
	@override String get saveAvailability => 'حفظ جدول التوفر';
	@override String get repeatDays => 'تتكرر أيام العمل هذه كل أسبوع.';
	@override String get doctorAvailability => 'جدول الطبيب';
	@override String get manageAvailability => 'إدارة جدول التوفر';
	@override String get consultationFee => 'رسوم الاستشارة';
	@override String get clinicLocation => 'موقع العيادة';
	@override String get noAppointments => 'لا توجد مواعيد.';
	@override String get viewDetails => 'عرض التفاصيل';
	@override String get cancelAppointment => 'إلغاء الموعد';
	@override String get cancelQuestion => 'إلغاء الموعد؟';
	@override String get keepAppointment => 'الاحتفاظ بالموعد';
	@override String get markCompleted => 'تحديد الموعد كمكتمل';
	@override String get rateDoctor => 'تقييم الطبيب';
	@override String get howWas => 'كيف كان موعدك؟';
	@override String get optionalReview => 'تعليق (اختياري)';
	@override String get oneReview => 'يمكنك إرسال تقييم واحد لكل موعد مكتمل.';
	@override String get submitReview => 'إرسال التقييم';
	@override String get thankYou => 'شكرًا لتقييمك.';
	@override String get sortBy => 'ترتيب حسب';
	@override String get popular => 'الأكثر شعبية';
	@override String get topRated => 'الأعلى تقييمًا';
	@override String get topRatedDoctors => 'الأطباء الأعلى تقييمًا';
	@override String get active => 'نشط';
	@override String get inactive => 'غير نشط';
	@override String get reviewAppointment => 'مراجعة الموعد';
	@override String get confirmBooking => 'تأكيد الحجز';
	@override String get appointmentDetails => 'تفاصيل الموعد';
	@override String get clinicField => 'موقع العيادة المركزي';
	@override String get monday => 'الإثنين';
	@override String get tuesday => 'الثلاثاء';
	@override String get wednesday => 'الأربعاء';
	@override String get thursday => 'الخميس';
	@override String get friday => 'الجمعة';
	@override String get saturday => 'السبت';
	@override String get sunday => 'الأحد';
}

// Path: commonUi
class _Translations$commonUi$ar implements Translations$commonUi$en {
	_Translations$commonUi$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get feeExample => 'مثال: 28.00';
	@override String get addFavorite => 'إضافة إلى المفضلة';
	@override String get removeFavorite => 'إزالة من المفضلة';
	@override String get saving => 'جارٍ الحفظ...';
	@override String get confirming => 'جارٍ التأكيد...';
	@override String get loading => 'جارٍ التحميل...';
	@override String get saveChanges => 'حفظ التغييرات';
	@override String get appointments => 'المواعيد';
	@override String get manageAvailability => 'إدارة جدول التوفر';
	@override String get doctorAvailability => 'جدول الطبيب';
	@override String get workingDays => 'أيام العمل';
	@override String get workingHours => 'ساعات العمل (الرياض)';
	@override String get startTime => 'وقت البداية';
	@override String get endTime => 'وقت النهاية';
	@override String get slotDuration => 'مدة الموعد (دقائق)';
	@override String get saveAvailability => 'حفظ جدول التوفر';
	@override String get activateDoctor => 'تفعيل الطبيب';
	@override String get deactivateDoctor => 'تعطيل الطبيب';
	@override String get deactivateQuestion => 'تعطيل الطبيب؟';
	@override String get deactivate => 'تعطيل';
	@override String get cancel => 'إلغاء';
	@override String get active => 'نشط';
	@override String get inactive => 'غير نشط';
	@override String get confirm => 'تأكيد';
	@override String get confirmBooking => 'تأكيد الحجز';
	@override String get chooseDate => 'اختيار التاريخ';
	@override String get tryAgain => 'حاول مجددًا';
	@override String get english => 'الإنجليزية';
	@override String get arabic => 'العربية';
	@override String get all => 'الكل';
	@override String get topRatedDoctors => 'الأطباء الأعلى تقييمًا';
	@override String get appointmentDate => 'تاريخ الموعد';
	@override String get appointmentTime => 'وقت الموعد';
	@override String get consultationFee => 'رسوم الاستشارة';
	@override String get addPhoto => 'إضافة صورة (اختياري)';
	@override String get updatePhoto => 'تغيير الصورة';
	@override String get welcomeBack => 'مرحبًا بعودتك';
	@override String get joinUs => 'انضم إلينا للبحث عن طبيب';
	@override String get signupFailed => 'تعذر إنشاء الحساب.';
	@override String get doctorAdded => 'تمت إضافة الطبيب.';
	@override String get doctorUpdated => 'تم تحديث بيانات الطبيب.';
	@override String get doctorAddFailed => 'تعذرت إضافة الطبيب.';
	@override String get doctorUpdateFailed => 'تعذر تحديث بيانات الطبيب.';
	@override String get doctorsLoadFailed => 'تعذر تحميل الأطباء.';
	@override String get noDoctors => 'لا يوجد أطباء متاحون حاليًا.';
	@override String get availabilityUpdated => 'تم تحديث حالة الطبيب.';
	@override String get invalidAvailability => 'حدد أيام العمل وساعات صحيحة ومدة مناسبة للموعد.';
	@override String get invalidFee => 'أدخل رسوم استشارة صحيحة لا تقل عن صفر.';
	@override String get photoTooLarge => 'اختر صورة أصغر من 5 ميغابايت.';
	@override String get invalidPhoto => 'اختر صورة بصيغة JPEG أو PNG أو WebP.';
	@override String get reviewSaveFailed => 'تعذر حفظ التقييم. حاول مجددًا أو تواصل مع العيادة.';
	@override String get invalidReview => 'اختر تقييمًا من ١ إلى ٥ نجوم وتعليقًا لا يتجاوز ١٠٠٠ حرف.';
	@override String get appointmentNotFound => 'الموعد غير موجود.';
	@override String get completedReviewOnly => 'يمكنك تقييم مواعيدك المكتملة فقط.';
	@override String get alreadyReviewed => 'تم تقييم هذا الموعد سابقًا.';
	@override String get doctorNotFound => 'الطبيب غير موجود.';
	@override String get slotTaken => 'حُجز هذا الوقت بالفعل. اختر وقتًا آخر.';
	@override String get doctorUnavailable => 'الطبيب لم يعد متاحًا في هذا الوقت.';
	@override String get feeChanged => 'تغيرت رسوم الاستشارة. أعد فتح تفاصيل الطبيب قبل التأكيد.';
	@override String get clinicNotConfigured => 'لم يُحدد موقع العيادة بعد.';
	@override String get clinicLoadFailed => 'تعذر تحميل موقع العيادة.';
	@override String get enterClinicLocation => 'أدخل موقع العيادة.';
	@override String get clinicInfo => 'عملة الحجز: الدولار الأمريكي · التوقيت: الرياض (UTC+3)';
	@override String get cannotReopen => 'لا يمكن إعادة فتح الموعد.';
	@override String get upcomingOnly => 'يمكن تغيير المواعيد القادمة فقط.';
	@override String get completionTooEarly => 'لا يمكن إكمال الموعد قبل وقت نهايته.';
	@override String get existingBookings => 'عالج الحجوزات القادمة قبل تغيير ساعات العمل.';
	@override String get doctorIdRequired => 'يجب تحديد الطبيب.';
	@override String get signInAgain => 'سجل الدخول مجددًا.';
	@override String get emailReadOnly => 'لا يمكن تغيير البريد الإلكتروني هنا.';
	@override String get notificationPermission => 'اسمح بالإشعارات من إعدادات الجهاز أولًا.';
	@override String get inactiveAccount => 'هذا الحساب غير نشط.';
	@override String get noPatientRole => 'هذا الحساب لا يملك صلاحية المريض.';
	@override String get noAdminRole => 'هذا الحساب لا يملك صلاحية الإدارة.';
	@override String get profileNotFound => 'الملف الشخصي غير موجود.';
	@override String get availabilityAccessFailed => 'تعذر الوصول إلى أوقات الحجز. تواصل مع العيادة ثم حاول مجددًا.';
	@override String get availabilityLoadFailed => 'تعذر تحميل أوقات الحجز. حاول مجددًا.';
	@override String get operationFailed => 'تعذر إتمام العملية. حاول مجددًا.';
	@override String get permissionDenied => 'ليس لديك صلاحية لإتمام هذه العملية.';
	@override String yourRating({required Object rating}) => 'تقييمك: ${rating}/٥';
	@override String enabledDays({required Object count}) => '${count} أيام مفعلة';
	@override String morningSlots({required Object count}) => 'الصباح: ${count} أوقات متاحة';
	@override String doctorRating({required Object rating, required Object count}) => '${rating} · ${count} مراجعات';
	@override String deactivateNamedDoctor({required Object name}) => 'هل تريد تعطيل ${name}؟';
	@override String doctorAppointments({required Object name}) => 'مواعيد ${name}';
	@override String feeValue({required Object amount}) => 'رسوم الاستشارة: ${amount} دولار أمريكي';
	@override String moneyValue({required Object amount}) => '${amount} دولار أمريكي';
	@override String riyadhTime({required Object time}) => '${time} (الرياض)';
	@override String starCount({required Object count}) => '${count} نجوم';
	@override String slotCount({required Object label, required Object count}) => '${label}: ${count}';
	@override String get specialtyOrthopedics => 'العظام';
	@override String get specialtyDermatology => 'الجلدية';
	@override String get specialtyPediatrics => 'طب الأطفال';
	@override String get specialtyPathology => 'علم الأمراض';
	@override String get specialtyOncology => 'الأورام';
}

/// The flat map containing all translations for locale <ar>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsAr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'googleAuthErrors.providerUnavailable' => 'خدمات تسجيل الدخول عبر Google غير متاحة على هذا الجهاز. تحقّق من تحديث خدمات Google Play، وأعد تشغيل الجهاز ثم حاول مجددًا.',
			'googleAuthErrors.configuration' => 'إعداد تسجيل الدخول عبر Google غير صحيح. يرجى التواصل مع الدعم.',
			'googleAuthErrors.cancelled' => 'أُلغي تسجيل الدخول عبر Google. إذا لم تلغِ العملية، حاول مجددًا أو تواصل مع الدعم.',
			'googleAuthErrors.interrupted' => 'انقطع تسجيل الدخول عبر Google. حاول مجددًا.',
			'googleAuthErrors.unavailable' => 'تعذر فتح تسجيل الدخول عبر Google حاليًا. حاول مجددًا.',
			'googleAuthErrors.failed' => 'تعذر تسجيل الدخول عبر Google. حاول مجددًا.',
			'googleAuthErrors.providerDisabled' => 'طريقة تسجيل الدخول هذه غير مفعّلة. يرجى التواصل مع الدعم.',
			'googleAuthErrors.existingAccount' => 'يوجد حساب بهذا البريد يستخدم طريقة دخول أخرى. سجّل الدخول بالطريقة الأصلية أولًا.',
			'googleAuthErrors.popupBlocked' => 'اسمح لنافذة تسجيل الدخول المنبثقة في المتصفح ثم حاول مجددًا.',
			'googleAuthErrors.unsupportedPlatform' => 'تسجيل الدخول عبر Google متاح حاليًا على Android وiOS وmacOS والويب، وغير مدعوم على هذه المنصة.',
			'privacyPolicy.title' => 'سياسة الخصوصية',
			'privacyPolicy.heading' => 'سياسة خصوصية تطبيق Doctor Hunt',
			'privacyPolicy.draftNotice' => 'نص تجريبي مُقدّم لتصميم الشاشة، وليس سياسة خصوصية نهائية.',
			'privacyPolicy.introduction' => 'توجد نسخ عديدة من مقاطع لوريم إيبسوم، لكن أغلبها خضع لتعديلات بإضافة عبارات فكاهية أو كلمات عشوائية. من المعروف أن المحتوى المقروء للصفحة قد يشتت القارئ عند النظر إلى تخطيطها. الغرض من استخدام لوريم إيبسوم هو توفير نص تجريبي. من المعروف أن المحتوى المقروء للصفحة قد يشتت القارئ عند النظر إلى تخطيطها. الغرض من استخدام لوريم إيبسوم هو توفير نص تجريبي.',
			'privacyPolicy.bulletOne' => 'يُعرض أدناه المقطع القياسي من لوريم إيبسوم المستخدم منذ القرن السادس عشر لمن يرغب في الاطلاع عليه.',
			'privacyPolicy.bulletTwo' => 'القسمان 1.10.32 و1.10.33 من كتاب «في غايات الخير والشر». الغرض من استخدام النص.',
			'privacyPolicy.bulletThree' => 'لوريم إيبسوم نص تجريبي. من المعروف أن القارئ قد يتشتت.',
			'privacyPolicy.bulletFour' => 'الغرض من استخدام لوريم إيبسوم هو توفير نص تجريبي. من المعروف أن القارئ قد يتشتت.',
			'privacyPolicy.conclusion' => 'من المعروف أن المحتوى المقروء للصفحة قد يشتت القارئ عند النظر إلى تخطيطها. الغرض من استخدام لوريم إيبسوم هو توفير نص تجريبي.',
			'menu' => 'القائمة',
			'closeMenu' => 'إغلاق القائمة',
			'myAppointments' => 'مواعيدي',
			'appName' => 'Doctor Hunt',
			'onboardingTitleOne' => 'ابحث عن أطباء موثوقين',
			'onboardingDescriptionOne' => 'على عكس الاعتقاد السائد، فإن لوريم إيبسوم ليس مجرد نص عشوائي، بل يعود جذوره إلى الأدب اللاتيني الكلاسيكي.',
			'onboardingTitleTwo' => 'اختر أفضل الأطباء',
			'onboardingDescriptionTwo' => 'على عكس الاعتقاد السائد، فإن لوريم إيبسوم ليس مجرد نص عشوائي، بل يعود جذوره إلى الأدب اللاتيني الكلاسيكي.',
			'onboardingTitleThree' => 'مواعيد سهلة وميسرة',
			'onboardingDescriptionThree' => 'على عكس الاعتقاد السائد، فإن لوريم إيبسوم ليس مجرد نص عشوائي، بل يعود جذوره إلى الأدب اللاتيني الكلاسيكي.',
			'next' => 'التالي',
			'skip' => 'تخطي',
			'getStarted' => 'ابدأ الآن',
			'chooseRoleTitle' => 'اختر دورك',
			'chooseRoleDescription' => 'حدد كيف تريد الاستمرار في التطبيق',
			'patient' => 'مريض',
			'patientDescription' => 'ابحث عن الأطباء واحجز المواعيد بسهولة',
			'admin' => 'مسؤول',
			'adminDescription' => 'متابعة كمسؤول النظام',
			'continueText' => 'متابعة',
			'homeGreeting' => ({required Object name}) => 'مرحباً ${name}!',
			'findYourDoctor' => 'ابحث عن طبيبك',
			'searchDoctor' => 'بحث...',
			'liveDoctors' => 'أطباء متصلون الان',
			'seeAll' => 'عرض الكل',
			'popularDoctors' => 'الأطباء الأكثر شعبية',
			'categories' => 'الأقسام',
			'featureDoctors' => 'أطباء مميزون',
			'findDoctors' => 'البحث عن أطباء',
			'doctorDetails' => 'تفاصيل الطبيب',
			'dentistSearch' => 'طبيب أسنان',
			'nextAvailable' => 'الموعد المتاح التالي',
			'bookNow' => 'احجز الآن',
			'perHour' => '/ساعة',
			'noDoctorsFound' => 'لم يتم العثور على أطباء',
			'running' => 'جاري',
			'ongoing' => 'مستمر',
			'patients' => 'المرضى',
			'services' => 'الخدمات',
			'serviceOne' => 'رعاية المريض هي أولويتنا القصوى دائماً.',
			'serviceTwo' => 'نستمع إليك بصلابة ونشرح كل خطوة علاجية بوضوح.',
			'serviceThree' => 'رعاية حديثة يدعمها طاقم طبي ذو خبرة عالية.',
			'location' => 'الموقع',
			'dental' => 'أسنان',
			'cardiology' => 'أمراض القلب',
			'ophthalmology' => 'العيون',
			'generalMedicine' => 'طب عام',
			'home' => 'الرئيسية',
			'favorites' => 'المفضلة',
			'messages' => 'الرسائل',
			'profile' => 'الملف الشخصي',
			'selecttime' => 'اختر الوقت',
			'today' => 'اليوم',
			'noSlotsAvailable' => 'لا توجد أوقات متاحة',
			'afternoon' => 'بعد الظهر',
			'evening' => 'المساء',
			'slots' => 'أوقات',
			'tomorrow' => 'غداً',
			'slotsAvailable' => 'أوقات متاحة',
			'nextAvailabilityOn' => 'الموعد المتاح التالي في',
			'orText' => 'أو',
			'contactClinic' => 'التواصل مع العيادة',
			'bookAppointment' => 'تأكيد',
			'thankYou' => 'شكراً لك!',
			'appointmentSuccessful' => 'تم حجز موعدك بنجاح',
			'done' => 'تم',
			'editAppointment' => 'تعديل الموعد',
			'appointmentConfirmation' => ({required Object doctorName, required Object date, required Object time}) => 'لقد قمت بحجز موعد مع ${doctorName} بتاريخ ${date} الساعة ${time}',
			'noFavoriteDoctors' => 'لا يوجد أطباء مفضلون',
			'email' => 'البريد الإلكتروني',
			'enterEmail' => 'أدخل بريدك الإلكتروني',
			'password' => 'كلمة المرور',
			'enterPassword' => 'أدخل كلمة المرور',
			'welcome' => 'مرحباً بعودتك',
			'loginAdmin' => 'تسجيل الدخول لحساب المسؤول',
			'botnlogin' => 'تسجيل الدخول',
			'loginTitle' => 'تسجيل الدخول إلى حسابك',
			'adminLoginTitle' => 'تسجيل دخول المسؤول',
			'forgotPassword' => 'هل نسيت كلمة المرور؟',
			'orDivider' => 'أو',
			'signInWithGoogle' => 'تسجيل الدخول بواسطة Google',
			'doctor' => 'الأطباء',
			'searchDoctors' => 'البحث عن الأطباء',
			'totalDoctors' => 'إجمالي الأطباء',
			'activeDoctors' => 'الأطباء النشطون',
			'active' => 'نشط',
			'inactive' => 'غير نشط',
			'addDoctor' => 'إضافة طبيب',
			'createDoctor' => 'إنشاء طبيب',
			'doctorName' => 'اسم الطبيب',
			'enterDoctorName' => 'أدخل اسم الطبيب',
			'doctorImage' => 'صورة الطبيب',
			'uploadDoctorImage' => 'رفع صورة الطبيب',
			'supportedImageFormats' => 'صيغ PNG أو JPG بحجم حتى 5 ميجابايت',
			'editDoctor' => 'تعديل بيانات الطبيب',
			'deleteDoctor' => 'حذف الطبيب',
			'cancel' => 'إلغاء',
			'save' => 'حفظ',
			'doctorCreatedSuccessfully' => 'تم إنشاء حساب الطبيب بنجاح',
			'doctorUpdatedSuccessfully' => 'تم تحديث بيانات الطبيب بنجاح',
			'doctorDeletedSuccessfully' => 'تم حذف الطبيب بنجاح',
			'failedToCreateDoctor' => 'فشل إنشاء حساب الطبيب',
			'noDoctorsAvailable' => 'لا يوجد أطباء متاحون حالياً',
			'specialization' => 'التخصص',
			'selectSpecialization' => 'اختر التخصص',
			'doctorNameRequired' => 'اسم الطبيب مطلوب',
			'specializationRequired' => 'التخصص مطلوب',
			'failedToLoadDoctors' => 'فشل تحميل قائمة الأطباء',
			'auth.login' => 'تسجيل الدخول',
			'auth.email' => 'عنوان البريد الإلكتروني',
			'auth.password' => 'كلمة المرور',
			'auth.loginSuccess' => 'تم تسجيل الدخول بنجاح',
			'auth.loginError' => 'حدث خطأ أثناء تسجيل الدخول',
			'roles.chooseRole' => 'اختر دورك',
			'roles.patient' => 'مريض',
			'roles.admin' => 'مسؤول',
			'common.cancel' => 'إلغاء',
			'common.confirm' => 'تأكيد',
			'doctors.notFound' => 'لم يتم العثور على الطبيب',
			'dontHaveAccount' => 'ليس لديك حساب؟',
			'signUp' => 'إنشاء حساب',
			'signUpTitle' => 'حساب جديد',
			'fullName' => 'الاسم الكامل',
			'enterFullName' => 'أدخل اسمك الكامل',
			'alreadyHaveAccount' => 'لديك حساب بالفعل؟',
			'errors.noPatientRole' => 'هذا الحساب لا يملك صلاحية مريض.',
			'errors.noAdminRole' => 'هذا الحساب لا يملك صلاحية مسؤول.',
			'errors.loginFailed' => 'فشل تسجيل الدخول.',
			'resetPasswordTitle' => 'إعادة تعيين كلمة المرور',
			'resetPasswordDescription' => 'أدخلي بريدك الإلكتروني لاستلام رابط إعادة تعيين كلمة المرور.',
			'sendResetLink' => 'إرسال رابط إعادة التعيين',
			'resetEmailSent' => 'إذا كان هناك حساب مرتبط بهذا البريد، فسيصلك رابط إعادة تعيين كلمة المرور.',
			'resetPasswordFailed' => 'تعذّر إرسال رابط إعادة تعيين كلمة المرور. حاولي مرة أخرى.',
			'requiredField' => 'هذا الحقل مطلوب.',
			'invalidEmail' => 'أدخلي بريدًا إلكترونيًا صحيحًا.',
			'tooManyRequests' => 'عدد المحاولات كبير جدًا. حاولي مرة أخرى لاحقًا.',
			'networkError' => 'حدث خطأ في الشبكة. تحققي من الاتصال وحاولي مرة أخرى.',
			'nouser' => 'لم يُرجع نظام المصادقة أي مستخدم.',
			'noAuthenticatedUser' => 'لا يوجد مستخدم مسجل الدخول.',
			'noEmailAddress' => 'الحساب الحالي لا يحتوي على عنوان بريد إلكتروني.',
			'newPasswordMustBeDifferent' => 'يجب أن تختلف كلمة المرور الجديدة عن الحالية.',
			'passwordTooShort' => 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل.',
			'passwordsDoNotMatch' => 'كلمتا المرور غير متطابقتين.',
			'changePasswordDescription' => 'أدخل كلمة المرور الحالية واختاري كلمة مرور جديدة.',
			'profileForm.edit' => 'تعديل الملف الشخصي',
			'profileForm.name' => 'الاسم الكامل',
			'profileForm.email' => 'البريد الإلكتروني',
			'profileForm.phone' => 'رقم التواصل',
			'profileForm.birthDate' => 'تاريخ الميلاد',
			'profileForm.gender' => 'الجنس',
			'profileForm.male' => 'ذكر',
			'profileForm.female' => 'أنثى',
			'profileForm.other' => 'آخر',
			'profileForm.save' => 'حفظ التغييرات',
			'profileForm.saved' => 'تم تحديث الملف الشخصي',
			'profileForm.photo' => 'اضغط لتغيير الصورة',
			'profileForm.personalInfo' => 'المعلومات الشخصية',
			'preferences.buildVersion' => 'إصدار التطبيق',
			'preferences.versionUnavailable' => 'غير متاح',
			'preferences.title' => 'الإعدادات',
			'preferences.notifications' => 'الإشعارات',
			'preferences.language' => 'اللغة',
			'preferences.logout' => 'تسجيل الخروج',
			'preferences.logoutQuestion' => 'هل تريد تسجيل الخروج؟',
			'preferences.cancel' => 'إلغاء',
			'preferences.security' => 'إعدادات الحساب',
			'preferences.more' => 'خيارات إضافية',
			'doctorReviews.title' => 'أحدث المراجعات',
			'doctorReviews.empty' => 'لا توجد مراجعات بعد',
			'doctorReviews.rating' => 'التقييم',
			'doctorReviews.count' => 'مراجعات',
			'changePasswordTitle' => 'تغيير كلمة المرور',
			'currentPassword' => 'كلمة المرور الحالية',
			'newPassword' => 'كلمة المرور الجديدة',
			'confirmNewPassword' => 'تأكيد كلمة المرور الجديدة',
			'passwordChanged' => 'تم تغيير كلمة المرور',
			'changePasswordFailed' => 'تعذر تغيير كلمة المرور. حاول مجددًا.',
			'retry' => 'حاول مجددًا',
			'wrongCurrentPassword' => 'كلمة المرور الحالية غير صحيحة',
			'requiresRecentLogin' => 'سجل الدخول مجددًا قبل تغيير كلمة المرور',
			'mvp.all' => 'الكل',
			'mvp.appointments' => 'المواعيد',
			'mvp.upcoming' => 'قادمة',
			'mvp.completed' => 'مكتملة',
			'mvp.cancelled' => 'ملغاة',
			'mvp.workingDays' => 'أيام العمل',
			'mvp.workingHours' => 'ساعات العمل (الرياض)',
			'mvp.startTime' => 'وقت البداية',
			'mvp.endTime' => 'وقت النهاية',
			'mvp.slotDuration' => 'مدة الموعد (دقائق)',
			'mvp.saveAvailability' => 'حفظ جدول التوفر',
			'mvp.repeatDays' => 'تتكرر أيام العمل هذه كل أسبوع.',
			'mvp.doctorAvailability' => 'جدول الطبيب',
			'mvp.manageAvailability' => 'إدارة جدول التوفر',
			'mvp.consultationFee' => 'رسوم الاستشارة',
			'mvp.clinicLocation' => 'موقع العيادة',
			'mvp.noAppointments' => 'لا توجد مواعيد.',
			'mvp.viewDetails' => 'عرض التفاصيل',
			'mvp.cancelAppointment' => 'إلغاء الموعد',
			'mvp.cancelQuestion' => 'إلغاء الموعد؟',
			'mvp.keepAppointment' => 'الاحتفاظ بالموعد',
			'mvp.markCompleted' => 'تحديد الموعد كمكتمل',
			'mvp.rateDoctor' => 'تقييم الطبيب',
			'mvp.howWas' => 'كيف كان موعدك؟',
			'mvp.optionalReview' => 'تعليق (اختياري)',
			'mvp.oneReview' => 'يمكنك إرسال تقييم واحد لكل موعد مكتمل.',
			'mvp.submitReview' => 'إرسال التقييم',
			'mvp.thankYou' => 'شكرًا لتقييمك.',
			'mvp.sortBy' => 'ترتيب حسب',
			'mvp.popular' => 'الأكثر شعبية',
			'mvp.topRated' => 'الأعلى تقييمًا',
			'mvp.topRatedDoctors' => 'الأطباء الأعلى تقييمًا',
			'mvp.active' => 'نشط',
			'mvp.inactive' => 'غير نشط',
			'mvp.reviewAppointment' => 'مراجعة الموعد',
			'mvp.confirmBooking' => 'تأكيد الحجز',
			'mvp.appointmentDetails' => 'تفاصيل الموعد',
			'mvp.clinicField' => 'موقع العيادة المركزي',
			'mvp.monday' => 'الإثنين',
			'mvp.tuesday' => 'الثلاثاء',
			'mvp.wednesday' => 'الأربعاء',
			'mvp.thursday' => 'الخميس',
			'mvp.friday' => 'الجمعة',
			'mvp.saturday' => 'السبت',
			'mvp.sunday' => 'الأحد',
			'commonUi.feeExample' => 'مثال: 28.00',
			'commonUi.addFavorite' => 'إضافة إلى المفضلة',
			'commonUi.removeFavorite' => 'إزالة من المفضلة',
			'commonUi.saving' => 'جارٍ الحفظ...',
			'commonUi.confirming' => 'جارٍ التأكيد...',
			'commonUi.loading' => 'جارٍ التحميل...',
			'commonUi.saveChanges' => 'حفظ التغييرات',
			'commonUi.appointments' => 'المواعيد',
			'commonUi.manageAvailability' => 'إدارة جدول التوفر',
			'commonUi.doctorAvailability' => 'جدول الطبيب',
			'commonUi.workingDays' => 'أيام العمل',
			'commonUi.workingHours' => 'ساعات العمل (الرياض)',
			'commonUi.startTime' => 'وقت البداية',
			'commonUi.endTime' => 'وقت النهاية',
			'commonUi.slotDuration' => 'مدة الموعد (دقائق)',
			'commonUi.saveAvailability' => 'حفظ جدول التوفر',
			'commonUi.activateDoctor' => 'تفعيل الطبيب',
			'commonUi.deactivateDoctor' => 'تعطيل الطبيب',
			'commonUi.deactivateQuestion' => 'تعطيل الطبيب؟',
			'commonUi.deactivate' => 'تعطيل',
			'commonUi.cancel' => 'إلغاء',
			'commonUi.active' => 'نشط',
			'commonUi.inactive' => 'غير نشط',
			'commonUi.confirm' => 'تأكيد',
			'commonUi.confirmBooking' => 'تأكيد الحجز',
			'commonUi.chooseDate' => 'اختيار التاريخ',
			'commonUi.tryAgain' => 'حاول مجددًا',
			'commonUi.english' => 'الإنجليزية',
			'commonUi.arabic' => 'العربية',
			'commonUi.all' => 'الكل',
			'commonUi.topRatedDoctors' => 'الأطباء الأعلى تقييمًا',
			'commonUi.appointmentDate' => 'تاريخ الموعد',
			'commonUi.appointmentTime' => 'وقت الموعد',
			'commonUi.consultationFee' => 'رسوم الاستشارة',
			'commonUi.addPhoto' => 'إضافة صورة (اختياري)',
			'commonUi.updatePhoto' => 'تغيير الصورة',
			'commonUi.welcomeBack' => 'مرحبًا بعودتك',
			'commonUi.joinUs' => 'انضم إلينا للبحث عن طبيب',
			'commonUi.signupFailed' => 'تعذر إنشاء الحساب.',
			'commonUi.doctorAdded' => 'تمت إضافة الطبيب.',
			'commonUi.doctorUpdated' => 'تم تحديث بيانات الطبيب.',
			'commonUi.doctorAddFailed' => 'تعذرت إضافة الطبيب.',
			'commonUi.doctorUpdateFailed' => 'تعذر تحديث بيانات الطبيب.',
			'commonUi.doctorsLoadFailed' => 'تعذر تحميل الأطباء.',
			'commonUi.noDoctors' => 'لا يوجد أطباء متاحون حاليًا.',
			'commonUi.availabilityUpdated' => 'تم تحديث حالة الطبيب.',
			'commonUi.invalidAvailability' => 'حدد أيام العمل وساعات صحيحة ومدة مناسبة للموعد.',
			'commonUi.invalidFee' => 'أدخل رسوم استشارة صحيحة لا تقل عن صفر.',
			'commonUi.photoTooLarge' => 'اختر صورة أصغر من 5 ميغابايت.',
			'commonUi.invalidPhoto' => 'اختر صورة بصيغة JPEG أو PNG أو WebP.',
			'commonUi.reviewSaveFailed' => 'تعذر حفظ التقييم. حاول مجددًا أو تواصل مع العيادة.',
			'commonUi.invalidReview' => 'اختر تقييمًا من ١ إلى ٥ نجوم وتعليقًا لا يتجاوز ١٠٠٠ حرف.',
			'commonUi.appointmentNotFound' => 'الموعد غير موجود.',
			'commonUi.completedReviewOnly' => 'يمكنك تقييم مواعيدك المكتملة فقط.',
			'commonUi.alreadyReviewed' => 'تم تقييم هذا الموعد سابقًا.',
			'commonUi.doctorNotFound' => 'الطبيب غير موجود.',
			'commonUi.slotTaken' => 'حُجز هذا الوقت بالفعل. اختر وقتًا آخر.',
			'commonUi.doctorUnavailable' => 'الطبيب لم يعد متاحًا في هذا الوقت.',
			'commonUi.feeChanged' => 'تغيرت رسوم الاستشارة. أعد فتح تفاصيل الطبيب قبل التأكيد.',
			'commonUi.clinicNotConfigured' => 'لم يُحدد موقع العيادة بعد.',
			'commonUi.clinicLoadFailed' => 'تعذر تحميل موقع العيادة.',
			'commonUi.enterClinicLocation' => 'أدخل موقع العيادة.',
			'commonUi.clinicInfo' => 'عملة الحجز: الدولار الأمريكي · التوقيت: الرياض (UTC+3)',
			'commonUi.cannotReopen' => 'لا يمكن إعادة فتح الموعد.',
			'commonUi.upcomingOnly' => 'يمكن تغيير المواعيد القادمة فقط.',
			'commonUi.completionTooEarly' => 'لا يمكن إكمال الموعد قبل وقت نهايته.',
			'commonUi.existingBookings' => 'عالج الحجوزات القادمة قبل تغيير ساعات العمل.',
			'commonUi.doctorIdRequired' => 'يجب تحديد الطبيب.',
			'commonUi.signInAgain' => 'سجل الدخول مجددًا.',
			'commonUi.emailReadOnly' => 'لا يمكن تغيير البريد الإلكتروني هنا.',
			'commonUi.notificationPermission' => 'اسمح بالإشعارات من إعدادات الجهاز أولًا.',
			'commonUi.inactiveAccount' => 'هذا الحساب غير نشط.',
			'commonUi.noPatientRole' => 'هذا الحساب لا يملك صلاحية المريض.',
			'commonUi.noAdminRole' => 'هذا الحساب لا يملك صلاحية الإدارة.',
			'commonUi.profileNotFound' => 'الملف الشخصي غير موجود.',
			'commonUi.availabilityAccessFailed' => 'تعذر الوصول إلى أوقات الحجز. تواصل مع العيادة ثم حاول مجددًا.',
			'commonUi.availabilityLoadFailed' => 'تعذر تحميل أوقات الحجز. حاول مجددًا.',
			'commonUi.operationFailed' => 'تعذر إتمام العملية. حاول مجددًا.',
			'commonUi.permissionDenied' => 'ليس لديك صلاحية لإتمام هذه العملية.',
			'commonUi.yourRating' => ({required Object rating}) => 'تقييمك: ${rating}/٥',
			'commonUi.enabledDays' => ({required Object count}) => '${count} أيام مفعلة',
			'commonUi.morningSlots' => ({required Object count}) => 'الصباح: ${count} أوقات متاحة',
			'commonUi.doctorRating' => ({required Object rating, required Object count}) => '${rating} · ${count} مراجعات',
			'commonUi.deactivateNamedDoctor' => ({required Object name}) => 'هل تريد تعطيل ${name}؟',
			'commonUi.doctorAppointments' => ({required Object name}) => 'مواعيد ${name}',
			'commonUi.feeValue' => ({required Object amount}) => 'رسوم الاستشارة: ${amount} دولار أمريكي',
			'commonUi.moneyValue' => ({required Object amount}) => '${amount} دولار أمريكي',
			'commonUi.riyadhTime' => ({required Object time}) => '${time} (الرياض)',
			'commonUi.starCount' => ({required Object count}) => '${count} نجوم',
			'commonUi.slotCount' => ({required Object label, required Object count}) => '${label}: ${count}',
			'commonUi.specialtyOrthopedics' => 'العظام',
			'commonUi.specialtyDermatology' => 'الجلدية',
			'commonUi.specialtyPediatrics' => 'طب الأطفال',
			'commonUi.specialtyPathology' => 'علم الأمراض',
			'commonUi.specialtyOncology' => 'الأورام',
			_ => null,
		};
	}
}
