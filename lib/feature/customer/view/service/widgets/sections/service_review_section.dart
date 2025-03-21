import 'package:flutter/material.dart';

import '../../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../../controller/review_controller.dart';
import '../../../../model/services/service_model.dart';

class ServiceReviewSection extends StatelessWidget {
  const ServiceReviewSection({
    super.key,
    required this.service,
  });

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    final reviewController = ReviewController.instance;

    return FutureBuilder(
      future: reviewController.getReviewsByService(service.id),
      builder: (context, snapshot) {
        final respone = CloudHelperFunctions.checkSingleStateRecord(snapshot: snapshot);
        if (respone != null) return respone;

        final listReview = snapshot.data!;

        return ListView.separated(
          shrinkWrap: true,
          itemCount: listReview.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            final review = listReview[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(
                  review.avatar ?? 'assets/images/customers/default_avatar.jpg',
                ),
              ),
              title: Text(review.userName),
              subtitle: Text(review.comment),
              trailing: Row(
                children: [
                  Icon(Icons.star_rounded, color: Colors.amber, size: 24),
                  Text(' ${review.ratingScore.toString()}'),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
