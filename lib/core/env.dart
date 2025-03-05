import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static final Env _instance = Env._internal();
  Env._internal();

  static Future<Env> load(
      {String fileName = '.env',
      Parser parser = const Parser(),
      Map<String, String> mergeWith = const {}}) async {
    await dotenv.load(fileName: fileName, parser: parser, mergeWith: mergeWith);
    return _instance;
  }

  static String get mapsApiKey => dotenv.env['MAPS_API_KEY'] ?? '';
  static String get unleashInstanceId =>
      dotenv.env['UNLEASH_INSTANCE_ID'] ?? '';
  static String get unleashApi => dotenv.env['UNLEASH_API_KEY'] ?? '';
  static String get unleashApiToken => dotenv.env['UNLEASH_API_TOKEN'] ?? '';

  static String get api => dotenv.env['API_URL'] ?? '';
  static String get socketUri => dotenv.env['SOCKET_URL'] ?? '';
  static String get urlBucket => dotenv.env['BUCKET_URL'] ?? '';

  static String get environment => dotenv.env['ENVIRONMENT'] ?? '';
  static bool get bannerEnvironment =>
      dotenv.env['BANNER_ENVIRONMENT']?.contains("true") == true;
  static String get releaseDate => dotenv.env['RELEASE_DATE'] ?? '';
}
