import 'package:finalyearproject/utils/app_urls.dart';

class ReuseableElevatedbutton extends StatelessWidget {
  ReuseableElevatedbutton(
      {super.key, required this.buttonName, this.onPressed});

  final String buttonName;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () {},
      child: Container(
        width: double.infinity,
        height: 35,
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.primaryColor,
        ),
        child: Center(child: Text(buttonName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),)),
      ),
    );
  }
}

