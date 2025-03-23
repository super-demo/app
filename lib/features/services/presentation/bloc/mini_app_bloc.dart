import 'package:app/features/services/data/repositories/mini_app_repository_impl.dart';
import 'package:app/features/services/presentation/bloc/mini_app_event.dart';
import 'package:app/features/services/presentation/bloc/mini_app_state.dart';
import 'package:bloc/bloc.dart';

class MiniAppBloc extends Bloc<MiniAppEvent, MiniAppState> {
  final MiniAppRepository repository;

  MiniAppBloc({required this.repository}) : super(MiniAppInitial()) {
    on<FetchSiteMiniAppList>(_onFetchSiteMiniAppList);
  }

  Future<void> _onFetchSiteMiniAppList(
    FetchSiteMiniAppList event,
    Emitter<MiniAppState> emit,
  ) async {
    emit(MiniAppLoading());
    try {
      final siteMiniAppList = await repository.getSiteMiniAppList(event.siteId);

      emit(MiniAppLoaded(siteMiniAppList: siteMiniAppList));
    } catch (e) {
      emit(MiniAppError('Failed to load site mini apps: ${e.toString()}'));
    }
  }
}
