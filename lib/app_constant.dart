class AppConstant {
  static const baseUrl = "http://38.242.150.215:8082/api/";
  static const getAllProduct = "${baseUrl}Book/Get";
  static const loginUrl = "${baseUrl}Auth/Login";
  static const registerUrl = "${baseUrl}Auth/Register";
  static const commentUrl = "${baseUrl}Comment/GetAll";
  static const addCommentUrl = "${baseUrl}Comment/Add";
  static const addRatingUrl = "${baseUrl}Rating/add/";
  static const getAllCategories = "${baseUrl}Category/Get";
  static const baseUrl2 = "https://book-backend-65sn.onrender.com";

  static const getCarouselData = "${baseUrl}Book/Carousel";
  static const imagesBase = "http://38.242.150.215:8082";

  static const updateCommentUrl = "${baseUrl}Comment/Update/";
  static const deleteCommentUrl = "${baseUrl}Comment/Delete/";
  static const getAllFavouriteUrl = "${baseUrl}Favorite/Get";
}
