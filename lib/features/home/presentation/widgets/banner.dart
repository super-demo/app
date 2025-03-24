import 'package:app/core/enums/banner_info.dart';
import 'package:app/features/home/presentation/pages/announcement_detail_page.dart';
import 'package:flutter/material.dart';

class HeroLayoutCard extends StatelessWidget {
  const HeroLayoutCard({
    super.key,
    required this.bannerInfo,
    this.announcementId,
  });

  final BannerInfo bannerInfo;
  final int? announcementId;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: announcementId != null
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnnouncementDetailPage(
                    announcementId: announcementId!,
                  ),
                ),
              );
            }
          : null,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          ClipRect(
            child: OverflowBox(
              maxWidth: width * 7 / 8,
              minWidth: width * 7 / 8,
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(bannerInfo.url),
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    width: width * 7 / 8,
                    height: double.infinity,
                    child: const Center(
                      child:
                          Icon(Icons.image_not_supported, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(18.0),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisSize: MainAxisSize.min,
          //     children: <Widget>[
          //       Text(
          //         bannerInfo.title,
          //         overflow: TextOverflow.clip,
          //         softWrap: false,
          //         style: Theme.of(context)
          //             .textTheme
          //             .headlineLarge
          //             ?.copyWith(color: Colors.black),
          //       ),
          //       const SizedBox(height: 10),
          //       Text(
          //         bannerInfo.subtitle,
          //         overflow: TextOverflow.clip,
          //         softWrap: false,
          //         style: Theme.of(context)
          //             .textTheme
          //             .bodyMedium
          //             ?.copyWith(color: Colors.black),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
