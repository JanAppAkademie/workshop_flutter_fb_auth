/// Abstrakte Basisklasse für Authentifizierungsstatus
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

/// Anfangszustand der Authentifizierung
class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

/// Zustand während der Authentifizierung lädt
class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

// Zustand, wenn die Authentifizierung erfolgreich ist
class Authenticated extends AuthState {
  final String email;
  final String message;
  const Authenticated(
    this.message,
    this.email,
  );
  @override
  List<Object> get props => [email, message];
}

/// Zustand, wenn die Authentifizierung fehlgeschlagen ist
class Unauthenticated extends AuthState {
  @override
  List<Object> get props => [];
}

/// Zustand, wenn bei der Authentifizierung ein Fehler auftritt
class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}

/// Zustand, wenn eine Authentifizierungsanforderung gestellt wird
class AuthRequest extends AuthState {
  final String message;

  const AuthRequest(this.message);

  @override
  List<Object> get props => [message];
}
