import 'package:app/features/authentication/presentation/widgets/workspace_contents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WorkspacePage extends StatelessWidget {
  const WorkspacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              'Workspace name',
              style: TextStyle(fontSize: 18),
            ),
            leading: IconButton(
                onPressed: () => {Navigator.pop(context)},
                icon: SvgPicture.asset(
                  "assets/svg/chevron-left.svg",
                  color: Colors.black54,
                ))),
        body: const WorkspaceContents(),
      ),
    );
  }
}
