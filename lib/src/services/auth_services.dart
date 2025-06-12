class AuthServices {
  static bool isLogged = false;

  static void login(){
    isLogged = true;
  }

  static void logout(){
    isLogged = false;
  }
}