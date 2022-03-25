class EmployeeEmailRequest {
  final String email;
  EmployeeEmailRequest(
    this.email,
  );

  Map<String, String> toMap() => {
    'email':'email'
  };
}
