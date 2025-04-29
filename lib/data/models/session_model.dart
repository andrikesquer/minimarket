enum Status { authenticated, unauthenticated, unknown }

class SessionState {
  final Status status;

  final String? email;

  final int? idSubscription;

  SessionState({
    required this.status,
    required this.email,
    required this.idSubscription,
  });

  factory SessionState.authenticated(String email, int idSubscription) {
    return SessionState(
      status: Status.authenticated,
      email: email,
      idSubscription: idSubscription,
    );
  }

  factory SessionState.unauthenticated() {
    return SessionState(
      status: Status.unauthenticated,
      email: null,
      idSubscription: null,
    );
  }

  factory SessionState.unknown() {
    return SessionState(
      status: Status.unknown,
      email: null,
      idSubscription: null,
    );
  }
}
