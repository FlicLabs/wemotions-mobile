extension ExtString on String {
  bool get isValidUserName {
    final usernameRegExp = RegExp(
        r"^(?!.*?[_-]{2})[a-zA-Z](?!.*?[_-]$)(?!.*?[_.-]{2})[a-zA-Z0-9._-]{3,30}$");
    // r"^[a-zA-Z0-9](_(?!(\.|_))|\.(?!(_|\.))|[a-zA-Z0-9]){6,18}[a-zA-Z0-9]$");
    return usernameRegExp.hasMatch(this);
  }

  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp =
        RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(r'^.{6,}$');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidPin {
    final passwordRegExp = RegExp(r'^\d{6}$');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidWalletName {
    final passwordRegExp = RegExp(r"^\\w+'s Wallet$");
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidWalletAddress {
    final ethAddressRegExp = RegExp(r'^0x[a-fA-F0-9]{40}$');
    final solAddressRegExp = RegExp(r'^[1-9A-HJ-NP-Za-km-z]{32,44}$');
    return ethAddressRegExp.hasMatch(this) || solAddressRegExp.hasMatch(this);
  }
}
