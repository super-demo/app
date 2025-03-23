import 'package:app/core/services/api.dart';
import 'package:app/features/services/data/models/mini_app_model.dart';

abstract class MiniAppRepository {
  Future<List<MiniAppModel>> getSiteMiniAppList(siteId);
}

class MiniAppRepositoryImpl implements MiniAppRepository {
  final ApiService apiService;

  MiniAppRepositoryImpl({required this.apiService});

  @override
  Future<List<MiniAppModel>> getSiteMiniAppList(siteId) async {
    try {
      final response = await apiService.get('site-mini-apps/list/$siteId');

      if (response['data'] != null && response['data'] is List) {
        return (response['data'] as List)
            .map((item) => MiniAppModel.fromJson(item))
            .toList();
      }

      return [];
    } catch (e) {
      print('Error fetching mini app list: $e');
      return [];
    }
  }
}
