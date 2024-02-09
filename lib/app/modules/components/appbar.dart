import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:share_novel/app/modules/utils/color_constant.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final String lottieAssetPath;
  final IconData? icon;
  final void Function()? onIconPressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.backgroundColor,
    required this.lottieAssetPath,
    this.icon,
    this.onIconPressed,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Row(
          children: [
            if (icon != null && onIconPressed != null)
              IconButton(
                icon: Icon(icon),
                onPressed: onIconPressed,
              ),
            Lottie.asset(
              lottieAssetPath,
              height: 40,
              width: 40,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorConstant.DarkPrimary,
                fontSize: 18.0,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
