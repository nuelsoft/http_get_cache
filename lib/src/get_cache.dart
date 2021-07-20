import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'util.dart';

class GetCache {
  final List<String> blackList;

  static late GetStorage _store;

  static String _namespace = "get_storage";

  static GetCache? _instance;

  static GetCache get instance {
    if (_instance == null)
      throw "call GetCache.initialize() to initialize GetCache first";
    return _instance!;
  }

  static Future<GetCache> initialize({List<String> blackList = const []}) async {
    await GetStorage.init(_namespace);
    _store = GetStorage(_namespace);
    _instance = GetCache._internal();

    return _instance!;
  }

  GetCache._internal({List<String> blackList = const []})
      : blackList = blackList;

  Future<http.Response> get(Uri uri,
      {Map<String, String>? headers, bool useCache = true}) async {
    String path = "${uri.path}?${uri.query}";

    try {
      final response = await http.get(uri, headers: headers);
      if (useCache) _store.write(path, response.json);
      return response;
    } catch (e) {
      if (useCache && !blackList.contains(uri.path)) {
        Map<String, dynamic>? cache = _store.read<Map<String, dynamic>>(path);
        if (cache != null) return cache.response;
      }
      throw e;
    }
  }
}

