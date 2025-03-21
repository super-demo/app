import 'package:app/features/notification/data/repositories/noti_repository_impl.dart';
import 'package:app/features/notification/presentation/bloc/noti_event.dart';
import 'package:app/features/notification/presentation/bloc/noti_state.dart';
import 'package:bloc/bloc.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository repository;

  NotificationBloc({required this.repository}) : super(NotificationInitial()) {
    on<FetchAllNotifications>(_onFetchAllNotifications);
    on<FetchRecentNotifications>(_onFetchRecentNotifications);
    on<FetchOlderNotifications>(_onFetchOlderNotifications);
    on<RefreshNotifications>(_onRefreshNotifications);
  }

  Future<void> _onFetchAllNotifications(
    FetchAllNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading());
    try {
      final allNotifications = await repository.getAllNotifications();
      final recentNotifications = await repository.getRecentNotifications();
      final olderNotifications = await repository.getOlderNotifications();

      emit(NotificationLoaded(
        allNotifications: allNotifications,
        recentNotifications: recentNotifications,
        olderNotifications: olderNotifications,
      ));
    } catch (e) {
      emit(NotificationError('Failed to load notifications: ${e.toString()}'));
    }
  }

  Future<void> _onFetchRecentNotifications(
    FetchRecentNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    if (state is NotificationLoaded) {
      final currentState = state as NotificationLoaded;
      emit(NotificationLoading());
      try {
        final recentNotifications = await repository.getRecentNotifications();
        emit(NotificationLoaded(
          allNotifications: currentState.allNotifications,
          recentNotifications: recentNotifications,
          olderNotifications: currentState.olderNotifications,
        ));
      } catch (e) {
        emit(NotificationError(
            'Failed to load recent notifications: ${e.toString()}'));
      }
    } else {
      add(FetchAllNotifications());
    }
  }

  Future<void> _onFetchOlderNotifications(
    FetchOlderNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    if (state is NotificationLoaded) {
      final currentState = state as NotificationLoaded;
      emit(NotificationLoading());
      try {
        final olderNotifications = await repository.getOlderNotifications();
        emit(NotificationLoaded(
          allNotifications: currentState.allNotifications,
          recentNotifications: currentState.recentNotifications,
          olderNotifications: olderNotifications,
        ));
      } catch (e) {
        emit(NotificationError(
            'Failed to load older notifications: ${e.toString()}'));
      }
    } else {
      add(FetchAllNotifications());
    }
  }

  Future<void> _onRefreshNotifications(
    RefreshNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading());
    try {
      final allNotifications = await repository.getAllNotifications();
      final recentNotifications = await repository.getRecentNotifications();
      final olderNotifications = await repository.getOlderNotifications();

      emit(NotificationLoaded(
        allNotifications: allNotifications,
        recentNotifications: recentNotifications,
        olderNotifications: olderNotifications,
      ));
    } catch (e) {
      emit(NotificationError(
          'Failed to refresh notifications: ${e.toString()}'));
    }
  }
}
