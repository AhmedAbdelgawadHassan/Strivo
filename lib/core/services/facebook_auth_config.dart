
/// Facebook / Meta credentials.
class FacebookAuthConfig {
  static const String appId = '1162332389521483';

  static const String clientToken =
      '6ac498dd5f3f0db9e4d19fdb7dbc53c6';

  static bool get isConfigured =>
      appId.isNotEmpty &&
      appId != 'YOUR_FACEBOOK_APP_ID' &&
      clientToken.isNotEmpty &&
      clientToken != 'YOUR_FACEBOOK_CLIENT_TOKEN';
}
