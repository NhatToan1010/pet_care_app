import 'package:flutter/material.dart';

import '../../../../../common/widgets/images/circle_image.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../model/user_model.dart';

class MessageAppBar extends StatelessWidget {
  const MessageAppBar({
    super.key,
    required this.contactUser,
  });

  final UserModel contactUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // =---= Contact User Avatar
        CircleImage(
          width: 40,
          height: 40,
          fit: BoxFit.cover,
          imageUrl: contactUser.avatarURL!,
        ),
        SizedBox(width: AppSize.small),
        
        // =---= Contact User Name
        SectionHeading(
          title: contactUser.fullName,
          textColor: AppPallete.textWhite,
          showActionButton: false,
        ),
      ],
    );
  }
}
