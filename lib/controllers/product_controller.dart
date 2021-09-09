import 'package:beautymaker/models/product_repo.dart';
import 'package:beautymaker/services/user_info_firebase.dart';
import 'package:beautymaker/views/home_drawer_swap.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:getxfire/getxfire.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {

  ProductsRepo productsRepo = ProductsRepo();
  RxBool isLoading = false.obs;
  List productList = [].obs;
  RxInt cartItem = 0.obs;
  RxInt itemCount = 1.obs;
  RxBool isTicked = false.obs;
  


  @override
  void onInit() {
    super.onInit();
    loadProductsFromRepo();
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }

  loadProductsFromRepo() async {
    isLoading(true);
    productList = await productsRepo.loadProductsFromApi();
    isLoading(false);
  }

  void resetItemCount() {
    itemCount = RxInt(1);
    update();
  }

  void addIntoCart() {
    cartItem++;
    resetItemCount();
    update();
  }

  void addItem() {
    itemCount++;
    update();
  }

  void removeItem() {
    if (itemCount > 1) {
      itemCount--;
    } else {
      print("Must be more than 1");
    }

    update();
  }
}
