import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      backgroundColor: WidgetStatePropertyAll(AppPallete.whiteColor),
      side: WidgetStatePropertyAll(
        BorderSide(color: AppPallete.blackColor, strokeAlign: 1),
      ),
      leading: Text('Tìm Kiếm ...'),
      trailing: [
        Icon(Icons.search),
      ],
    );
  }
}