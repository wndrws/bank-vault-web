class UserService {
  int currentUserId = -1;
  String username = "";
  String password = "";

  void reset() {
    currentUserId = -1;
    username = "";
    password = "";
  }

  void setCredentials(final String user, final String pass) {
    username = user;
    password = pass;
  }
}