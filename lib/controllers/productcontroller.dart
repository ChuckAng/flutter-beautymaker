import 'package:beautymaker/models/product_repo.dart';
import 'package:beautymaker/views/stackHomePage.dart';
import 'package:get/state_manager.dart';
import 'package:getxfire/getxfire.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  ProductsRepo productsRepo = ProductsRepo();
  RxBool isLoading = false.obs;
  List productList = [].obs;
  RxInt cartIem = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadProductsFromRepo();
    update();
  }

  loadProductsFromRepo() async {
    isLoading(true);
    productList = await productsRepo.loadProductsFromApi();
    isLoading(false);
  }

  void addIntoCart() {
    cartIem++;
    update();
  }
}
