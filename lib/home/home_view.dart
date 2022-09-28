import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  late HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(opacity: .5, image: AssetImage("assets/images/app_bar_pattern.png"), fit: BoxFit.fitWidth),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: kToolbarHeight * 2, child: Image.asset("assets/images/asi_logoo.png")),
              //      const Text("Asi Künefeleri"),
              const Text(
                "Koceli-Sakarya-Yalova Toptan Bayii",
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
          toolbarHeight: kToolbarHeight * 2.5,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildCarousel(context),
              _buildContact(context),
              const Divider(),
              const Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "CopyRight®2022 Tüm hakları saklıdır. \nGörseller Asi Künefeleri Ltd Şti'nin mülkündedir.\nİzinsiz kullanılamaz",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "MadeByMeWithFlutter",
                      style: TextStyle(fontSize: 10),
                    )),
              )
            ],
          ),
        ));
  }

  Widget _buildCarousel(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'Ürünlerimiz',
            style: TextStyle(
              fontFamily: "Sacramento",
              decoration: TextDecoration.underline,
              decorationThickness: 4,
              fontWeight: FontWeight.bold,
              fontSize: 45,
            ),
          ),
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(15)), border: Border.all(width: 2)),
            width: MediaQuery.of(context).size.width > 600 ? 600 : null,
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1024 / 540,
                  child: PageView.builder(
                    itemCount: viewModel.urunList.length,
                    // store this controller in a State to save the carousel scroll position
                    controller: viewModel.pageController,
                    onPageChanged: (index) {
                      print("index");
                      print(index);
                      viewModel.index = index;
                    },
                    padEnds: true,
                    itemBuilder: (BuildContext context, int itemIndex) {
                      return _buildCarouselItem(context, itemIndex);
                    },
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      viewModel.urunList[viewModel.index].adi!,
                      style: const TextStyle(
                        fontFamily: "Sacramento",
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.black,
                        shadows: [
                          Shadow(
                              // bottomLeft
                              offset: Offset(-1, -1),
                              color: Colors.white),
                          Shadow(
                              // topRight
                              offset: Offset(1, 1),
                              color: Colors.white),
                          Shadow(
                              // bottomRight
                              offset: Offset(1, -1),
                              color: Colors.white),
                          Shadow(
                              // topLeft
                              offset: Offset(-1, 1),
                              color: Colors.white), /* */
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Positioned(
                  top: getHalfOfHeight(context),
                  left: 0,
                  child: ChangePageButton(
                    onPressed: () {
                      viewModel.previousPage();
                    },
                  ),
                ),
                Positioned(
                  top: getHalfOfHeight(context),
                  right: 10,
                  child: ChangePageButton(
                    isLeft: false,
                    onPressed: () {
                      viewModel.nextPage();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselItem(BuildContext context, int itemIndex) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(viewModel.urunList[itemIndex].assetName!),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        ),
      ),
    );
  }

  double getHalfOfHeight(BuildContext context) {
    var width = MediaQuery.of(context).size.width > 600 ? 600 : MediaQuery.of(context).size.width;
    return ((width / 20) * 9) / 1.9;
  }

  Widget _buildContact(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(
            height: 70,
          ),
          const Text(
            "Sevkiyat ve Fiyat Bilgisi için",
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 10),
          ),
          const Text("İletişim",
              style: TextStyle(
                fontFamily: "Sacramento",
                decoration: TextDecoration.underline,
                decorationThickness: 4,
                fontWeight: FontWeight.bold,
                fontSize: 45,
              )),
          const Text(
            "Osman Nuri İBİŞ",
            style: TextStyle(fontSize: 20),
          ),
          const Text(
            "Telefon",
            style: TextStyle(fontSize: 20),
          ),
          const Text(
            "0534 283 2159",
            style: TextStyle(fontSize: 20),
          ),
          Wrap(
            spacing: 5,
            children: [
              IconButton(
                onPressed: () {
                  launchUrl(Uri(scheme: "tel", path: "+905342832159"), mode: LaunchMode.externalApplication);
                },
                icon: const Icon(Icons.call),
              ),
              IconButton(
                onPressed: () {
                  launchUrl(Uri.parse("https://wa.me/+905342832159"), mode: LaunchMode.externalApplication);
                },
                icon: const Icon(Icons.whatsapp),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ChangePageButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLeft;

  const ChangePageButton({Key? key, required this.onPressed, this.isLeft = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        color: Colors.black.withOpacity(.5),
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        icon: Center(
          child: Icon(
            isLeft ? Icons.arrow_circle_left_outlined : Icons.arrow_circle_right_outlined,
            size: 40,
          ),
        ));
  }
}

class ItemModel {
  int? index;
  String? adi;
  String? assetName;

  ItemModel({
    this.index,
    this.adi,
    this.assetName,
  });

  ItemModel copyWith({
    int? index,
    String? adi,
    String? assetName,
  }) {
    return ItemModel(
      index: index ?? this.index,
      adi: adi ?? this.adi,
      assetName: assetName ?? this.assetName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'index': index,
      'adi': adi,
      'assetName': assetName,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      index: map['index']?.toInt(),
      adi: map['adi'],
      assetName: map['assetName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) => ItemModel.fromMap(json.decode(source));

  @override
  String toString() => 'AssetsModel(index: $index, adi: $adi, assetName: $assetName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemModel && other.index == index && other.adi == adi && other.assetName == assetName;
  }

  @override
  int get hashCode => index.hashCode ^ adi.hashCode ^ assetName.hashCode;
}
