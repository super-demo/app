import 'package:equatable/equatable.dart';

abstract class MiniAppEvent extends Equatable {
  const MiniAppEvent();

  @override
  List<Object> get props => [];
}

class FetchSiteMiniAppList extends MiniAppEvent {
  final int siteId;

  FetchSiteMiniAppList({required this.siteId});
}
