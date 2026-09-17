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
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations

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

	/// en: 'Hi Mohammed!'
	String get homeGreeting => 'Hi Mohammed!';

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

	/// en: 'noFavoriteDoctors'
	String get noFavoriteDoctors => 'noFavoriteDoctors';

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

	/// en: 'Doctors'
	String get doctors => 'Doctors';

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
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
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
			'homeGreeting' => 'Hi Mohammed!',
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
			'noFavoriteDoctors' => 'noFavoriteDoctors',
			'email' => 'Email',
			'enterEmail' => 'Enter your email',
			'password' => 'Password',
			'enterPassword' => 'Enter your password',
			'welcome' => 'Welcome Back',
			'loginAdmin' => 'Login to your admin account',
			'botnlogin' => 'Login',
			'doctors' => 'Doctors',
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
			_ => null,
		};
	}
}
