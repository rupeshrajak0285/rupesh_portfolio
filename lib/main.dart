import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app.dart';
import 'services/firebase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  GoogleFonts.config.allowRuntimeFetching = true;
  await FirebaseService.instance.init();
  runApp(const PortfolioApp());
}
