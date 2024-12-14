import 'package:finalyearproject/utils/app_urls.dart';

class HomeViewmodel extends GetxController {

  RxInt currentIndex = 0.obs;

  //-------------------------Note-------------------------
  // - connection between children and items is 1-1
  // - number of children must be equal to number of items

  List<Widget> children = [

  ];

  List<BottomNavigationBarItem> items = [

  ];

  void onSelect(int value){
    currentIndex.value = value;
  }

}