///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	dynamic operator[](String key) => _meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$googleAuthErrors$en googleAuthErrors = Translations$googleAuthErrors$en._(_root);
	late final Translations$privacyPolicy$en privacyPolicy = Translations$privacyPolicy$en._(_root);

	/// en: 'Menu'
	String get menu => 'Menu';

	/// en: 'Close menu'
	String get closeMenu => 'Close menu';

	/// en: 'My Appointments'
	String get myAppointments => 'My Appointments';

	/// en: 'Doctor Hunt'
	String get appName => 'Doctor Hunt';

	/// en: 'Find Trusted Doctors'
	String get onboardingTitleOne => 'Find Trusted Doctors';

	/// en: 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.'
	String get onboardingDescriptionOne => 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.';

	/// en: 'Choose Best Doctors'
	String get onboardingTitleTwo => 'Choose Best Doctors';

	/// en: 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.'
	String get onboardingDescriptionTwo => 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.';

	/// en: 'Easy Appointments'
	String get onboardingTitleThree => 'Easy Appointments';

	/// en: 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.'
	String get onboardingDescriptionThree => 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.';

	/// en: 'Next'
	String get next => 'Next';

	/// en: 'Skip'
	String get skip => 'Skip';

	/// en: 'Get Started'
	String get getStarted => 'Get Started';

	/// en: 'Choose your role'
	String get chooseRoleTitle => 'Choose your role';

	/// en: 'Select how you want to continue'
	String get chooseRoleDescription => 'Select how you want to continue';

	/// en: 'Patient'
	String get patient => 'Patient';

	/// en: 'Find doctors and book appointments'
	String get patientDescription => 'Find doctors and book appointments';

	/// en: 'Admin'
	String get admin => 'Admin';

	/// en: 'Continue'
	String get adminDescription => 'Continue';

	/// en: 'Continue'
	String get continueText => 'Continue';

	/// en: 'Hi $name!'
	String homeGreeting({required Object name}) => 'Hi ${name}!';

	/// en: 'Find Your Doctor'
	String get findYourDoctor => 'Find Your Doctor';

	/// en: 'Search...'
	String get searchDoctor => 'Search...';

	/// en: 'Live Doctors'
	String get liveDoctors => 'Live Doctors';

	/// en: 'See all'
	String get seeAll => 'See all';

	/// en: 'Popular Doctor'
	String get popularDoctors => 'Popular Doctor';

	/// en: 'Categories'
	String get categories => 'Categories';

	/// en: 'Feature Doctor'
	String get featureDoctors => 'Feature Doctor';

	/// en: 'Find Doctors'
	String get findDoctors => 'Find Doctors';

	/// en: 'Doctor Details'
	String get doctorDetails => 'Doctor Details';

	/// en: 'Dentist'
	String get dentistSearch => 'Dentist';

	/// en: 'Next Available'
	String get nextAvailable => 'Next Available';

	/// en: 'Book Now'
	String get bookNow => 'Book Now';

	/// en: '/hr'
	String get perHour => '/hr';

	/// en: 'No doctors found'
	String get noDoctorsFound => 'No doctors found';

	/// en: 'Running'
	String get running => 'Running';

	/// en: 'Ongoing'
	String get ongoing => 'Ongoing';

	/// en: 'Patients'
	String get patients => 'Patients';

	/// en: 'Services'
	String get services => 'Services';

	/// en: 'Patient care should be the number one priority.'
	String get serviceOne => 'Patient care should be the number one priority.';

	/// en: 'We listen carefully and explain every treatment clearly.'
	String get serviceTwo => 'We listen carefully and explain every treatment clearly.';

	/// en: 'Modern care supported by experienced medical staff.'
	String get serviceThree => 'Modern care supported by experienced medical staff.';

	/// en: 'Location'
	String get location => 'Location';

	/// en: 'Dental'
	String get dental => 'Dental';

	/// en: 'Cardiology'
	String get cardiology => 'Cardiology';

	/// en: 'Ophthalmology'
	String get ophthalmology => 'Ophthalmology';

	/// en: 'General'
	String get generalMedicine => 'General';

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'Favorites'
	String get favorites => 'Favorites';

	/// en: 'Messages'
	String get messages => 'Messages';

	/// en: 'Profile'
	String get profile => 'Profile';

	/// en: 'SelectTime'
	String get selecttime => 'SelectTime';

	/// en: 'Today'
	String get today => 'Today';

	/// en: 'No slots available'
	String get noSlotsAvailable => 'No slots available';

	/// en: 'Afternoon'
	String get afternoon => 'Afternoon';

	/// en: 'Evening'
	String get evening => 'Evening';

	/// en: 'slots'
	String get slots => 'slots';

	/// en: 'Tomorrow'
	String get tomorrow => 'Tomorrow';

	/// en: 'slots available'
	String get slotsAvailable => 'slots available';

	/// en: 'Next availability on'
	String get nextAvailabilityOn => 'Next availability on';

	/// en: 'OR'
	String get orText => 'OR';

	/// en: 'Contact Clinic'
	String get contactClinic => 'Contact Clinic';

	/// en: 'Confirm'
	String get bookAppointment => 'Confirm';

	/// en: 'Thank You !'
	String get thankYou => 'Thank You !';

	/// en: 'Your Appointment Successful'
	String get appointmentSuccessful => 'Your Appointment Successful';

	/// en: 'Done'
	String get done => 'Done';

	/// en: 'Edit your appointment'
	String get editAppointment => 'Edit your appointment';

	/// en: 'You booked an appointment with $doctorName on $date, at $time'
	String appointmentConfirmation({required Object doctorName, required Object date, required Object time}) => 'You booked an appointment with ${doctorName} on ${date}, at ${time}';

	/// en: 'No favorite doctors yet'
	String get noFavoriteDoctors => 'No favorite doctors yet';

	/// en: 'Email'
	String get email => 'Email';

	/// en: 'Enter your email'
	String get enterEmail => 'Enter your email';

	/// en: 'Password'
	String get password => 'Password';

	/// en: 'Enter your password'
	String get enterPassword => 'Enter your password';

	/// en: 'Welcome Back'
	String get welcome => 'Welcome Back';

	/// en: 'Login to your admin account'
	String get loginAdmin => 'Login to your admin account';

	/// en: 'Login'
	String get botnlogin => 'Login';

	/// en: 'Login to your account'
	String get loginTitle => 'Login to your account';

	/// en: 'Admin Login'
	String get adminLoginTitle => 'Admin Login';

	/// en: 'Forgot Password?'
	String get forgotPassword => 'Forgot Password?';

	/// en: 'OR'
	String get orDivider => 'OR';

	/// en: 'Sign in with Google'
	String get signInWithGoogle => 'Sign in with Google';

	/// en: 'Doctors'
	String get doctor => 'Doctors';

	/// en: 'Search doctors'
	String get searchDoctors => 'Search doctors';

	/// en: 'Total Doctors'
	String get totalDoctors => 'Total Doctors';

	/// en: 'Active Doctors'
	String get activeDoctors => 'Active Doctors';

	/// en: 'Active'
	String get active => 'Active';

	/// en: 'Inactive'
	String get inactive => 'Inactive';

	/// en: 'Add Doctor'
	String get addDoctor => 'Add Doctor';

	/// en: 'Create Doctor'
	String get createDoctor => 'Create Doctor';

	/// en: 'Doctor Name'
	String get doctorName => 'Doctor Name';

	/// en: 'Enter doctor name'
	String get enterDoctorName => 'Enter doctor name';

	/// en: 'Doctor Image'
	String get doctorImage => 'Doctor Image';

	/// en: 'Upload doctor image'
	String get uploadDoctorImage => 'Upload doctor image';

	/// en: 'PNG or JPG up to 5 MB'
	String get supportedImageFormats => 'PNG or JPG up to 5 MB';

	/// en: 'Edit Doctor'
	String get editDoctor => 'Edit Doctor';

	/// en: 'Delete Doctor'
	String get deleteDoctor => 'Delete Doctor';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Doctor created successfully'
	String get doctorCreatedSuccessfully => 'Doctor created successfully';

	/// en: 'Doctor updated successfully'
	String get doctorUpdatedSuccessfully => 'Doctor updated successfully';

	/// en: 'Doctor deleted successfully'
	String get doctorDeletedSuccessfully => 'Doctor deleted successfully';

	/// en: 'Failed to create doctor'
	String get failedToCreateDoctor => 'Failed to create doctor';

	/// en: 'No doctors available'
	String get noDoctorsAvailable => 'No doctors available';

	/// en: 'Specialization'
	String get specialization => 'Specialization';

	/// en: 'Select specialization'
	String get selectSpecialization => 'Select specialization';

	/// en: 'Doctor name is required'
	String get doctorNameRequired => 'Doctor name is required';

	/// en: 'Specialization is required'
	String get specializationRequired => 'Specialization is required';

	/// en: 'Failed to load Doctor'
	String get failedToLoadDoctors => 'Failed to load Doctor';

	late final Translations$auth$en auth = Translations$auth$en._(_root);
	late final Translations$roles$en roles = Translations$roles$en._(_root);
	late final Translations$common$en common = Translations$common$en._(_root);
	late final Translations$doctors$en doctors = Translations$doctors$en._(_root);

	/// en: 'Don't have an account?'
	String get dontHaveAccount => 'Don\'t have an account?';

	/// en: 'Sign Up'
	String get signUp => 'Sign Up';

	/// en: 'Create Account'
	String get signUpTitle => 'Create Account';

	/// en: 'Full Name'
	String get fullName => 'Full Name';

	/// en: 'Enter your full name'
	String get enterFullName => 'Enter your full name';

	/// en: 'Already have an account?'
	String get alreadyHaveAccount => 'Already have an account?';

	late final Translations$errors$en errors = Translations$errors$en._(_root);

	/// en: 'Reset Password'
	String get resetPasswordTitle => 'Reset Password';

	/// en: 'Enter your email address to receive a password reset link.'
	String get resetPasswordDescription => 'Enter your email address to receive a password reset link.';

	/// en: 'Send Reset Link'
	String get sendResetLink => 'Send Reset Link';

	/// en: 'If an account exists for this email, you will receive a password reset link.'
	String get resetEmailSent => 'If an account exists for this email, you will receive a password reset link.';

	/// en: 'Unable to send the password reset email. Please try again.'
	String get resetPasswordFailed => 'Unable to send the password reset email. Please try again.';

	/// en: 'Change Password'
	String get changePasswordTitle => 'Change Password';

	/// en: 'Current Password'
	String get currentPassword => 'Current Password';

	/// en: 'New Password'
	String get newPassword => 'New Password';

	/// en: 'Confirm New Password'
	String get confirmNewPassword => 'Confirm New Password';

	/// en: 'Your password has been changed successfully.'
	String get passwordChanged => 'Your password has been changed successfully.';

	/// en: 'Unable to change your password. Please try again.'
	String get changePasswordFailed => 'Unable to change your password. Please try again.';

	/// en: 'The passwords do not match.'
	String get passwordsDoNotMatch => 'The passwords do not match.';

	/// en: 'The password must be at least 6 characters long.'
	String get passwordTooShort => 'The password must be at least 6 characters long.';

	/// en: 'This field is required'
	String get requiredField => 'This field is required';

	/// en: 'Please enter a valid email address'
	String get invalidEmail => 'Please enter a valid email address';

	/// en: 'Try Again'
	String get retry => 'Try Again';

	/// en: 'Authentication returned no user.'
	String get nouser => 'Authentication returned no user.';

	/// en: 'No authenticated user.'
	String get noAuthenticatedUser => 'No authenticated user.';

	/// en: 'The current account does not have an email address.'
	String get noEmailAddress => 'The current account does not have an email address.';

	/// en: 'Too many attempts. Please try again later.'
	String get tooManyRequests => 'Too many attempts. Please try again later.';

	/// en: 'A network error occurred. Check your connection and try again.'
	String get networkError => 'A network error occurred. Check your connection and try again.';

	/// en: 'The current password is incorrect.'
	String get wrongCurrentPassword => 'The current password is incorrect.';

	/// en: 'For security, sign in again before changing your password.'
	String get requiresRecentLogin => 'For security, sign in again before changing your password.';

	/// en: 'Enter your current password and choose a new password.'
	String get changePasswordDescription => 'Enter your current password and choose a new password.';

	/// en: 'Your new password must be different from your current password.'
	String get newPasswordMustBeDifferent => 'Your new password must be different from your current password.';

	late final Translations$profileForm$en profileForm = Translations$profileForm$en._(_root);
	late final Translations$preferences$en preferences = Translations$preferences$en._(_root);
	late final Translations$doctorReviews$en doctorReviews = Translations$doctorReviews$en._(_root);
	late final Translations$mvp$en mvp = Translations$mvp$en._(_root);
	late final Translations$commonUi$en commonUi = Translations$commonUi$en._(_root);
}

