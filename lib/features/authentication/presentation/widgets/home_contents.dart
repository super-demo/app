import 'dart:ui';

import 'package:app/core/enums/banner_info.dart';
import 'package:app/features/authentication/presentation/widgets/banner.dart';
import 'package:app/features/authentication/presentation/widgets/miniapp_card.dart';
import 'package:app/features/authentication/presentation/widgets/workspace_card.dart';
import 'package:flutter/material.dart';

class HomeContents extends StatefulWidget {
  const HomeContents({super.key});

  @override
  State<HomeContents> createState() => _HomeContentsState();
}

class _HomeContentsState extends State<HomeContents> {
  final CarouselController controller = CarouselController(initialItem: 1);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double height = 420;

    final List<Map<String, String>> workspaces = [
      {
        'image':
            'https://github.com/chayakorn2002.png', // Replace with your image URL
        'label': 'HAPPENING NOW',
        'title': 'Kasetsart Sriracha',
        'subtitle': 'เกษตรศาสตร์ ศรีราชา',
        'backgroundColor': '0xFF59DFFD', // Red color
      },
      {
        'image':
            'https://github.com/chayakorn2002.png', // Replace with your image URL
        'label': 'HAPPENING NOW',
        'title': 'Asphalt Legends Unite meets',
        'subtitle': 'LEGO',
        'backgroundColor': '0xFF59DFFD', // Blue color
      },
      {
        'image':
            'https://github.com/chayakorn2002.png', // Replace with your image URL
        'label': 'HAPPENING NOW',
        'title': 'Summer Race in',
        'subtitle': 'Asphalt 9',
        'backgroundColor': '0xFF59DFFD', // Yellow color
      },
      // Additional workspaces (not displayed directly)
      {
        'image': 'https://github.com/chayakorn2002.png',
        'label': 'HAPPENING NOW',
        'title': 'Winter Challenge in',
        'subtitle': 'Subway Surfers',
        'backgroundColor': '0xFF59DFFD',
      },
    ];

    return ListView(
      children: <Widget>[
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: height / 2),
          child: CarouselView.weighted(
            controller: controller,
            itemSnapping: true,
            flexWeights: const <int>[1, 7, 1],
            children: BannerInfo.values.map((BannerInfo image) {
              return HeroLayoutCard(bannerInfo: image);
            }).toList(),
          ),
        ),
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
              crossAxisCount: 4, // 4 columns
              crossAxisSpacing: 8, // Space between columns
              mainAxisSpacing: 8, // Space between rows
            ),
            itemCount: 8, // 4x2 grid = 8 images
            itemBuilder: (context, index) {
              return MiniAppCard(
                  index: index,
                  title: "name",
                  imageUrl: 'https://github.com/thyms-c.png');
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
              if (index == 4 - 1) {
                return SeeAllCard(
                  onTap: () {
                    print('click see all');
                  },
                );
              }
              // Otherwise, show an event card
              return WorkspaceCard(
                imageUrl: workspaces[index]['image']!,
                label: workspaces[index]['label']!,
                title: workspaces[index]['title']!,
                subtitle: workspaces[index]['subtitle']!,
                backgroundColor:
                    Color(int.parse(workspaces[index]['backgroundColor']!)),
              );
            },
          ),
        ),
        const SizedBox(height: 28),
      ],
    );
  }
}
