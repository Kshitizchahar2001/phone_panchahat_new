// ignore_for_file: prefer_final_fields

import 'dart:async';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:online_panchayat_flutter/localCognitoUser.dart';

class UserService {
  CognitoUserPool _userPool;
  CognitoUser _cognitoUser;
  CognitoUserSession _session;
  UserService(this._userPool);
  CognitoCredentials credentials;

  /// Initiate user session from local storage if present
  Future<bool> init() async {
    _cognitoUser = await _userPool.getCurrentUser();
    if (_cognitoUser == null) {
      return false;
    }
    _session = await _cognitoUser.getSession();
    return _session.isValid();
  }

  /// Get existing user from session with his/her attributes
  Future<LocalCognitoUser> getCurrentUser() async {
    if (_cognitoUser == null || _session == null) {
      return null;
    }
    if (!_session.isValid()) {
      return null;
    }
    final attributes = await _cognitoUser.getUserAttributes();
    if (attributes == null) {
      return null;
    }
    final user = LocalCognitoUser.fromUserAttributes(attributes);
    user.hasAccess = true;
    return user;
  }

  /// Retrieve user credentials -- for use with other AWS services
  // Future<CognitoCredentials> getCredentials() async {
  //   if (_cognitoUser == null || _session == null) {
  //     return null;
  //   }

  //   credentials = CognitoCredentials(IdentityPoolId, userPool);
  //   await credentials.getAwsCredentials(_session.getIdToken().getJwtToken());
  //   return credentials;
  // }

  /// Login user
  Future<LocalCognitoUser> login(String username, String password) async {
    _cognitoUser = CognitoUser(username, _userPool, storage: _userPool.storage);

    final authDetails = AuthenticationDetails(
      username: username,
      password: password,
    );

    bool isConfirmed;
    try {
      _session = await _cognitoUser.authenticateUser(authDetails);
      isConfirmed = true;
    } on CognitoClientException catch (e, s) {
      if (e.code == 'UserNotConfirmedException') {
        isConfirmed = false;
        FirebaseCrashlytics.instance.recordError(e, s);
      } else {
        FirebaseCrashlytics.instance.recordError(e, s);
        rethrow;
      }
    }

    if (!_session.isValid()) {
      return null;
    }

    final attributes = await _cognitoUser.getUserAttributes();
    final user = LocalCognitoUser.fromUserAttributes(attributes);
    user.confirmed = isConfirmed;
    user.hasAccess = true;

    return user;
  }

  /// Confirm user's account with confirmation code sent to username
  Future<bool> confirmAccount(String username, String confirmationCode) async {
    _cognitoUser = CognitoUser(username, _userPool, storage: _userPool.storage);

    return await _cognitoUser.confirmRegistration(confirmationCode);
  }

  /// Resend confirmation code to user's username
  Future<void> resendConfirmationCode(String username) async {
    _cognitoUser = CognitoUser(username, _userPool, storage: _userPool.storage);
    await _cognitoUser.resendConfirmationCode();
  }

  /// Check if user's current session is valid
  Future<bool> checkAuthenticated() async {
    if (_cognitoUser == null || _session == null) {
      return false;
    }
    return _session.isValid();
  }

  /// Sign upuser
  Future<LocalCognitoUser> signUp(
      String username, String password, String name) async {
    CognitoUserPoolData data;
    final userAttributes = [
      AttributeArg(name: 'name', value: name),
    ];
    data = await _userPool.signUp(username, password,
        userAttributes: userAttributes);

    final user = LocalCognitoUser();
    user.username = username;
    user.name = name;
    user.confirmed = data.userConfirmed;

    return user;
  }

  Future<void> signOut() async {
    if (credentials != null) {
      await credentials.resetAwsCredentials();
    }
    if (_cognitoUser != null) {
      return _cognitoUser.signOut();
    }
  }
}
