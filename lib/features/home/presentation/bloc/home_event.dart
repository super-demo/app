abstract class AnnouncementEvent {}

class FetchAnnouncementsBySiteIdEvent extends AnnouncementEvent {
  final int siteId;

  FetchAnnouncementsBySiteIdEvent(this.siteId);
}

class FetchAnnouncementByIdEvent extends AnnouncementEvent {
  final int id;

  FetchAnnouncementByIdEvent(this.id);
}
