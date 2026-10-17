import 'package:firebase_core/firebase_core.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:google_sign_in/google_sign_in.dart';

String localizedError(Object error) {
  var appStrings = t;
  if (error is GoogleSignInException) {
    return switch (error.code) {
      GoogleSignInExceptionCode.clientConfigurationError =>
        appStrings.googleAuthErrors.configuration,
      GoogleSignInExceptionCode.providerConfigurationError =>
        appStrings.googleAuthErrors.providerUnavailable,
      GoogleSignInExceptionCode.canceled =>
        appStrings.googleAuthErrors.cancelled,
      GoogleSignInExceptionCode.interrupted =>
        appStrings.googleAuthErrors.interrupted,
      GoogleSignInExceptionCode.uiUnavailable =>
        appStrings.googleAuthErrors.unavailable,
      _ => appStrings.googleAuthErrors.failed,
    };
  }
  if (error is FirebaseException) {
    return switch (error.code) {
      'permission-denied' ||
      'unauthorized' => appStrings.commonUi.permissionDenied,
      'network-request-failed' ||
      'unavailable' ||
      'deadline-exceeded' => appStrings.networkError,
      'requires-recent-login' => appStrings.requiresRecentLogin,
      'too-many-requests' => appStrings.tooManyRequests,
      'invalid-email' => appStrings.invalidEmail,
      'user-not-found' ||
      'wrong-password' ||
      'invalid-credential' => appStrings.errors.loginFailed,
      'weak-password' => appStrings.passwordTooShort,
      'operation-not-allowed' => appStrings.googleAuthErrors.providerDisabled,
      'account-exists-with-different-credential' =>
        appStrings.googleAuthErrors.existingAccount,
      'popup-closed-by-user' ||
      'cancelled-popup-request' => appStrings.googleAuthErrors.cancelled,
      'popup-blocked' => appStrings.googleAuthErrors.popupBlocked,
      'unauthorized-domain' ||
      'invalid-oauth-client-id' => appStrings.googleAuthErrors.configuration,
      _ => appStrings.commonUi.operationFailed,
    };
  }
  if (error is StateError) return error.message.toString();
  if (error is ArgumentError && error.message != null) {
    return error.message.toString();
  }
  return appStrings.commonUi.operationFailed;
}
