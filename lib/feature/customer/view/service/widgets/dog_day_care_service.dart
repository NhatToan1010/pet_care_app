import 'package:flutter/material.dart';
import 'package:pet_care_app/feature/customer/model/services/service_model.dart';

import '../../../controller/service_controller.dart';
import '../../../model/services/dog_day_care.dart';

class DogDayCareService extends StatelessWidget {
  const DogDayCareService({super.key, required this.service});

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        ],
      ),
    );
  }
}
