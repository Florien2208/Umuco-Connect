// lib/services/api_endpoints.dart
class ApiEndpoints {
  // Auth endpoints
  static const String login = '/api/v1/auth/login';
  static const String signup = '/api/v1/user/register';
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
  // Admin endpoints
  static const String getRole = '/api/v1/role';
  static const String adminRole = '/admin/reports';
}