// Path: googleAuthErrors
class Translations$googleAuthErrors$en {
	Translations$googleAuthErrors$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Google sign-in services are unavailable on this device. Check Google Play services updates, restart the device, and try again.'
	String get providerUnavailable => 'Google sign-in services are unavailable on this device. Check Google Play services updates, restart the device, and try again.';

	/// en: 'Google sign-in is not configured correctly. Please contact support.'
	String get configuration => 'Google sign-in is not configured correctly. Please contact support.';

	/// en: 'Google sign-in was cancelled. If you did not cancel, try again or contact support.'
	String get cancelled => 'Google sign-in was cancelled. If you did not cancel, try again or contact support.';

	/// en: 'Google sign-in was interrupted. Please try again.'
	String get interrupted => 'Google sign-in was interrupted. Please try again.';

	/// en: 'Google sign-in cannot open right now. Please try again.'
	String get unavailable => 'Google sign-in cannot open right now. Please try again.';

	/// en: 'Could not sign in with Google. Please try again.'
	String get failed => 'Could not sign in with Google. Please try again.';

	/// en: 'This sign-in method is not enabled. Please contact support.'
	String get providerDisabled => 'This sign-in method is not enabled. Please contact support.';

	/// en: 'An account with this email already exists using another sign-in method. Sign in using that method first.'
	String get existingAccount => 'An account with this email already exists using another sign-in method. Sign in using that method first.';

