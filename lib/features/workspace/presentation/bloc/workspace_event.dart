import 'package:equatable/equatable.dart';

abstract class WorkspaceEvent extends Equatable {
  const WorkspaceEvent();

  @override
  List<Object> get props => [];
}

class FetchUserWorkspaces extends WorkspaceEvent {
  final int parentSiteId;

  FetchUserWorkspaces({required this.parentSiteId});
}
