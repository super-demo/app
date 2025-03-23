import 'package:app/features/home/data/models/announcement_model.dart';

abstract class AnnouncementState {}

class AnnouncementInitial extends AnnouncementState {}

class AnnouncementLoading extends AnnouncementState {}

class AnnouncementsLoaded extends AnnouncementState {
  final List<Announcement> announcements;

  AnnouncementsLoaded(this.announcements);
}

class AnnouncementDetailLoaded extends AnnouncementState {
  final Announcement announcement;

  AnnouncementDetailLoaded(this.announcement);
}

class AnnouncementError extends AnnouncementState {
  final String message;

  AnnouncementError(this.message);
}
