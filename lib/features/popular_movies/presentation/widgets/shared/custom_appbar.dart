import 'package:flutter/material.dart';
import 'package:the_movie_db/core/config/l10n/l10n.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
        bottom: false,
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined),
              const SizedBox(width: 5),
              Text(S.of(context).app_name, style: titleStyle),
            ],
          ),
        ));
  }
}
