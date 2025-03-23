import 'package:app/features/home/data/repositories/announcement_repository_impl.dart';
import 'package:app/features/home/presentation/bloc/home_event.dart';
import 'package:app/features/home/presentation/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnnouncementBloc extends Bloc<AnnouncementEvent, AnnouncementState> {
  final AnnouncementRepository repository;

  AnnouncementBloc({required this.repository}) : super(AnnouncementInitial()) {
    on<FetchAnnouncementsBySiteIdEvent>(_onFetchAnnouncementsBySiteId);
    on<FetchAnnouncementByIdEvent>(_onFetchAnnouncementById);
  }

  Future<void> _onFetchAnnouncementsBySiteId(
    FetchAnnouncementsBySiteIdEvent event,
    Emitter<AnnouncementState> emit,
  ) async {
    emit(AnnouncementLoading());
    try {
      final announcements =
          await repository.getAnnouncementsBySiteId(event.siteId);
      emit(AnnouncementsLoaded(announcements));
    } catch (e) {
      emit(AnnouncementError(e.toString()));
    }
  }

  Future<void> _onFetchAnnouncementById(
    FetchAnnouncementByIdEvent event,
    Emitter<AnnouncementState> emit,
  ) async {
    emit(AnnouncementLoading());
    try {
      final announcement = await repository.getAnnouncementById(event.id);
      emit(AnnouncementDetailLoaded(announcement));
    } catch (e) {
      emit(AnnouncementError(e.toString()));
    }
  }
}
