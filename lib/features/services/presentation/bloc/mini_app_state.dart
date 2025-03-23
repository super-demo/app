import 'package:app/features/services/data/models/mini_app_model.dart';
import 'package:equatable/equatable.dart';

abstract class MiniAppState extends Equatable {
  const MiniAppState();

  @override
  List<Object> get props => [];
}

class MiniAppInitial extends MiniAppState {}

class MiniAppLoading extends MiniAppState {}

class MiniAppLoaded extends MiniAppState {
  final List<MiniAppModel> siteMiniAppList;

  const MiniAppLoaded({
    required this.siteMiniAppList,
  });

  @override
  List<Object> get props => [siteMiniAppList];
}

class MiniAppError extends MiniAppState {
  final String message;

  const MiniAppError(this.message);

  @override
  List<Object> get props => [message];
}
