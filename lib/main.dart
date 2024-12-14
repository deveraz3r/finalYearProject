import 'package:finalyearproject/utils/routes/routes.dart';
import 'package:finalyearproject/utils/app_urls.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
      ),
      getPages: Routes.appRoutes(),
    );
  }
}

