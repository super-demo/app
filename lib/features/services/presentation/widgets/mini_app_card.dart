import 'package:app/features/mini_app/presentation/pages/mini_app_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MiniAppCard extends StatefulWidget {
  const MiniAppCard({
    super.key,
    required this.index,
    required this.title,
    required this.imageUrl,
    required this.linkUrl,
  });

  final int index;
  final String title;
  final String imageUrl;
  final String linkUrl;

  @override
  _MiniAppCardState createState() => _MiniAppCardState();
}

class _MiniAppCardState extends State<MiniAppCard> {
  double _scale = 1.0;
  final GlobalKey _cardKey = GlobalKey();

  void _showContextMenu(BuildContext context) async {
    final RenderBox cardBox =
        _cardKey.currentContext!.findRenderObject() as RenderBox;
    final Offset cardPosition = cardBox.localToGlobal(Offset.zero);
    final Size cardSize = cardBox.size;

    final double menuX = cardPosition.dx + cardSize.width;
    final double menuY = cardPosition.dy + cardSize.height;

    final RelativeRect positionRect = RelativeRect.fromLTRB(
      menuX - 30,
      menuY - 35,
      menuX - 30,
      menuY - 35,
    );

    // Show the menu and wait for the user's selection
    final result = await showMenu<String>(
        context: context,
        position: positionRect,
        menuPadding: const EdgeInsets.symmetric(vertical: 0),
        items: [
          PopupMenuItem<String>(
              value: 'pin',
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/svg/pin.svg",
                    width: 16,
                    height: 16,
                    color: Colors.black87,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Pin',
                    style: TextStyle(color: Colors.black87),
                  ),
                ],
              )),
          PopupMenuItem<String>(
              value: 'Unpin',
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/svg/pin-off.svg",
                    width: 16,
                    height: 16,
                    color: Colors.black87,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Unpin',
                    style: TextStyle(color: Colors.black87),
                  ),
                ],
              )),
        ],
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Colors.white);

    // Handle the selected menu item
    if (result != null) {
      switch (result) {
        case 'pin':
          print('Pinned card: ${widget.title} (Index: ${widget.index})');
          // Add pinning logic here
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog:
                true, // Makes it appear as a separate modal-like page
            builder: (context) =>
                MiniAppPage(linkUrl: widget.linkUrl, title: widget.title),
          ),
        );
      },
      onTapDown: (_) {
        setState(() {
          _scale = 0.95;
        });
      },
      onTapUp: (_) {
        setState(() {
          _scale = 1.0;
        });
        print('Image ${widget.index} clicked');
      },
      onTapCancel: () {
        setState(() {
          _scale = 1.0;
        });
      },
      onLongPressStart: (_) {
        setState(() {
          _scale = 0.95;
        });
      },
      onLongPressEnd: (_) {
        setState(() {
          _scale = 1.0;
        });
        _showContextMenu(context);
      },
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100), // Animation duration
        child: Column(
          key:
              _cardKey, // Attach the GlobalKey to the Column to get its position
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                width: 64,
                height: 64,
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 32,
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
            Text(widget.title),
          ],
        ),
      ),
    );
  }
}
