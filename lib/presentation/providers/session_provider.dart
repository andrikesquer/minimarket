import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/core/encryption/secure_storage.dart';
import 'package:pos2/data/models/session_model.dart';

// State notifier
class SessionStateNotifier extends StateNotifier<SessionState> {
  SessionStateNotifier()
    : super(
        SessionState(
          status: Status.unknown,
          email: null,
          idSubscription: null,
        ),
      ) {
    _checkSession();
  }

  Future<void> _checkSession() async {
    final List<String?> credentials = await UserCredentials.getCredentials();

    final String? email = credentials[0];
    final int? idSubscription = int.tryParse(credentials[1] ?? '');

    if (email != null && idSubscription != null) {
      state = SessionState.authenticated(email, idSubscription);
    } else {
      state = SessionState.unauthenticated();
    }
  }

  Future<void> login(String email, int idSubscription) async {
    await UserCredentials.saveCredentials(email, idSubscription);
    state = SessionState.authenticated(email, idSubscription);
  }

  Future<void> logout() async {
    await UserCredentials.cleanCredentials();
    state = SessionState.unauthenticated();
  }
}

// State notifier provider
final sessionProvider =
    StateNotifierProvider<SessionStateNotifier, SessionState>((ref) {
      return SessionStateNotifier();
    });
