import '../entities/account_entity.dart';

abstract class Authentication{
  Future<AccountEntity> auth(AuthenticationParams params); // Retorn a future, cuz it's async
}

class AuthenticationParams {
  final String email;
  final String password;

  AuthenticationParams({required this.email, required this.password});
}