	/// en: 'Allow the sign-in pop-up in your browser and try again.'
	String get popupBlocked => 'Allow the sign-in pop-up in your browser and try again.';

	/// en: 'Google sign-in is currently available on Android, iOS, macOS, and the web. It is not supported on this platform.'
	String get unsupportedPlatform => 'Google sign-in is currently available on Android, iOS, macOS, and the web. It is not supported on this platform.';
}

// Path: privacyPolicy
class Translations$privacyPolicy$en {
	Translations$privacyPolicy$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Privacy Policy'
	String get title => 'Privacy Policy';

	/// en: 'Doctor Hunt Apps Privacy Policy'
	String get heading => 'Doctor Hunt Apps Privacy Policy';

	/// en: 'Demo text supplied for the screen design. This is not a finalized privacy policy.'
	String get draftNotice => 'Demo text supplied for the screen design. This is not a finalized privacy policy.';

	/// en: 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words believable. It is a long established fact that reader will distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a moreIt is a long established fact that reader will distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more'
	String get introduction => 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words believable. It is a long established fact that reader will distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a moreIt is a long established fact that reader will distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more';

	/// en: 'The standard chunk of lorem Ipsum used since 1500s is reproduced below for those interested.'
	String get bulletOne => 'The standard chunk of lorem Ipsum used since 1500s is reproduced below for those interested.';

	/// en: 'Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum. The point of using.'
	String get bulletTwo => 'Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum. The point of using.';

	/// en: 'Lorem Ipsum is that it has a moreIt is a long established fact that reader will distracted.'
	String get bulletThree => 'Lorem Ipsum is that it has a moreIt is a long established fact that reader will distracted.';

	/// en: 'The point of using Lorem Ipsum is that it has a moreIt is a long established fact that reader will distracted.'
	String get bulletFour => 'The point of using Lorem Ipsum is that it has a moreIt is a long established fact that reader will distracted.';

	/// en: 'It is a long established fact that reader distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a moreIt is a long established.'
	String get conclusion => 'It is a long established fact that reader distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a moreIt is a long established.';
}

// Path: auth
class Translations$auth$en {
	Translations$auth$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Login'
	String get login => 'Login';

	/// en: 'Email Address'
	String get email => 'Email Address';

	/// en: 'Password'
	String get password => 'Password';

	/// en: 'Logged in successfully'
	String get loginSuccess => 'Logged in successfully';

	/// en: 'An error occurred during login'
	String get loginError => 'An error occurred during login';
}

// Path: roles
class Translations$roles$en {
	Translations$roles$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Choose Your Role'
	String get chooseRole => 'Choose Your Role';

	/// en: 'Patient'
	String get patient => 'Patient';

	/// en: 'Admin'
	String get admin => 'Admin';
}

// Path: common
class Translations$common$en {
	Translations$common$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Confirm'
	String get confirm => 'Confirm';
}

// Path: doctors
class Translations$doctors$en {
	Translations$doctors$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Doctor not found'
	String get notFound => 'Doctor not found';
}

// Path: errors
class Translations$errors$en {
	Translations$errors$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'This account does not have a patient role.'
	String get noPatientRole => 'This account does not have a patient role.';

	/// en: 'This account does not have an admin role.'
	String get noAdminRole => 'This account does not have an admin role.';

	/// en: 'Login failed.'
	String get loginFailed => 'Login failed.';
}

// Path: profileForm
class Translations$profileForm$en {
	Translations$profileForm$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Edit Profile'
	String get edit => 'Edit Profile';

	/// en: 'Full Name'
	String get name => 'Full Name';

	/// en: 'Email Address'
	String get email => 'Email Address';

	/// en: 'Contact Number'
	String get phone => 'Contact Number';

	/// en: 'Date of Birth'
	String get birthDate => 'Date of Birth';

	/// en: 'Gender'
	String get gender => 'Gender';

	/// en: 'Male'
	String get male => 'Male';

	/// en: 'Female'
	String get female => 'Female';

	/// en: 'Other'
	String get other => 'Other';

	/// en: 'Save Changes'
	String get save => 'Save Changes';

	/// en: 'Profile updated'
	String get saved => 'Profile updated';

	/// en: 'Tap photo to change'
	String get photo => 'Tap photo to change';

	/// en: 'Personal Information'
	String get personalInfo => 'Personal Information';
}

// Path: preferences
class Translations$preferences$en {
	Translations$preferences$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Build Version'
	String get buildVersion => 'Build Version';

	/// en: 'Unavailable'
	String get versionUnavailable => 'Unavailable';

	/// en: 'Settings'
	String get title => 'Settings';

	/// en: 'Notifications'
	String get notifications => 'Notifications';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'Logout'
	String get logout => 'Logout';

	/// en: 'Are you sure you want to logout?'
	String get logoutQuestion => 'Are you sure you want to logout?';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Account Settings'
	String get security => 'Account Settings';

	/// en: 'More Options'
	String get more => 'More Options';
}

// Path: doctorReviews
class Translations$doctorReviews$en {
	Translations$doctorReviews$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Recent Reviews'
	String get title => 'Recent Reviews';

	/// en: 'No reviews yet'
	String get empty => 'No reviews yet';

	/// en: 'Rating'
	String get rating => 'Rating';

	/// en: 'Reviews'
	String get count => 'Reviews';
}

// Path: mvp
class Translations$mvp$en {
	Translations$mvp$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'All'
	String get all => 'All';

	/// en: 'Appointments'
	String get appointments => 'Appointments';

	/// en: 'Upcoming'
	String get upcoming => 'Upcoming';

	/// en: 'Completed'
	String get completed => 'Completed';

	/// en: 'Cancelled'
	String get cancelled => 'Cancelled';

