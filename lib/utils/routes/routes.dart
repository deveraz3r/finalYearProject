import 'package:finalyearproject/utils/app_urls.dart';
import 'package:finalyearproject/view/home_view.dart';

class Routes {

  static appRoutes() => [
      GetPage(name: RoutesName.home, page: () => HomeView()),
  ];

}