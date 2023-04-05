bool isFullNameValid(String fullName) {
  return fullName.isNotEmpty && fullName.length >= 3;
}

bool isValidEmail(String email) {
  return email.isNotEmpty && email.contains('@');
}

bool isValidPassword(String password) {
  return password.isNotEmpty && password.length >= 6;
}