	/// en: 'Working Days'
	String get workingDays => 'Working Days';

	/// en: 'Working Hours (Riyadh)'
	String get workingHours => 'Working Hours (Riyadh)';

	/// en: 'Start Time'
	String get startTime => 'Start Time';

	/// en: 'End Time'
	String get endTime => 'End Time';

	/// en: 'Slot Duration (minutes)'
	String get slotDuration => 'Slot Duration (minutes)';

	/// en: 'Save Availability'
	String get saveAvailability => 'Save Availability';

	/// en: 'These working days repeat every week.'
	String get repeatDays => 'These working days repeat every week.';

	/// en: 'Doctor Availability'
	String get doctorAvailability => 'Doctor Availability';

	/// en: 'Manage Availability'
	String get manageAvailability => 'Manage Availability';

	/// en: 'Consultation Fee'
	String get consultationFee => 'Consultation Fee';

	/// en: 'Clinic Location'
	String get clinicLocation => 'Clinic Location';

	/// en: 'No appointments found.'
	String get noAppointments => 'No appointments found.';

	/// en: 'View Details'
	String get viewDetails => 'View Details';

	/// en: 'Cancel Appointment'
	String get cancelAppointment => 'Cancel Appointment';

	/// en: 'Cancel appointment?'
	String get cancelQuestion => 'Cancel appointment?';

	/// en: 'Keep Appointment'
	String get keepAppointment => 'Keep Appointment';

	/// en: 'Mark Completed'
	String get markCompleted => 'Mark Completed';

	/// en: 'Rate Doctor'
	String get rateDoctor => 'Rate Doctor';

	/// en: 'How was your appointment?'
	String get howWas => 'How was your appointment?';

	/// en: 'Review (optional)'
	String get optionalReview => 'Review (optional)';

	/// en: 'You can submit one review per completed appointment.'
	String get oneReview => 'You can submit one review per completed appointment.';

	/// en: 'Submit Review'
	String get submitReview => 'Submit Review';

	/// en: 'Thank you for your review.'
	String get thankYou => 'Thank you for your review.';

	/// en: 'Sort by'
	String get sortBy => 'Sort by';

	/// en: 'Popular'
	String get popular => 'Popular';

	/// en: 'Top Rated'
	String get topRated => 'Top Rated';

	/// en: 'Top Rated Doctors'
	String get topRatedDoctors => 'Top Rated Doctors';

	/// en: 'Active'
	String get active => 'Active';

	/// en: 'Inactive'
	String get inactive => 'Inactive';

	/// en: 'Review Appointment'
	String get reviewAppointment => 'Review Appointment';

	/// en: 'Confirm Booking'
	String get confirmBooking => 'Confirm Booking';

	/// en: 'Appointment Details'
	String get appointmentDetails => 'Appointment Details';

	/// en: 'Central Clinic Location'
	String get clinicField => 'Central Clinic Location';

	/// en: 'Monday'
	String get monday => 'Monday';

	/// en: 'Tuesday'
	String get tuesday => 'Tuesday';

	/// en: 'Wednesday'
	String get wednesday => 'Wednesday';

	/// en: 'Thursday'
	String get thursday => 'Thursday';

	/// en: 'Friday'
	String get friday => 'Friday';

	/// en: 'Saturday'
	String get saturday => 'Saturday';

	/// en: 'Sunday'
	String get sunday => 'Sunday';
}

// Path: commonUi
class Translations$commonUi$en {
	Translations$commonUi$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'e.g. 28.00'
	String get feeExample => 'e.g. 28.00';

	/// en: 'Add to favorites'
	String get addFavorite => 'Add to favorites';

	/// en: 'Remove from favorites'
	String get removeFavorite => 'Remove from favorites';

	/// en: 'Saving...'
	String get saving => 'Saving...';

	/// en: 'Confirming...'
	String get confirming => 'Confirming...';

	/// en: 'Loading...'
	String get loading => 'Loading...';

	/// en: 'Save Changes'
	String get saveChanges => 'Save Changes';

	/// en: 'Appointments'
	String get appointments => 'Appointments';

	/// en: 'Manage Availability'
	String get manageAvailability => 'Manage Availability';

	/// en: 'Doctor Availability'
	String get doctorAvailability => 'Doctor Availability';

	/// en: 'Working Days'
	String get workingDays => 'Working Days';

	/// en: 'Working Hours (Riyadh)'
	String get workingHours => 'Working Hours (Riyadh)';

	/// en: 'Start Time'
	String get startTime => 'Start Time';

	/// en: 'End Time'
	String get endTime => 'End Time';

	/// en: 'Slot Duration (minutes)'
	String get slotDuration => 'Slot Duration (minutes)';

	/// en: 'Save Availability'
	String get saveAvailability => 'Save Availability';

	/// en: 'Activate doctor'
	String get activateDoctor => 'Activate doctor';

	/// en: 'Deactivate doctor'
	String get deactivateDoctor => 'Deactivate doctor';

	/// en: 'Deactivate doctor?'
	String get deactivateQuestion => 'Deactivate doctor?';

	/// en: 'Deactivate'
	String get deactivate => 'Deactivate';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Active'
	String get active => 'Active';

	/// en: 'Inactive'
	String get inactive => 'Inactive';

	/// en: 'Confirm'
	String get confirm => 'Confirm';

	/// en: 'Confirm Booking'
	String get confirmBooking => 'Confirm Booking';

	/// en: 'Choose Date'
	String get chooseDate => 'Choose Date';

	/// en: 'Try Again'
	String get tryAgain => 'Try Again';

	/// en: 'English'
	String get english => 'English';

	/// en: 'العربية'
	String get arabic => 'العربية';

	/// en: 'All'
	String get all => 'All';

	/// en: 'Top Rated Doctors'
	String get topRatedDoctors => 'Top Rated Doctors';

	/// en: 'Appointment date'
	String get appointmentDate => 'Appointment date';

	/// en: 'Appointment time'
	String get appointmentTime => 'Appointment time';

	/// en: 'Consultation Fee'
	String get consultationFee => 'Consultation Fee';

	/// en: 'Add photo (optional)'
	String get addPhoto => 'Add photo (optional)';

	/// en: 'Update photo'
	String get updatePhoto => 'Update photo';

	/// en: 'Welcome back'
	String get welcomeBack => 'Welcome back';

	/// en: 'Join us to start searching'
	String get joinUs => 'Join us to start searching';

	/// en: 'Sign up failed.'
	String get signupFailed => 'Sign up failed.';

	/// en: 'Doctor added successfully.'
	String get doctorAdded => 'Doctor added successfully.';

	/// en: 'Doctor updated successfully.'
	String get doctorUpdated => 'Doctor updated successfully.';

