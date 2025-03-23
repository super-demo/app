import 'package:app/features/workspace/data/repositories/workspace_repository_impl.dart';
import 'package:app/features/workspace/presentation/bloc/workspace_event.dart';
import 'package:app/features/workspace/presentation/bloc/workspace_state.dart';
import 'package:bloc/bloc.dart';

class WorkspaceBloc extends Bloc<WorkspaceEvent, WorkspaceState> {
  final WorkspaceRepository repository;

  WorkspaceBloc({required this.repository}) : super(WorkspaceInitial()) {
    on<FetchUserWorkspaces>(_onFetchUserWorkspaces);
  }

  Future<void> _onFetchUserWorkspaces(
    FetchUserWorkspaces event,
    Emitter<WorkspaceState> emit,
  ) async {
    emit(WorkspaceLoading());
    try {
      final userWorkspaces =
          await repository.getUserWorkspaces(event.parentSiteId);

      emit(WorkspaceLoaded(userWorkspaces: userWorkspaces));
    } catch (e) {
      emit(WorkspaceError('Failed to load site mini apps: ${e.toString()}'));
    }
  }
}
