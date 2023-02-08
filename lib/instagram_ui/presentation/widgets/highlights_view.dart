import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

import '../../instagram_ui.dart';

class HighlightsView extends StatefulWidget {
  const HighlightsView({
    super.key,
    required this.highlights,
  });
  final Highlights highlights;

  @override
  State<HighlightsView> createState() => _HighlightsViewState();
}

class _HighlightsViewState extends State<HighlightsView> {
  late final StoryController _storyController;

  @override
  void initState() {
    _storyController = StoryController();
    super.initState();
  }

  @override
  void dispose() {
    _storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final storyItems = <String>[
      widget.highlights.image,
      'https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif',
      'https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif'
    ];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const SizedBox.shrink(),
        leadingWidth: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.highlights.image),
            ),
            const SizedBox(width: 10),
            Text(
              widget.highlights.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: StoryView(
        controller: _storyController,
        onComplete: () => Navigator.pop(context),
        onVerticalSwipeComplete: (p0) => Navigator.pop(context),
        storyItems: storyItems
            .map((e) => StoryItem.pageProviderImage(NetworkImage(e)))
            .toList(),
      ),
    );
  }
}
