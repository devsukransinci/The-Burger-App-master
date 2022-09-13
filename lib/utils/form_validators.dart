validateName(String? value) {
  {
    if (value!.isNotEmpty) {
      return null;
    } else {
      return 'Enter a valid Name';
    }
  }
}

validateEmail(String? value) {
  if (value!.isNotEmpty && value.contains('@') && value.length > 8) {
    return null;
  } else if (value.length < 8) {
    return 'A valid email will be atleast 8 charachters long!';
  } else {
    return 'Enter a valid email id';
  }
}

validatePassword(String? value) {
  if (value!.isEmpty) {
    return 'Enter a valid password';
  } else if (value.length < 8) {
    return 'password should be atleast 8 charachters long!';
  } else {
    return null;
  }
}

validatePhone(String? value) {
  if (value!.isEmpty ) {
    return 'Enter a valid Phone number';
  } else if (value.length != 10) {
    return 'Phone number should be 10 Digits';
  } else {
    return null;
  }
}
