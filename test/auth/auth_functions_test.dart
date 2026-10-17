import 'package:doctor_hunt/apps/features/shared/auth/data/datasources/auth_firebase_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  late MockFirebaseAuth firebaseAuth;
  late MockUser user;
  late MockUserCredential userCredential;
  late AuthFirebaseDataSourceImpl auth;

  const email = 'patient@example.com';
  const password = 'oldPassword123';
  const newPassword = 'newPassword456';

  setUpAll(() {
    registerFallbackValue(
      EmailAuthProvider.credential(email: email, password: password),
    );
  });

  setUp(() {
    firebaseAuth = MockFirebaseAuth();
    user = MockUser();
    userCredential = MockUserCredential();
    auth = AuthFirebaseDataSourceImpl(auth: firebaseAuth);
  });

  group('تسجيل الدخول: signIn', () {
    test('يعيد المستخدم عند صحة بيانات الدخول', () async {
      when(() => userCredential.user).thenReturn(user);
      when(
        () => firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        ),
      ).thenAnswer((_) async => userCredential);

      final result = await auth.signIn(email: email, password: password);

      expect(result, same(user));
    });

    test('يمرّر خطأ Firebase عند وجود بيانات دخول غير صحيحة', () async {
      final error = FirebaseAuthException(code: 'invalid-credential');
      when(
        () => firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: 'wrongPassword',
        ),
      ).thenThrow(error);

      await expectLater(
        auth.signIn(email: email, password: 'wrongPassword'),
        throwsA(same(error)),
      );
    });
  });

  group('نسيان كلمة المرور: sendPasswordResetEmail', () {
    test('يطلب إرسال رابط الاستعادة ويحذف مسافات البريد الزائدة', () async {
      when(
        () => firebaseAuth.sendPasswordResetEmail(email: email),
      ).thenAnswer((_) async {});

      await auth.sendPasswordResetEmail(email: ' $email ');

      verify(() => firebaseAuth.sendPasswordResetEmail(email: email)).called(1);
    });

    test('يمرّر خطأ Firebase عندما يكون البريد غير صالح', () async {
      final error = FirebaseAuthException(code: 'invalid-email');
      when(
        () => firebaseAuth.sendPasswordResetEmail(email: 'invalid-email'),
      ).thenAnswer((_) async {
        throw error;
      });

      await expectLater(
        auth.sendPasswordResetEmail(email: 'invalid-email'),
        throwsA(same(error)),
      );
    });
  });

  group('تغيير كلمة المرور: changePassword', () {
    test('يتحقق من كلمة المرور الحالية ثم يحفظ الجديدة', () async {
      when(() => firebaseAuth.currentUser).thenReturn(user);
      when(() => user.email).thenReturn(email);
      when(
        () => user.reauthenticateWithCredential(any()),
      ).thenAnswer((_) async => userCredential);
      when(() => user.updatePassword(newPassword)).thenAnswer((_) async {});

      await auth.changePassword(
        currentPassword: password,
        newPassword: newPassword,
      );

      final calls = verifyInOrder([
        () => user.reauthenticateWithCredential(captureAny()),
        () => user.updatePassword(newPassword),
      ]);

      final credential = calls.first.captured.single as EmailAuthCredential;
      expect(credential.email, email);
      expect(credential.password, password);
    });

    test('لا يغيّر كلمة المرور إذا فشل التحقق من الكلمة الحالية', () async {
      final error = FirebaseAuthException(code: 'wrong-password');
      when(() => firebaseAuth.currentUser).thenReturn(user);
      when(() => user.email).thenReturn(email);
      when(() => user.reauthenticateWithCredential(any())).thenThrow(error);

      await expectLater(
        auth.changePassword(
          currentPassword: 'wrongPassword',
          newPassword: newPassword,
        ),
        throwsA(same(error)),
      );

      verifyNever(() => user.updatePassword(newPassword));
    });

    test('يرفض التغيير عندما لا يوجد مستخدم مسجل الدخول', () async {
      when(() => firebaseAuth.currentUser).thenReturn(null);

      await expectLater(
        auth.changePassword(
          currentPassword: password,
          newPassword: newPassword,
        ),
        throwsA(isA<StateError>()),
      );

      verifyNever(() => user.updatePassword(newPassword));
    });
  });
}
