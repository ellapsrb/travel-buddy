import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'config/supabase_config.dart';
import 'screens/navigation_screen.dart';
import 'services/destination_api_service.dart';
import 'services/wishlist_supabase_service.dart';
import 'repositories/destination_repository.dart';
import 'repositories/wishlist_repository.dart';
import 'providers/destination_provider.dart';
import 'providers/wishlist_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    publishableKey: SupabaseConfig.supabasePublishableKey,
  );

  final destinationApiService = DestinationApiService();

  final destinationRepository = DestinationRepository(
    apiService: destinationApiService,
  );

  final wishlistService = WishlistSupabaseService();

  final wishlistRepository = WishlistRepository(service: wishlistService);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DestinationProvider(repository: destinationRepository),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              WishlistProvider(repository: wishlistRepository)
                ..fetchWishlists(),
        ),
      ],
      child: const TravelBuddyApp(),
    ),
  );
}

class TravelBuddyApp extends StatelessWidget {
  const TravelBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TravelBuddy',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF173B57)),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF173B57),
          elevation: 0,
        ),
      ),
      home: const NavigationScreen(),
    );
  }
}
