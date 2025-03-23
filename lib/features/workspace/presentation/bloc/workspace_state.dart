import 'package:app/features/services/data/models/mini_app_model.dart';
import 'package:app/features/workspace/data/models/workspace_model.dart';
import 'package:equatable/equatable.dart';

abstract class WorkspaceState extends Equatable {
  const WorkspaceState();

  @override
  List<Object> get props => [];
}

class WorkspaceInitial extends WorkspaceState {}

class WorkspaceLoading extends WorkspaceState {}

class WorkspaceLoaded extends WorkspaceState {
  final List<WorkspaceModel> userWorkspaces;

  const WorkspaceLoaded({
    required this.userWorkspaces,
  });

  @override
  List<Object> get props => [userWorkspaces];
}

class WorkspaceError extends WorkspaceState {
  final String message;

  const WorkspaceError(this.message);

  @override
  List<Object> get props => [message];
}
