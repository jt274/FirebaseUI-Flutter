// Copyright 2022, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:firebase_core/firebase_core.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'dart:async';

class TestMaterialApp extends StatelessWidget {
  final Widget child;

  const TestMaterialApp({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }
}

class MockCredential extends Mock implements fba.UserCredential {}

class MockUserInfo extends Mock implements fba.UserInfo {
  @override
  final String providerId;

  MockUserInfo({required this.providerId});
}

class MockUser extends Mock implements fba.User {
  @override
  final List<fba.UserInfo> providerData;

  MockUser({this.providerData = const []});

  @override
  Future<fba.UserCredential> linkWithCredential(
    fba.AuthCredential? credential,
  ) async {
    return super.noSuchMethod(
      Invocation.method(
        #linkWithCredential,
        [credential],
      ),
      returnValue: MockCredential(),
      returnValueForMissingStub: MockCredential(),
    );
  }
}

class MockUriStream extends Mock implements Stream<Uri> {
  static final StreamController<Uri> _controller =
      StreamController<Uri>.broadcast();

  @override
  StreamSubscription<Uri> listen(
    void Function(Uri)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return _controller.stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  static void addLink(Uri uri) {
    _controller.add(uri);
  }

  static void addError(Object error) {
    _controller.addError(error);
  }

  static void close() {
    _controller.close();
  }
}

class MockAppLinks extends Mock implements AppLinks {
  static final _uriStream = MockUriStream();

  @override
  Stream<Uri> get uriLinkStream => _uriStream;

  @override
  Future<Uri?> getInitialLink() async {
    return super.noSuchMethod(
      Invocation.method(#getInitialLink, []),
      returnValue: null,
      returnValueForMissingStub: null,
    );
  }
}

class MockApp extends Mock implements FirebaseApp {}

class MockAuth extends Mock implements fba.FirebaseAuth {
  MockUser? user;

  @override
  fba.User? get currentUser => user;

  @override
  FirebaseApp get app => MockApp();

  List<FirebaseApp> get apps => [app];

  @override
  Future<fba.UserCredential> signInWithCredential(
    fba.AuthCredential? credential,
  ) async {
    return super.noSuchMethod(
      Invocation.method(
        #signInWithCredential,
        [credential],
      ),
      returnValue: MockCredential(),
      returnValueForMissingStub: MockCredential(),
    );
  }

  @override
  Future<fba.UserCredential> createUserWithEmailAndPassword({
    String? email,
    String? password,
  }) async {
    return super.noSuchMethod(
      Invocation.method(#createUserWithEmailAndPassword, null, {
        #email: email,
        #password: password,
      }),
      returnValue: MockCredential(),
      returnValueForMissingStub: MockCredential(),
    );
  }

  @override
  Future<void> sendSignInLinkToEmail({
    required String? email,
    required fba.ActionCodeSettings? actionCodeSettings,
  }) async {
    return super.noSuchMethod(
      Invocation.method(
        #sendSignInLinkToEmail,
        null,
        {
          #email: email,
          #actionCodeSettings: actionCodeSettings,
        },
      ),
      returnValueForMissingStub: null,
    );
  }

  @override
  bool isSignInWithEmailLink(String? emailLink) {
    return super.noSuchMethod(
      Invocation.method(
        #isSignInWithEmailLink,
        [emailLink],
      ),
      returnValue: true,
      returnValueForMissingStub: true,
    );
  }

  @override
  Future<fba.UserCredential> signInWithEmailLink({
    required String? email,
    required String? emailLink,
  }) async {
    return super.noSuchMethod(
      Invocation.method(
        #signInWithEmailLink,
        null,
        {
          #email: email,
          #emailLink: emailLink,
        },
      ),
      returnValue: MockCredential(),
      returnValueForMissingStub: MockCredential(),
    );
  }

  @override
  Future<List<String>> fetchSignInMethodsForEmail(String? email) async {
    return super.noSuchMethod(
      Invocation.method(
        #fetchSignInMethodsForEmail,
        [email],
      ),
      returnValue: <String>['phone'],
      returnValueForMissingStub: <String>['phone'],
    );
  }

  @override
  Future<void> verifyPhoneNumber({
    String? phoneNumber,
    fba.PhoneMultiFactorInfo? multiFactorInfo,
    fba.PhoneVerificationCompleted? verificationCompleted,
    fba.PhoneVerificationFailed? verificationFailed,
    fba.PhoneCodeSent? codeSent,
    fba.PhoneCodeAutoRetrievalTimeout? codeAutoRetrievalTimeout,
    String? autoRetrievedSmsCodeForTesting,
    Duration timeout = const Duration(seconds: 30),
    int? forceResendingToken,
    fba.MultiFactorSession? multiFactorSession,
  }) async {
    super.noSuchMethod(
      Invocation.method(
        #verifyPhoneNumber,
        null,
        {
          #phoneNumber: phoneNumber,
          #verificationCompleted: verificationCompleted,
          #verificationFailed: verificationFailed,
          #codeSent: codeSent,
          #codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
          #autoRetrievedSmsCodeForTesting: autoRetrievedSmsCodeForTesting,
          #timeout: timeout,
          #forceResendingToken: forceResendingToken,
        },
      ),
    );
  }
}

class TestException implements Exception {}