	/// en: 'Failed to add doctor.'
	String get doctorAddFailed => 'Failed to add doctor.';

	/// en: 'Failed to update doctor.'
	String get doctorUpdateFailed => 'Failed to update doctor.';

	/// en: 'Failed to load doctors.'
	String get doctorsLoadFailed => 'Failed to load doctors.';

	/// en: 'No doctors available yet.'
	String get noDoctors => 'No doctors available yet.';

	/// en: 'Doctor availability updated.'
	String get availabilityUpdated => 'Doctor availability updated.';

	/// en: 'Select working days and valid hours and slot duration.'
	String get invalidAvailability => 'Select working days and valid hours and slot duration.';

	/// en: 'Enter a valid consultation fee (0 or greater).'
	String get invalidFee => 'Enter a valid consultation fee (0 or greater).';

	/// en: 'Please choose an image smaller than 5 MB.'
	String get photoTooLarge => 'Please choose an image smaller than 5 MB.';

	/// en: 'Please choose a JPEG, PNG or WebP image.'
	String get invalidPhoto => 'Please choose a JPEG, PNG or WebP image.';

	/// en: 'Could not save your review. Please try again or contact the clinic.'
	String get reviewSaveFailed => 'Could not save your review. Please try again or contact the clinic.';

	/// en: 'Choose 1–5 stars and keep the review under 1000 characters.'
	String get invalidReview => 'Choose 1–5 stars and keep the review under 1000 characters.';

	/// en: 'Appointment not found.'
	String get appointmentNotFound => 'Appointment not found.';

	/// en: 'You can only review your completed appointments.'
	String get completedReviewOnly => 'You can only review your completed appointments.';

	/// en: 'This appointment has already been reviewed.'
	String get alreadyReviewed => 'This appointment has already been reviewed.';

	/// en: 'Doctor not found.'
	String get doctorNotFound => 'Doctor not found.';

	/// en: 'This slot has already been booked. Choose another time.'
	String get slotTaken => 'This slot has already been booked. Choose another time.';

	/// en: 'The doctor is no longer available at this time.'
	String get doctorUnavailable => 'The doctor is no longer available at this time.';

	/// en: 'The consultation fee changed. Reopen the doctor before confirming.'
	String get feeChanged => 'The consultation fee changed. Reopen the doctor before confirming.';

	/// en: 'The clinic location has not been configured.'
	String get clinicNotConfigured => 'The clinic location has not been configured.';

	/// en: 'Failed to load clinic location.'
	String get clinicLoadFailed => 'Failed to load clinic location.';

	/// en: 'Enter the clinic location.'
	String get enterClinicLocation => 'Enter the clinic location.';

	/// en: 'Booking currency: USD · Time zone: Riyadh (UTC+3)'
	String get clinicInfo => 'Booking currency: USD · Time zone: Riyadh (UTC+3)';

	/// en: 'Cannot reopen an appointment.'
	String get cannotReopen => 'Cannot reopen an appointment.';

	/// en: 'Only upcoming appointments can be changed.'
	String get upcomingOnly => 'Only upcoming appointments can be changed.';

	/// en: 'The appointment cannot be completed before its end time.'
	String get completionTooEarly => 'The appointment cannot be completed before its end time.';

	/// en: 'Resolve upcoming bookings before changing working hours.'
	String get existingBookings => 'Resolve upcoming bookings before changing working hours.';

	/// en: 'Doctor id is required.'
	String get doctorIdRequired => 'Doctor id is required.';

	/// en: 'Sign in again.'
	String get signInAgain => 'Sign in again.';

	/// en: 'Email cannot be changed here.'
	String get emailReadOnly => 'Email cannot be changed here.';

	/// en: 'Allow notifications in your device settings first.'
	String get notificationPermission => 'Allow notifications in your device settings first.';

	/// en: 'This account is inactive.'
	String get inactiveAccount => 'This account is inactive.';

	/// en: 'This account does not have a patient role.'
	String get noPatientRole => 'This account does not have a patient role.';

	/// en: 'This account does not have an admin role.'
	String get noAdminRole => 'This account does not have an admin role.';

	/// en: 'User profile was not found.'
	String get profileNotFound => 'User profile was not found.';

	/// en: 'Unable to access booking availability. Please contact the clinic and try again.'
	String get availabilityAccessFailed => 'Unable to access booking availability. Please contact the clinic and try again.';

	/// en: 'Unable to load booking availability. Please try again.'
	String get availabilityLoadFailed => 'Unable to load booking availability. Please try again.';

	/// en: 'Unable to complete this action. Please try again.'
	String get operationFailed => 'Unable to complete this action. Please try again.';

	/// en: 'You do not have permission to perform this action.'
	String get permissionDenied => 'You do not have permission to perform this action.';

	/// en: 'Your rating: $rating/5'
	String yourRating({required Object rating}) => 'Your rating: ${rating}/5';

	/// en: '$count days enabled'
	String enabledDays({required Object count}) => '${count} days enabled';

	/// en: 'Morning $count slots'
	String morningSlots({required Object count}) => 'Morning ${count} slots';

	/// en: '$rating · $count reviews'
	String doctorRating({required Object rating, required Object count}) => '${rating} · ${count} reviews';

	/// en: 'Are you sure you want to deactivate $name?'
	String deactivateNamedDoctor({required Object name}) => 'Are you sure you want to deactivate ${name}?';

	/// en: '$name — Appointments'
	String doctorAppointments({required Object name}) => '${name} — Appointments';

	/// en: 'Consultation Fee: $amount USD'
	String feeValue({required Object amount}) => 'Consultation Fee: ${amount} USD';

	/// en: '$amount USD'
	String moneyValue({required Object amount}) => '${amount} USD';

	/// en: '$time (Riyadh)'
	String riyadhTime({required Object time}) => '${time} (Riyadh)';

	/// en: '$count stars'
	String starCount({required Object count}) => '${count} stars';

	/// en: '$count $label'
	String slotCount({required Object count, required Object label}) => '${count} ${label}';

	/// en: 'Orthopedics'
	String get specialtyOrthopedics => 'Orthopedics';

	/// en: 'Dermatology'
	String get specialtyDermatology => 'Dermatology';

	/// en: 'Pediatrics'
	String get specialtyPediatrics => 'Pediatrics';

	/// en: 'Pathology'
	String get specialtyPathology => 'Pathology';

