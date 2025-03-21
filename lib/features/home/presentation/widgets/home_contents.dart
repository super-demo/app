import 'package:app/core/enums/banner_info.dart';
import 'package:app/features/home/presentation/bloc/home_bloc.dart';
import 'package:app/features/home/presentation/bloc/home_event.dart';
import 'package:app/features/home/presentation/bloc/home_state.dart';
import 'package:app/features/home/presentation/widgets/banner.dart';
import 'package:app/features/services/presentation/widgets/miniapp_card.dart';
import 'package:app/features/services/presentation/widgets/workspace_card.dart';
import 'package:app/features/workspace/presentation/pages/workspace_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    context
        .read<AnnouncementBloc>()
        .add(FetchAnnouncementsBySiteIdEvent(siteId));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double height = 420;

    // Expanded the workspaces list to have 4 items
    final List<Map<String, String>> workspaces = [
      {
        'image': 'https://github.com/chayakorn2002.png',
        'label': 'HAPPENING NOW',
        'title': 'Kasetsart Sriracha',
        'subtitle': 'เกษตรศาสตร์ ศรีราชา',
        'backgroundColor': '0xFF59DFFD',
      },
      {
        'image': 'https://github.com/thyms-c.png',
        'label': 'UPCOMING EVENT',
        'title': 'Digital Innovation',
        'subtitle': 'นวัตกรรมดิจิทัล',
        'backgroundColor': '0xFF6C5DD3',
      },
      {
        'image': 'https://github.com/chayakorn2002.png',
        'label': 'STUDENT ACTIVITY',
        'title': 'Computer Science',
        'subtitle': 'วิทยาการคอมพิวเตอร์',
        'backgroundColor': '0xFFFF7F51',
      },
      {
        'image': 'https://github.com/thyms-c.png',
        'label': 'WORKSHOP',
        'title': 'Data Science',
        'subtitle': 'วิทยาศาสตร์ข้อมูล',
        'backgroundColor': '0xFF59DFFD',
      },
    ];

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
        SizedBox(
          height: 252,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              if (index == 3) {
                return SeeAllCard(
                  onTap: () {
                    print('click see all');
                  },
                );
              }
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WorkspacePage(),
                    ),
                  );
                },
                child: WorkspaceCard(
                  imageUrl: workspaces[index]['image']!,
                  label: workspaces[index]['label']!,
                  title: workspaces[index]['title']!,
                  subtitle: workspaces[index]['subtitle']!,
                  backgroundColor:
                      Color(int.parse(workspaces[index]['backgroundColor']!)),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 28),
      ],
    );
  }
}
