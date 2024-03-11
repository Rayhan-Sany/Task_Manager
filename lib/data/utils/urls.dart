class Url{
  static String baseUrl='https://task.teamrabbil.com/api/v1';
  static String registrationUrl='$baseUrl/registration';
  static String logInUrl='$baseUrl/login';
  static String createTaskUrl='$baseUrl/createTask';
  static String taskStatusCountUrl='$baseUrl/taskStatusCount';
  static String taskCardDataByStatusUrl(String status)=>'$baseUrl/listTaskByStatus/$status';
  static String deleteTaskUrl(String taskId)=>'$baseUrl/deleteTask/$taskId';
  static String updateTaskStatusUrl(String taskId,String status)=>'$baseUrl/updateTaskStatus/$taskId/$status';
}