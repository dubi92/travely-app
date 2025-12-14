import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/env.dart';
import 'core/config/router.dart';
import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';

import 'shared/services/supabase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Env.init();
    await SupabaseService.init();
  } catch (e) {
    // In a real app we might show a native dialog or error page, 
    // but for now printing to console is inevitable if we crash before runApp.
    // However, we can run a simple error app.
    debugPrint('Initialization failed: $e');
    runApp(MaterialApp(
      home: Scaffold(body: Center(child: Text('Failed to initialize app: $e', textAlign: TextAlign.center))),
    ));
    return;
  }
  
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
    );
  }
}
