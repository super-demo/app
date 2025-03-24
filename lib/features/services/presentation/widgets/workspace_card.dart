import 'dart:ui';

import 'package:app/core/constants/app_color.dart';
import 'package:app/features/workspace/presentation/pages/workspace_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WorkspaceCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final int parentSiteId;
  final int workspaceId;
  final String workspaceName;

  const WorkspaceCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.parentSiteId,
    required this.workspaceId,
    required this.workspaceName,
  });

  @override
  _WorkspaceCardState createState() => _WorkspaceCardState();
}

class _WorkspaceCardState extends State<WorkspaceCard> {
  static final List<Color> bgColors = [
    AppColors.kColorPrimary, // Color 4: Teal
    // const Color(0xFF97CADB), // Color 2: Soft White
    const Color.fromARGB(255, 205, 234, 243), // Color 3: Light Gray
    // const Color(0xFF02457A), // Color 4: Teal
    const Color(0xFF018ABE), // Color 1: Light Blue
    AppColors.kColorPrimary, // Color 4: Teal
  ];

  late final Gradient randomGradient;
  int colorIndex = 0; // Track the index of the current color

  @override
  void initState() {
    super.initState();
    final color1 =
        bgColors[colorIndex % bgColors.length]; // Loop through colors
    final color2 = bgColors[
        (colorIndex + 1) % bgColors.length]; // Ensure second color is different
    randomGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [color1, color2],
    );
    colorIndex++; // Update index for next card
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WorkspacePage(
                    parentSiteId: widget.parentSiteId,
                    workspaceId: widget.workspaceId,
                    workspaceName: widget.workspaceName,
                  )),
        );
      },
      child: Container(
        width: 170,
        height: 200, // Set height dynamically
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          // gradient: randomGradient,
          color: Colors.black54,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Container(
              height: 160,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                image: DecorationImage(
                  image: NetworkImage(widget.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  // gradient: randomGradient,
                  color: AppColors.kColorPrimary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.subtitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SeeAllCard extends StatefulWidget {
  final VoidCallback onTap;

  const SeeAllCard({super.key, required this.onTap});

  @override
  _SeeAllCardState createState() => _SeeAllCardState();
}

class _SeeAllCardState extends State<SeeAllCard> {
  static final List<Color> bgColors = [
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.orangeAccent
  ];

  late final Color randomBgColor;
  int colorIndex = 0;

  @override
  void initState() {
    super.initState();
    randomBgColor =
        bgColors[colorIndex % bgColors.length]; // Loop through the fixed colors
    colorIndex++; // Update index for next card
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.all(4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: SizedBox(
              width: 124,
              height: 100, // Adjusted height
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/svg/arrow-right.svg",
                    color: Colors.black54,
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'See All',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
