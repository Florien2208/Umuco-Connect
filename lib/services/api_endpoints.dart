// lib/services/api_endpoints.dart
class ApiEndpoints {
  // Auth endpoints
  static const String login = '/auth/login';
  static const String signup = '/api/user/register';
  static const String logout = '/auth/logout';

  // User endpoints
  static const String userProfile = '/user/profile';
  static const String updateProfile = '/user/update';

  // Teacher endpoints
  static const String teacherClasses = '/teacher/classes';
  static const String teacherStudents = '/teacher/students';

  // Student endpoints
  static const String studentCourses = '/student/courses';
  static const String studentAssignments = '/student/assignments';

  // Admin endpoints
  static const String adminUsers = '/admin/users';
  static const String adminReports = '/admin/reports';
}
