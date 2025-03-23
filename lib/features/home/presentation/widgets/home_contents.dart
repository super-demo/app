import 'package:app/core/enums/banner_info.dart';
import 'package:app/features/home/presentation/bloc/home_bloc.dart';
import 'package:app/features/home/presentation/bloc/home_event.dart';
import 'package:app/features/home/presentation/bloc/home_state.dart';
import 'package:app/features/home/presentation/widgets/banner.dart';
import 'package:app/features/services/presentation/pages/services_page.dart';
import 'package:app/features/services/presentation/widgets/mini_app_card.dart';
import 'package:app/features/services/presentation/widgets/workspace_card.dart';
import 'package:app/features/workspace/data/models/workspace_model.dart';
import 'package:app/features/workspace/presentation/bloc/workspace_bloc.dart';
import 'package:app/features/workspace/presentation/bloc/workspace_event.dart';
import 'package:app/features/workspace/presentation/bloc/workspace_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class HomeContents extends StatefulWidget {
  const HomeContents({super.key});

  @override
  State<HomeContents> createState() => _HomeContentsState();
}

class _HomeContentsState extends State<HomeContents> {
  final CarouselController controller =
      CarouselController(initialItem: 0); // Changed from 1 to 0

  // Define your site ID (replace with your actual site ID)
  final int siteId = 1;

  @override
  void initState() {
    super.initState();
    // Fetch announcements when the widget initializes
    const int siteId = 1;
    context
        .read<AnnouncementBloc>()
        .add(FetchAnnouncementsBySiteIdEvent(siteId));
    context
        .read<WorkspaceBloc>()
        .add(FetchUserWorkspaces(parentSiteId: siteId));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double height = 420;

    return ListView(
      children: <Widget>[
        // Announcements banner section
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: height / 2),
          child: BlocBuilder<AnnouncementBloc, AnnouncementState>(
            builder: (context, state) {
              if (state is AnnouncementLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AnnouncementsLoaded) {
                final announcements = state.announcements;

                if (announcements.isEmpty) {
                  // Fallback to default banners if no announcements
                  return CarouselView.weighted(
                    controller: controller,
                    itemSnapping: true,
                    flexWeights: const <int>[1, 7, 1],
                    children: BannerInfo.values.map((BannerInfo info) {
                      return HeroLayoutCard(bannerInfo: info);
                    }).toList(),
                  );
                }

                // Convert announcements to BannerInfo objects for carousel
                return CarouselView.weighted(
                  controller: controller,
                  itemSnapping: true,
                  flexWeights: const <int>[1, 7, 1],
                  children: announcements.map((announcement) {
                    return HeroLayoutCard(
                      bannerInfo: BannerInfo.fromAnnouncement(announcement),
                    );
                  }).toList(),
                );
              } else if (state is AnnouncementError) {
                // On error, return the default banners
                return CarouselView.weighted(
                  controller: controller,
                  itemSnapping: true,
                  flexWeights: const <int>[1, 7, 1],
                  children: BannerInfo.values.map((BannerInfo info) {
                    return HeroLayoutCard(bannerInfo: info);
                  }).toList(),
                );
              }

              // Show loading state
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),

        // Rest of your existing UI components
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsetsDirectional.only(top: 8.0, start: 16.0),
          child: Text(
            'Pinned services',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: height / 2),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: 8,
            itemBuilder: (context, index) {
              return MiniAppCard(
                index: index,
                title: "name",
                imageUrl: 'https://github.com/thyms-c.png',
                linkUrl: "https://www.google.com",
              );
            },
          ),
        ),
        const SizedBox(height: 14),
        const Padding(
          padding: EdgeInsetsDirectional.only(top: 8.0, start: 16.0),
          child: Text(
            'Your workspaces',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ),
        const SizedBox(height: 12),
        BlocBuilder<WorkspaceBloc, WorkspaceState>(
          builder: (context, state) {
            if (state is WorkspaceLoaded && state.userWorkspaces.isEmpty) {
              return const Center(
                child: Text(
                  'No workspaces available',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              );
            }

            return (state is WorkspaceLoaded)
                ? _buildWorkspaceCard(state, state.userWorkspaces)
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
        const SizedBox(height: 28),
      ],
    );
  }

  Widget _buildWorkspaceCard(
      WorkspaceState state, List<WorkspaceModel> workspaces) {
    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: workspaces.length > 3 ? 4 : workspaces.length + 1,
        itemBuilder: (context, index) {
          if (index == (workspaces.length > 3 ? 3 : workspaces.length)) {
            return SeeAllCard(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ServicesPage()),
                );
              },
            );
          }
          return WorkspaceCard(
            imageUrl: workspaces[index].imageUrl,
            title: workspaces[index].name,
            subtitle: workspaces[index].shortDescription,
            parentSiteId: workspaces[index].siteParentId,
            workspaceId: workspaces[index].siteId,
            workspaceName: workspaces[index].name,
          );
        },
      ),
    );
  }
}
