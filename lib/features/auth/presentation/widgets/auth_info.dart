import 'package:flutter/material.dart';

import '/core/theme/app_pallete.dart';

class AuthInfo extends StatelessWidget {
  final String text1;
  final String text2;
  final Function() route;

  const AuthInfo({
    super.key,
    required this.text1,
    required this.text2,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, route()),
      child: RichText(
        text: TextSpan(
          text: text1,
          style: Theme.of(context).textTheme.titleMedium,
          children: [
            TextSpan(
                text: text2,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppPallete.gradient2))
          ],
        ),
      ),
    );
  }
}
