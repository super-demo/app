import 'package:app/core/services/api.dart';
import 'package:app/features/workspace/data/models/workspace_model.dart';

abstract class WorkspaceRepository {
  Future<List<WorkspaceModel>> getUserWorkspaces(parentSiteId);
}

class WorkspaceRepositoryImpl implements WorkspaceRepository {
  final ApiService apiService;

  WorkspaceRepositoryImpl({required this.apiService});

  @override
  Future<List<WorkspaceModel>> getUserWorkspaces(parentSiteId) async {
    try {
      final response =
          await apiService.get('site-trees/list/workspace/$parentSiteId');

      if (response['data'] != null && response['data'] is List) {
        return (response['data'] as List)
            .map((item) => WorkspaceModel.fromJson(item))
            .toList();
      }

      return [];
    } catch (e) {
      print('Error fetching user workspace: $e');
      return [];
    }
  }
}
