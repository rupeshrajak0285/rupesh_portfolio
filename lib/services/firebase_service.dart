import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'firebase_options.dart';

/// Thin wrapper around Firebase so the rest of the app never touches SDK
/// types directly. Degrades gracefully when Firebase is not configured.
class FirebaseService {
  FirebaseService._();
  static final FirebaseService instance = FirebaseService._();

  bool _ready = false;
  bool get isReady => _ready;

  FirebaseAnalytics? _analytics;

  Future<void> init() async {
    if (!DefaultFirebaseOptions.isConfigured) {
      debugPrint('[Firebase] Not configured. Running in offline mode.');
      return;
    }
    try {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
      _analytics = FirebaseAnalytics.instance;
      _ready = true;
      await logEvent('portfolio_open');
    } catch (e, st) {
      debugPrint('[Firebase] init failed: $e\n$st');
    }
  }

  Future<void> logEvent(String name, [Map<String, Object>? params]) async {
    if (!_ready) return;
    try {
      await _analytics?.logEvent(name: name, parameters: params);
    } catch (_) {}
  }

  /// Persists a contact-form submission in the `messages` collection.
  /// Returns `true` on success, `false` when Firebase is unavailable.
  Future<bool> sendMessage({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    if (!_ready) return false;
    try {
      await FirebaseFirestore.instance.collection('messages').add({
        'name': name.trim(),
        'email': email.trim(),
        'subject': subject.trim(),
        'message': message.trim(),
        'createdAt': FieldValue.serverTimestamp(),
        'userAgent': kIsWeb ? 'web' : defaultTargetPlatform.name,
      });
      await logEvent('contact_submitted');
      return true;
    } catch (e) {
      debugPrint('[Firebase] sendMessage failed: $e');
      return false;
    }
  }
}
