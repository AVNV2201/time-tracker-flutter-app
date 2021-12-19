class NetworkConstants{
  static const int TIMEOUT_TIME = 20;
}

class SPKeys{
  static const String ACTION_KEY = "action";
  static const String THEME_KEY = "theme";
}

class DBConstants{
  static const String DB_NAME = "testDb2.db";
  static const String ACTIVITY_TABLE_NAME = "Activity";
  static const String ACTION_TABLE_NAME = "Action";

  // create table statements
  static const String CREATE_ACTIVITY_TABLE = "CREATE TABLE $ACTIVITY_TABLE_NAME ("
      "id INTEGER PRIMARY KEY,"
      "parent_id INTEGER,"
      "name TEXT,"
      "created_at INTEGER,"
      "updated_at INTEGER,"
      "active BIT"
      ")";

  static const String CREATE_ACTION_TABLE = "CREATE TABLE $ACTION_TABLE_NAME ("
      "id INTEGER PRIMARY KEY,"
      "activity_id INTEGER,"
      "start INTEGER,"
      "end INTEGER"
      ")";
}

class ErrorMessage{
  static const String unknownError = 'Something went wrong! \nPlease try again !';
  static const String profileNotFound = 'No profile Found';
  static const String postNotFound = 'Post not Found';
  static const String connectionError = 'Unable to connect to Server';
  static const String noPostsFound = 'Nothing to show';
  static const String signInRequired = 'Not Signed In! Sign In Please';
  static const String noResultsFound = 'Sorry :( \nNo search results found';
}