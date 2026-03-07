import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final List<Widget> children; // receive list items from parent

  const CustomAppBar({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 160,
          backgroundColor: theme.colorScheme.primary,

          title: Row(
            children: [
              Image.asset("assets/icons/ic_library.png", height: 30),
              const SizedBox(width: 8),
              const Text("ReelDrop"),
            ],
          ),

          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomLeft,
              child: Text(
                "Welcome to",
                style: theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),

        // Use SliverList with passed children
        SliverList(delegate: SliverChildListDelegate(children)),
      ],
    );
  }
}
