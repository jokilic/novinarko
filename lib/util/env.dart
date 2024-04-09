import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'FEEDSEARCH_URL', obfuscate: true)
  static final String feedSearchUrl = _Env.feedSearchUrl;

  @EnviedField(varName: 'GOOGLE_SEARCH_URL', obfuscate: true)
  static final String googleSearchUrl = _Env.googleSearchUrl;

  @EnviedField(varName: 'GOOGLE_SEARCH_API_KEY', obfuscate: true)
  static final String googleSearchApiKey = _Env.googleSearchApiKey;

  @EnviedField(varName: 'PROGRAMMABLE_SEARCH_ENGINE_ID', obfuscate: true)
  static final String programmableSearchEngineId = _Env.programmableSearchEngineId;

  @EnviedField(varName: 'SENTRY_DSN', obfuscate: true)
  static final String sentryDsn = _Env.sentryDsn;
}
