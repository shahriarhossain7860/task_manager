class Urls {
  static const String _baseUrl = 'http://35.73.30.144:2005/api/v1';

  static const String registration = '$_baseUrl/registration';
  static const String login = '$_baseUrl/login';
  static const String addNewTask = '$_baseUrl/createTask';
  static const String newTaskList = '$_baseUrl/listTaskByStatus/New';
  static const String completedTaskList = '$_baseUrl/listTaskByStatus/Completed';
  static const String taskStatusCount = '$_baseUrl/taskStatusCount';
  static const String updateProfile = '$_baseUrl/profileUpdate';
  static const String CancelledTaskList = '$_baseUrl/listTaskByStatus/Cancelled';
  static const String ProgressTaskList = '$_baseUrl/listTaskByStatus/Progress';
  static const String verifyRecoverEmail = '$_baseUrl/RecoverVerifyEmail';
  static  String verifyOtp(String email,otp)=>'$_baseUrl/RecoverVerifyOtp/$email/$otp';

  static String changeStatus(String taskId, String status) =>
      '$_baseUrl/updateTaskStatus/$taskId/$status';

  static String deleteTask(String taskId) =>
      '$_baseUrl/deleteTask/$taskId';
}