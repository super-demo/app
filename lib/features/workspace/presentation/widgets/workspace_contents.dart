import 'package:app/core/constants/app_color.dart';
import 'package:app/features/workspace/presentation/pages/workspace_page.dart';
import 'package:app/features/services/presentation/widgets/miniapp_card.dart';
import 'package:app/features/services/presentation/widgets/workspace_card.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WorkspaceContents extends StatefulWidget {
  const WorkspaceContents({super.key});

  @override
  State<WorkspaceContents> createState() => WorkspaceContentsState();
}

class WorkspaceContentsState extends State<WorkspaceContents> {
  final CarouselController controller = CarouselController(initialItem: 1);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final PageController _pageController = PageController();
  final int itemsPerPage = 8; // 4x2 Grid per page
  final int totalItems = 16; // Example: More than 8 items for scrolling

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

    // double height = MediaQuery.of(context).size.height;

    // Calculate total pages required
    int totalPages = (totalItems / itemsPerPage).ceil();

    return ListView(
      children: <Widget>[
        const SizedBox(height: 20),
        Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: height / 2),
              child: PageView.builder(
                controller: _pageController,
                itemCount: totalPages,
                itemBuilder: (context, pageIndex) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // 4 columns
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: itemsPerPage,
                    itemBuilder: (context, index) {
                      int globalIndex = pageIndex * itemsPerPage + index;
                      if (globalIndex >= totalItems) {
                        return const SizedBox(); // Prevent overflow
                      }

                      return MiniAppCard(
                        index: globalIndex,
                        title: "Item $globalIndex",
                        imageUrl: 'https://github.com/thyms-c.png',
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
        ),
        const SizedBox(height: 14),
        const Padding(
          padding: EdgeInsetsDirectional.only(top: 8.0, start: 16.0),
          child: Text(
            'Workspace name\'s workspaces',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            shrinkWrap:
                true, // Ensures the GridView takes only the space it needs
            physics: const NeverScrollableScrollPhysics(), // Disable scrolling
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.72,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WorkspacePage(
                            // workspace: workspaces[
                            //     index], // Pass the selected workspace data
                            ),
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
                  ));
            },
          ),
        ),
        const SizedBox(height: 28),
      ],
    );
  }
}
