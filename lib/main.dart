import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:the_movie_db/core/config/l10n/l10n.dart';
import 'package:the_movie_db/core/config/router/app_router.dart';
import 'package:the_movie_db/core/config/theme/app_theme.dart';
import 'package:the_movie_db/core/service_locator/service_locator.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env.template');
  await Hive.initFlutter();
  await initServiceLocator();

  runApp(const LinksShortenerApp());
}

class LinksShortenerApp extends StatelessWidget {
  const LinksShortenerApp({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();

    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTheme().getTheme(),
      localizationsDelegates: const [
        S.delegate,
      ],
    );
  }
}
