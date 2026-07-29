abstract class ApiConstants {
  static const String baseUrl = "https://supermarket-dan1.onrender.com/api/v1";
  static const String signUp = "/auth/signUp";
  static const String signIn = "/auth/signIn";
  static const String resetPassCode = "/auth/resetPassCode";
  static const String activeResetPass = "/auth/activeResetPass";
  static const String resetPassword = "/auth/resetPassword";
  static const String userData = "/portfoilo/userData";
  static const String addImage = "/portfoilo/addImage";
  static const String editUserData = "/portfoilo/editUserData";
  static const String searchProduct = "/home/productsFilter";
  static const String allProducts = "/home/products";
  static const String allCategories = "/home/categories";
  static const String getCart = "/user/getCart";
  static const String addCart = "/user/addCart";
  static const String deleteCart = "/user/deleteCart";
  static const String getFavorite = "/user/getFavorite";
  static const String addFavorite = "/user/addFavorite";
  static const String deleteFavorite = "/user/deleteFavorite";
  static const int pageLimit = 20;
  static const String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhNjBlYzgzNmViNWE4YTAwNGMyZjg0ZiIsImlhdCI6MTc4NDczNjk0NSwiZXhwIjoxNzg3MzI4OTQ1fQ.FEn4GrFuHchG1g1yGdAzd_WFUCE8pkvu-SmNRiH1QUk";
  static String productByCategory(String categorySlug) =>
      "/home/products/category/$categorySlug";

  static String productDetails(String id) => "/home/products/$id";
}
