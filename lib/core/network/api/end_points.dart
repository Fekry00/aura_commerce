
class EndPoint {
  // Connected via adb reverse tcp:8000 tcp:8000 or Desktop/Web
  static const String baseUrl = "http://127.0.0.1:8000/api/v1/";

  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String refreshToken = "auth/refresh";
  static const String logout = "auth/logout";
  static const String changePassword = "auth/change-password";
  static const String forgotPassword = "auth/forgot-password";
  static const String verifyResetOtp = "auth/verify-reset-otp";
  static const String resetPassword = "auth/reset-password";
  static const String resendOtp = "auth/resend-otp";

  // Other features
  static const String products = "products";
  static const String categories = "categories";
  static const String banners = "banners";
  static const String cart = "cart";
  static const String home = "home";
  static const String favorites = "favorites";
  static const String wishlist = "favorites";
  static const String profile = "auth/me";
  static const String updateProfile = "profile";
  static const String updateAvatar = "profile/avatar";
  static const String deleteAvatar = "profile/avatar";
  static const String sendPhoneOtp = "profile/phone/send-otp";
  static const String verifyPhoneOtp = "profile/phone/verify-otp";
  static const String deleteAccount = "profile";
  static const String orders = "orders";
  static const String checkout = "checkout";
  static String categoryDetails(dynamic id) => "categories/$id";
}

class ApiKey {
  static const String token = "token";
  static const String authorization = "Authorization";
  static const String id = "id";
  static const String message = "message";
  static const String status = "status";
  static const String success = "success";
  static const String data = "data";
  static const String user = "user";
  static const String email = "email";
  static const String password = "password";
  static const String passwordConfirmation = "password_confirmation";
  static const String currentPassword = "current_password";
  static const String phone = "phone";
  static const String name = "name";
  static const String role = "role";
  static const String profileImage = "profile_image";
  static const String avatar = "avatar";
  static const String otp = "otp";
  static const String slug = "slug";
  static const String description = "description";
  static const String parentCategoryId = "parentCategoryId";
  static const String isActive = "isActive";
  static const String image = "image";
  static const String createdAt = "createdAt";
}
