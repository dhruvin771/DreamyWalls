import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheUtil {
  static Future<void> checkLastCacheClear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int lastClearedTimestamp = prefs.getInt('last_cleared_timestamp') ?? 0;
    int currentTimestamp = DateTime.now().millisecondsSinceEpoch;
    int sevenDaysInMillis = 7 * 24 * 60 * 60 * 1000;

    if (currentTimestamp - lastClearedTimestamp > sevenDaysInMillis) {
      await clearCache();
      prefs.setInt('last_cleared_timestamp', currentTimestamp);
    }
  }

  static Future<void> clearCache() async {
    await DefaultCacheManager().emptyCache();
  }
}
