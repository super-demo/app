import 'package:app/features/services/data/repositories/mini_app_repository_impl.dart';
import 'package:app/features/services/presentation/bloc/mini_app_bloc.dart';
import 'package:app/features/services/presentation/widgets/services_contents.dart';
import 'package:app/features/workspace/data/repositories/workspace_repository_impl.dart';
import 'package:app/features/workspace/presentation/bloc/workspace_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MiniAppBloc>(
          create: (context) => MiniAppBloc(
            repository: context.read<MiniAppRepository>(),
          ),
        ),
        BlocProvider<WorkspaceBloc>(
          create: (context) => WorkspaceBloc(
            repository: context.read<WorkspaceRepository>(),
          ),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'All Services',
            style: TextStyle(fontSize: 18),
          ),
        ),
        body: const ServicesContents(),
      ),
    );
  }
}
