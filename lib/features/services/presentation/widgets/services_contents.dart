import 'package:app/core/constants/app_color.dart';
import 'package:app/features/services/data/models/mini_app_model.dart';
import 'package:app/features/services/presentation/bloc/mini_app_bloc.dart';
import 'package:app/features/services/presentation/bloc/mini_app_event.dart';
import 'package:app/features/services/presentation/bloc/mini_app_state.dart';
import 'package:app/features/services/presentation/widgets/mini_app_card.dart';
import 'package:app/features/services/presentation/widgets/workspace_card.dart';
import 'package:app/features/workspace/data/models/workspace_model.dart';
import 'package:app/features/workspace/presentation/bloc/workspace_bloc.dart';
import 'package:app/features/workspace/presentation/bloc/workspace_event.dart';
import 'package:app/features/workspace/presentation/bloc/workspace_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ServicesContents extends StatefulWidget {
  const ServicesContents({super.key});

  @override
  _ServicesContentsState createState() => _ServicesContentsState();
}

class _ServicesContentsState extends State<ServicesContents> {
  final CarouselController controller = CarouselController(initialItem: 1);

  @override
  void initState() {
    super.initState();
    int siteId = 1;
    context.read<MiniAppBloc>().add(FetchSiteMiniAppList(siteId: siteId));
    context
        .read<WorkspaceBloc>()
        .add(FetchUserWorkspaces(parentSiteId: siteId));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;

    return ListView(
      children: <Widget>[
        const SizedBox(height: 8),
        BlocBuilder<MiniAppBloc, MiniAppState>(builder: (context, state) {
          return (state is MiniAppLoaded)
              ? _buildMiniAppCard(state, state.siteMiniAppList)
              : const Center(child: CircularProgressIndicator());
        }),
        const SizedBox(height: 14),
        const Padding(
          padding: EdgeInsetsDirectional.only(top: 8.0, start: 16.0),
          child: Text(
            'All workspaces',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<WorkspaceBloc, WorkspaceState>(
            builder: (context, state) {
              return (state is WorkspaceLoaded)
                  ? _buildWorkspaceCard(state, state.userWorkspaces)
                  : const Center(child: CircularProgressIndicator());
            },
          ),
        ),
        const SizedBox(height: 28),
      ],
    );
  }

  Widget _buildMiniAppCard(MiniAppState state, List<MiniAppModel> miniApps) {
    double height;
    miniApps.length > 8 ? height = 420 : height = 200;
    const int itemsPerPage = 8;
    int totalPages = (miniApps.length / itemsPerPage).ceil();

    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: height / 2),
          child: PageView.builder(
            controller: _pageController,
            itemCount: totalPages,
            itemBuilder: (context, pageIndex) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 4 columns
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: itemsPerPage,
                itemBuilder: (context, index) {
                  int globalIndex = pageIndex * itemsPerPage + index;
                  if (globalIndex >= miniApps.length) {
                    return const SizedBox(); // Prevent overflow
                  }

                  return MiniAppCard(
                    index: miniApps[globalIndex].siteMiniAppId,
                    title: miniApps[globalIndex].slug,
                    imageUrl: miniApps[globalIndex].imageUrl,
                    linkUrl: miniApps[globalIndex].linkUrl,
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        SmoothPageIndicator(
          controller: _pageController,
          count: totalPages,
          effect: const WormEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: AppColors.kColorPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildWorkspaceCard(
      WorkspaceState state, List<WorkspaceModel> workspaces) {
    return GridView.builder(
      shrinkWrap: true, // Ensures the GridView takes only the space it needs
      physics: const NeverScrollableScrollPhysics(), // Disable scrolling
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.8,
      ),
      itemCount: workspaces.length,
      itemBuilder: (context, index) {
        return WorkspaceCard(
          imageUrl: workspaces[index].imageUrl,
          title: workspaces[index].name,
          subtitle: workspaces[index].shortDescription,
          parentSiteId: workspaces[index].siteParentId,
          workspaceId: workspaces[index].siteId,
          workspaceName: workspaces[index].name,
        );
      },
    );
  }
}
