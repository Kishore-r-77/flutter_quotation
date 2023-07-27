import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotation_flutter/providers/darkProvider/dark_provider.dart';

class CustomAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title});
  final String title;

  @override
  ConsumerState<CustomAppBar> createState() => _CustomAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends ConsumerState<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(darkProvider);
    void toggleDarkTheme() {
      ref.watch(darkProvider.notifier).toggleDarkTheme();
    }

    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      title: Text(
        widget.title,
        style: const TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(
            onPressed: () {
              setState(() {
                toggleDarkTheme();
              });
            },
            icon: isDark
                ? Icon(
                    Icons.light_mode,
                    size: 30,
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  )
                : const Icon(
                    Icons.dark_mode,
                    size: 30,
                    color: Colors.white70,
                  ))
      ],
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.onBackground,
              Theme.of(context).colorScheme.primary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}
