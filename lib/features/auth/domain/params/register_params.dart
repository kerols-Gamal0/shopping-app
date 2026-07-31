class RegisterParams {
  const RegisterParams({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  final String name;
  final String phone;
  final String email;
  final String password;
  final String confirmPassword;
}