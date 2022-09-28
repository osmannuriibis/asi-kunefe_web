import 'package:asi_kunefe_web/home/home_view.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  var pageController = PageController(viewportFraction: 1);

  int _index = 0;

  int get index => _index;

  set index(int index) {
    _index = index;
    notifyListeners();
  }

  List<ItemModel> get urunList => [
        ItemModel(index: 0, adi: "Künefe", assetName: "assets/images/kunefe.jpg"),
        ItemModel(index: 1, adi: "Katmer", assetName: "assets/images/katmer.jpg"),
        ItemModel(index: 2, adi: "Fıstıklı Künefe", assetName: "assets/images/fistikli_kunefe.jpg"),
        ItemModel(index: 3, adi: "Fıstıklı Kadayıf", assetName: "assets/images/fistikli_kadayif.jpg"),
        ItemModel(index: 4, adi: "Sufle", assetName: "assets/images/sufle.jpg"),
        ItemModel(index: 5, adi: "İçli Köfte", assetName: "assets/images/icli_kofte.jpg"),
        ItemModel(index: 6, adi: "Çekilmiş Antep Fıstığı", assetName: "assets/images/fistik.jpg"),
      ];

  nextPage() {
    if (index == urunList.length - 1) {
      pageController.animateToPage(0, duration: const Duration(milliseconds: 600), curve: Curves.bounceIn);
    } else {
      pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.bounceIn);
    }
  }

  void previousPage() {
    if (index == 0) {
      pageController.animateToPage(urunList.length - 1, duration: const Duration(milliseconds: 600), curve: Curves.bounceIn);
    } else {
      pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.bounceIn);
    }
  }
}
