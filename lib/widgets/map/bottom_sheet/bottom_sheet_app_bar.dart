import 'package:flutter/material.dart';

import 'filter_bar.dart';

class BottomSheetAppBar extends StatelessWidget {
  const BottomSheetAppBar({
    super.key,
    required this.setStreamQuery,
  });

  final Function setStreamQuery;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      title: const Icon(Icons.drag_handle),
      titleSpacing: 0.0,
      centerTitle: true,
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
            child: FilterBar(
              setStreamQuery: setStreamQuery,
            ),
          )),
    );
  }
}
