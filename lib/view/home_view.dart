import 'package:finalyearproject/utils/app_urls.dart';
import 'package:finalyearproject/view_model/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  HomeViewmodel _viewmodel = Get.put(HomeViewmodel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _viewmodel.children[_viewmodel.currentIndex.value],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _viewmodel.onSelect,
        items: _viewmodel.items,
      ),
    );
  }
}
