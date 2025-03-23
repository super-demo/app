import 'package:app/features/workspace/data/repositories/workspace_repository_impl.dart';
import 'package:app/features/workspace/presentation/bloc/workspace_bloc.dart';
import 'package:app/features/workspace/presentation/widgets/workspace_contents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WorkspacePage extends StatelessWidget {
  final int parentSiteId;
  final int workspaceId;
  final String workspaceName;

  const WorkspacePage(
      {super.key,
      required this.parentSiteId,
      required this.workspaceId,
      required this.workspaceName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WorkspaceBloc(
        repository: context.read<WorkspaceRepository>(),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              workspaceName,
              style: const TextStyle(fontSize: 18),
            ),
            leading: IconButton(
                onPressed: () => {Navigator.pop(context)},
                icon: SvgPicture.asset(
                  "assets/svg/chevron-left.svg",
                  color: Colors.black54,
                ))),
        body: WorkspaceContents(workspaceId: workspaceId, workspaceName: workspaceName),
      ),
    );
  }
}