	/// en: 'Oncology'
	String get specialtyOncology => 'Oncology';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'googleAuthErrors.providerUnavailable' => 'Google sign-in services are unavailable on this device. Check Google Play services updates, restart the device, and try again.',
			'googleAuthErrors.configuration' => 'Google sign-in is not configured correctly. Please contact support.',
			'googleAuthErrors.cancelled' => 'Google sign-in was cancelled. If you did not cancel, try again or contact support.',
			'googleAuthErrors.interrupted' => 'Google sign-in was interrupted. Please try again.',
			'googleAuthErrors.unavailable' => 'Google sign-in cannot open right now. Please try again.',
			'googleAuthErrors.failed' => 'Could not sign in with Google. Please try again.',
			'googleAuthErrors.providerDisabled' => 'This sign-in method is not enabled. Please contact support.',
			'googleAuthErrors.existingAccount' => 'An account with this email already exists using another sign-in method. Sign in using that method first.',
			'googleAuthErrors.popupBlocked' => 'Allow the sign-in pop-up in your browser and try again.',
			'googleAuthErrors.unsupportedPlatform' => 'Google sign-in is currently available on Android, iOS, macOS, and the web. It is not supported on this platform.',
			'privacyPolicy.title' => 'Privacy Policy',
			'privacyPolicy.heading' => 'Doctor Hunt Apps Privacy Policy',
			'privacyPolicy.draftNotice' => 'Demo text supplied for the screen design. This is not a finalized privacy policy.',
			'privacyPolicy.introduction' => 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words believable. It is a long established fact that reader will distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a moreIt is a long established fact that reader will distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more',
			'privacyPolicy.bulletOne' => 'The standard chunk of lorem Ipsum used since 1500s is reproduced below for those interested.',
			'privacyPolicy.bulletTwo' => 'Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum. The point of using.',
			'privacyPolicy.bulletThree' => 'Lorem Ipsum is that it has a moreIt is a long established fact that reader will distracted.',
			'privacyPolicy.bulletFour' => 'The point of using Lorem Ipsum is that it has a moreIt is a long established fact that reader will distracted.',
			'privacyPolicy.conclusion' => 'It is a long established fact that reader distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a moreIt is a long established.',
			'menu' => 'Menu',
			'closeMenu' => 'Close menu',
			'myAppointments' => 'My Appointments',
			'appName' => 'Doctor Hunt',
			'onboardingTitleOne' => 'Find Trusted Doctors',
			'onboardingDescriptionOne' => 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.',
			'onboardingTitleTwo' => 'Choose Best Doctors',
			'onboardingDescriptionTwo' => 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.',
			'onboardingTitleThree' => 'Easy Appointments',
			'onboardingDescriptionThree' => 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.',
			'next' => 'Next',
			'skip' => 'Skip',
			'getStarted' => 'Get Started',
			'chooseRoleTitle' => 'Choose your role',
			'chooseRoleDescription' => 'Select how you want to continue',
			'patient' => 'Patient',
			'patientDescription' => 'Find doctors and book appointments',
			'admin' => 'Admin',
			'adminDescription' => 'Continue',
			'continueText' => 'Continue',
			'homeGreeting' => ({required Object name}) => 'Hi ${name}!',
			'findYourDoctor' => 'Find Your Doctor',
			'searchDoctor' => 'Search...',
			'liveDoctors' => 'Live Doctors',
			'seeAll' => 'See all',
			'popularDoctors' => 'Popular Doctor',
			'categories' => 'Categories',
			'featureDoctors' => 'Feature Doctor',
			'findDoctors' => 'Find Doctors',
			'doctorDetails' => 'Doctor Details',
			'dentistSearch' => 'Dentist',
			'nextAvailable' => 'Next Available',
			'bookNow' => 'Book Now',
			'perHour' => '/hr',
			'noDoctorsFound' => 'No doctors found',
			'running' => 'Running',
			'ongoing' => 'Ongoing',
			'patients' => 'Patients',
			'services' => 'Services',
			'serviceOne' => 'Patient care should be the number one priority.',
			'serviceTwo' => 'We listen carefully and explain every treatment clearly.',
			'serviceThree' => 'Modern care supported by experienced medical staff.',
			'location' => 'Location',
			'dental' => 'Dental',
			'cardiology' => 'Cardiology',
			'ophthalmology' => 'Ophthalmology',
			'generalMedicine' => 'General',
			'home' => 'Home',
			'favorites' => 'Favorites',
			'messages' => 'Messages',
			'profile' => 'Profile',
			'selecttime' => 'SelectTime',
			'today' => 'Today',
			'noSlotsAvailable' => 'No slots available',
			'afternoon' => 'Afternoon',
			'evening' => 'Evening',
			'slots' => 'slots',
			'tomorrow' => 'Tomorrow',
			'slotsAvailable' => 'slots available',
			'nextAvailabilityOn' => 'Next availability on',
			'orText' => 'OR',
			'contactClinic' => 'Contact Clinic',
			'bookAppointment' => 'Confirm',
			'thankYou' => 'Thank You !',
			'appointmentSuccessful' => 'Your Appointment Successful',
			'done' => 'Done',
			'editAppointment' => 'Edit your appointment',
			'appointmentConfirmation' => ({required Object doctorName, required Object date, required Object time}) => 'You booked an appointment with ${doctorName} on ${date}, at ${time}',
			'noFavoriteDoctors' => 'No favorite doctors yet',
			'email' => 'Email',
			'enterEmail' => 'Enter your email',
			'password' => 'Password',
			'enterPassword' => 'Enter your password',
			'welcome' => 'Welcome Back',
			'loginAdmin' => 'Login to your admin account',
			'botnlogin' => 'Login',
			'loginTitle' => 'Login to your account',
			'adminLoginTitle' => 'Admin Login',
			'forgotPassword' => 'Forgot Password?',
			'orDivider' => 'OR',
			'signInWithGoogle' => 'Sign in with Google',
			'doctor' => 'Doctors',
			'searchDoctors' => 'Search doctors',
			'totalDoctors' => 'Total Doctors',
			'activeDoctors' => 'Active Doctors',
			'active' => 'Active',
			'inactive' => 'Inactive',
			'addDoctor' => 'Add Doctor',
			'createDoctor' => 'Create Doctor',
			'doctorName' => 'Doctor Name',
			'enterDoctorName' => 'Enter doctor name',
			'doctorImage' => 'Doctor Image',
			'uploadDoctorImage' => 'Upload doctor image',
			'supportedImageFormats' => 'PNG or JPG up to 5 MB',
			'editDoctor' => 'Edit Doctor',
			'deleteDoctor' => 'Delete Doctor',
			'cancel' => 'Cancel',
			'save' => 'Save',
			'doctorCreatedSuccessfully' => 'Doctor created successfully',
			'doctorUpdatedSuccessfully' => 'Doctor updated successfully',
			'doctorDeletedSuccessfully' => 'Doctor deleted successfully',
			'failedToCreateDoctor' => 'Failed to create doctor',
			'noDoctorsAvailable' => 'No doctors available',
			'specialization' => 'Specialization',
			'selectSpecialization' => 'Select specialization',
			'doctorNameRequired' => 'Doctor name is required',
			'specializationRequired' => 'Specialization is required',
			'failedToLoadDoctors' => 'Failed to load Doctor',
			'auth.login' => 'Login',
			'auth.email' => 'Email Address',
			'auth.password' => 'Password',
			'auth.loginSuccess' => 'Logged in successfully',
			'auth.loginError' => 'An error occurred during login',
			'roles.chooseRole' => 'Choose Your Role',
			'roles.patient' => 'Patient',
			'roles.admin' => 'Admin',
			'common.cancel' => 'Cancel',
			'common.confirm' => 'Confirm',
			'doctors.notFound' => 'Doctor not found',
			'dontHaveAccount' => 'Don\'t have an account?',
			'signUp' => 'Sign Up',
			'signUpTitle' => 'Create Account',
			'fullName' => 'Full Name',
			'enterFullName' => 'Enter your full name',
			'alreadyHaveAccount' => 'Already have an account?',
			'errors.noPatientRole' => 'This account does not have a patient role.',
			'errors.noAdminRole' => 'This account does not have an admin role.',
			'errors.loginFailed' => 'Login failed.',
			'resetPasswordTitle' => 'Reset Password',
			'resetPasswordDescription' => 'Enter your email address to receive a password reset link.',
			'sendResetLink' => 'Send Reset Link',
			'resetEmailSent' => 'If an account exists for this email, you will receive a password reset link.',
			'resetPasswordFailed' => 'Unable to send the password reset email. Please try again.',
			'changePasswordTitle' => 'Change Password',
			'currentPassword' => 'Current Password',
			'newPassword' => 'New Password',
			'confirmNewPassword' => 'Confirm New Password',
			'passwordChanged' => 'Your password has been changed successfully.',
			'changePasswordFailed' => 'Unable to change your password. Please try again.',
			'passwordsDoNotMatch' => 'The passwords do not match.',
			'passwordTooShort' => 'The password must be at least 6 characters long.',
			'requiredField' => 'This field is required',
			'invalidEmail' => 'Please enter a valid email address',
			'retry' => 'Try Again',
			'nouser' => 'Authentication returned no user.',
			'noAuthenticatedUser' => 'No authenticated user.',
			'noEmailAddress' => 'The current account does not have an email address.',
			'tooManyRequests' => 'Too many attempts. Please try again later.',
			'networkError' => 'A network error occurred. Check your connection and try again.',
			'wrongCurrentPassword' => 'The current password is incorrect.',
			'requiresRecentLogin' => 'For security, sign in again before changing your password.',
			'changePasswordDescription' => 'Enter your current password and choose a new password.',
			'newPasswordMustBeDifferent' => 'Your new password must be different from your current password.',
			'profileForm.edit' => 'Edit Profile',
			'profileForm.name' => 'Full Name',
			'profileForm.email' => 'Email Address',
			'profileForm.phone' => 'Contact Number',
			'profileForm.birthDate' => 'Date of Birth',
			'profileForm.gender' => 'Gender',
			'profileForm.male' => 'Male',
			'profileForm.female' => 'Female',
			'profileForm.other' => 'Other',
			'profileForm.save' => 'Save Changes',
			'profileForm.saved' => 'Profile updated',
			'profileForm.photo' => 'Tap photo to change',
			'profileForm.personalInfo' => 'Personal Information',
			'preferences.buildVersion' => 'Build Version',
			'preferences.versionUnavailable' => 'Unavailable',
			'preferences.title' => 'Settings',
			'preferences.notifications' => 'Notifications',
			'preferences.language' => 'Language',
			'preferences.logout' => 'Logout',
			'preferences.logoutQuestion' => 'Are you sure you want to logout?',
			'preferences.cancel' => 'Cancel',
			'preferences.security' => 'Account Settings',
			'preferences.more' => 'More Options',
			'doctorReviews.title' => 'Recent Reviews',
			'doctorReviews.empty' => 'No reviews yet',
			'doctorReviews.rating' => 'Rating',
			'doctorReviews.count' => 'Reviews',
			'mvp.all' => 'All',
			'mvp.appointments' => 'Appointments',
			'mvp.upcoming' => 'Upcoming',
			'mvp.completed' => 'Completed',
			'mvp.cancelled' => 'Cancelled',
			'mvp.workingDays' => 'Working Days',
			'mvp.workingHours' => 'Working Hours (Riyadh)',
			'mvp.startTime' => 'Start Time',
			'mvp.endTime' => 'End Time',
			'mvp.slotDuration' => 'Slot Duration (minutes)',
			'mvp.saveAvailability' => 'Save Availability',
			'mvp.repeatDays' => 'These working days repeat every week.',
			'mvp.doctorAvailability' => 'Doctor Availability',
			'mvp.manageAvailability' => 'Manage Availability',
			'mvp.consultationFee' => 'Consultation Fee',
			'mvp.clinicLocation' => 'Clinic Location',
			'mvp.noAppointments' => 'No appointments found.',
			'mvp.viewDetails' => 'View Details',
			'mvp.cancelAppointment' => 'Cancel Appointment',
			'mvp.cancelQuestion' => 'Cancel appointment?',
			'mvp.keepAppointment' => 'Keep Appointment',
			'mvp.markCompleted' => 'Mark Completed',
			'mvp.rateDoctor' => 'Rate Doctor',
			'mvp.howWas' => 'How was your appointment?',
			'mvp.optionalReview' => 'Review (optional)',
			'mvp.oneReview' => 'You can submit one review per completed appointment.',
			'mvp.submitReview' => 'Submit Review',
			'mvp.thankYou' => 'Thank you for your review.',
			'mvp.sortBy' => 'Sort by',
			'mvp.popular' => 'Popular',
			'mvp.topRated' => 'Top Rated',
			'mvp.topRatedDoctors' => 'Top Rated Doctors',
			'mvp.active' => 'Active',
			'mvp.inactive' => 'Inactive',
			'mvp.reviewAppointment' => 'Review Appointment',
			'mvp.confirmBooking' => 'Confirm Booking',
			'mvp.appointmentDetails' => 'Appointment Details',
			'mvp.clinicField' => 'Central Clinic Location',
			'mvp.monday' => 'Monday',
			'mvp.tuesday' => 'Tuesday',
			'mvp.wednesday' => 'Wednesday',
			'mvp.thursday' => 'Thursday',
			'mvp.friday' => 'Friday',
			'mvp.saturday' => 'Saturday',
			'mvp.sunday' => 'Sunday',
			'commonUi.feeExample' => 'e.g. 28.00',
			'commonUi.addFavorite' => 'Add to favorites',
			'commonUi.removeFavorite' => 'Remove from favorites',
			'commonUi.saving' => 'Saving...',
			'commonUi.confirming' => 'Confirming...',
			'commonUi.loading' => 'Loading...',
			'commonUi.saveChanges' => 'Save Changes',
			'commonUi.appointments' => 'Appointments',
			'commonUi.manageAvailability' => 'Manage Availability',
			'commonUi.doctorAvailability' => 'Doctor Availability',
			'commonUi.workingDays' => 'Working Days',
			'commonUi.workingHours' => 'Working Hours (Riyadh)',
			'commonUi.startTime' => 'Start Time',
			'commonUi.endTime' => 'End Time',
			'commonUi.slotDuration' => 'Slot Duration (minutes)',
			'commonUi.saveAvailability' => 'Save Availability',
			'commonUi.activateDoctor' => 'Activate doctor',
			'commonUi.deactivateDoctor' => 'Deactivate doctor',
			'commonUi.deactivateQuestion' => 'Deactivate doctor?',
			'commonUi.deactivate' => 'Deactivate',
			'commonUi.cancel' => 'Cancel',
			'commonUi.active' => 'Active',
			'commonUi.inactive' => 'Inactive',
			'commonUi.confirm' => 'Confirm',
			'commonUi.confirmBooking' => 'Confirm Booking',
			'commonUi.chooseDate' => 'Choose Date',
			'commonUi.tryAgain' => 'Try Again',
			'commonUi.english' => 'English',
			'commonUi.arabic' => 'العربية',
			'commonUi.all' => 'All',
			'commonUi.topRatedDoctors' => 'Top Rated Doctors',
			'commonUi.appointmentDate' => 'Appointment date',
			'commonUi.appointmentTime' => 'Appointment time',
			'commonUi.consultationFee' => 'Consultation Fee',
			'commonUi.addPhoto' => 'Add photo (optional)',
			'commonUi.updatePhoto' => 'Update photo',
			'commonUi.welcomeBack' => 'Welcome back',
			'commonUi.joinUs' => 'Join us to start searching',
			'commonUi.signupFailed' => 'Sign up failed.',
			'commonUi.doctorAdded' => 'Doctor added successfully.',
			'commonUi.doctorUpdated' => 'Doctor updated successfully.',
			'commonUi.doctorAddFailed' => 'Failed to add doctor.',
			'commonUi.doctorUpdateFailed' => 'Failed to update doctor.',
			'commonUi.doctorsLoadFailed' => 'Failed to load doctors.',
			'commonUi.noDoctors' => 'No doctors available yet.',
			'commonUi.availabilityUpdated' => 'Doctor availability updated.',
			'commonUi.invalidAvailability' => 'Select working days and valid hours and slot duration.',
			'commonUi.invalidFee' => 'Enter a valid consultation fee (0 or greater).',
			'commonUi.photoTooLarge' => 'Please choose an image smaller than 5 MB.',
			'commonUi.invalidPhoto' => 'Please choose a JPEG, PNG or WebP image.',
			'commonUi.reviewSaveFailed' => 'Could not save your review. Please try again or contact the clinic.',
			'commonUi.invalidReview' => 'Choose 1–5 stars and keep the review under 1000 characters.',
			'commonUi.appointmentNotFound' => 'Appointment not found.',
			'commonUi.completedReviewOnly' => 'You can only review your completed appointments.',
			'commonUi.alreadyReviewed' => 'This appointment has already been reviewed.',
			'commonUi.doctorNotFound' => 'Doctor not found.',
			'commonUi.slotTaken' => 'This slot has already been booked. Choose another time.',
			'commonUi.doctorUnavailable' => 'The doctor is no longer available at this time.',
			'commonUi.feeChanged' => 'The consultation fee changed. Reopen the doctor before confirming.',
			'commonUi.clinicNotConfigured' => 'The clinic location has not been configured.',
			'commonUi.clinicLoadFailed' => 'Failed to load clinic location.',
			'commonUi.enterClinicLocation' => 'Enter the clinic location.',
			'commonUi.clinicInfo' => 'Booking currency: USD · Time zone: Riyadh (UTC+3)',
			'commonUi.cannotReopen' => 'Cannot reopen an appointment.',
			'commonUi.upcomingOnly' => 'Only upcoming appointments can be changed.',
			'commonUi.completionTooEarly' => 'The appointment cannot be completed before its end time.',
			'commonUi.existingBookings' => 'Resolve upcoming bookings before changing working hours.',
			'commonUi.doctorIdRequired' => 'Doctor id is required.',
			'commonUi.signInAgain' => 'Sign in again.',
			'commonUi.emailReadOnly' => 'Email cannot be changed here.',
			'commonUi.notificationPermission' => 'Allow notifications in your device settings first.',
			'commonUi.inactiveAccount' => 'This account is inactive.',
			'commonUi.noPatientRole' => 'This account does not have a patient role.',
			'commonUi.noAdminRole' => 'This account does not have an admin role.',
			'commonUi.profileNotFound' => 'User profile was not found.',
			'commonUi.availabilityAccessFailed' => 'Unable to access booking availability. Please contact the clinic and try again.',
			'commonUi.availabilityLoadFailed' => 'Unable to load booking availability. Please try again.',
			'commonUi.operationFailed' => 'Unable to complete this action. Please try again.',
			'commonUi.permissionDenied' => 'You do not have permission to perform this action.',
			'commonUi.yourRating' => ({required Object rating}) => 'Your rating: ${rating}/5',
			'commonUi.enabledDays' => ({required Object count}) => '${count} days enabled',
			'commonUi.morningSlots' => ({required Object count}) => 'Morning ${count} slots',
			'commonUi.doctorRating' => ({required Object rating, required Object count}) => '${rating} · ${count} reviews',
			'commonUi.deactivateNamedDoctor' => ({required Object name}) => 'Are you sure you want to deactivate ${name}?',
			'commonUi.doctorAppointments' => ({required Object name}) => '${name} — Appointments',
			'commonUi.feeValue' => ({required Object amount}) => 'Consultation Fee: ${amount} USD',
			'commonUi.moneyValue' => ({required Object amount}) => '${amount} USD',
			'commonUi.riyadhTime' => ({required Object time}) => '${time} (Riyadh)',
			'commonUi.starCount' => ({required Object count}) => '${count} stars',
			'commonUi.slotCount' => ({required Object count, required Object label}) => '${count} ${label}',
			'commonUi.specialtyOrthopedics' => 'Orthopedics',
			'commonUi.specialtyDermatology' => 'Dermatology',
			'commonUi.specialtyPediatrics' => 'Pediatrics',
			'commonUi.specialtyPathology' => 'Pathology',
			'commonUi.specialtyOncology' => 'Oncology',
			_ => null,
		};
	}
}
