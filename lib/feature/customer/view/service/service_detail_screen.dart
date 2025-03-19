import 'package:flutter/material.dart';
import 'package:pet_care_app/common/widgets/custom_shapes/curved_edges/curved_edges.dart';
import 'package:pet_care_app/common/widgets/texts/section_heading.dart';
import 'package:pet_care_app/feature/customer/controller/service_controller.dart';
import 'package:pet_care_app/feature/customer/model/services/service_model.dart';
import 'package:pet_care_app/feature/customer/view/service/widgets/sections/service_booking_button.dart';
import 'package:pet_care_app/feature/customer/view/service/widgets/sections/service_date_time_selection.dart';
import 'package:pet_care_app/feature/customer/view/service/widgets/sections/service_description.dart';
import 'package:pet_care_app/feature/customer/view/service/widgets/sections/service_employee_selection.dart';
import 'package:pet_care_app/feature/customer/view/service/widgets/sections/service_image_display.dart';
import 'package:pet_care_app/feature/customer/view/service/widgets/sections/service_pet_size_selection.dart';
import 'package:pet_care_app/feature/customer/view/service/widgets/sections/service_rating_and_price.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';


class ServiceDetailScreen extends StatelessWidget {
  const ServiceDetailScreen({super.key, required this.service});

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    final serviceController = ServiceController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Service Image Display
            ClipPath(clipper: CustomCurvedEdges(), child: ServiceImageDisplay(service: service)),

            // --- Service Info Detail
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSize.defaultSpace, vertical: AppSize.small),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Title
                  SectionHeading(title: service.name, showActionButton: false, largeTitle: true),
                  SizedBox(height: AppSize.spaceBtwItems),

                  // --- Rating and Price
                  ServiceRatingAndPrice(service: service),

                  SizedBox(height: AppSize.small),
                  Divider(),
                  SizedBox(height: AppSize.small),

                  // --- Desciption
                  ServiceDescription(service: service),
                  SizedBox(height: AppSize.small),
                  Divider(),
                  SizedBox(height: AppSize.small),

                  // --- Service Selection
                  serviceController.routeService(service),
                  SizedBox(height: AppSize.spaceBtwItems),

                  // --- Date Time Selection
                  ServiceDateTimeSelection(),
                  SizedBox(height: AppSize.spaceBtwSections),

                  // --- Pet Size
                  ServicePetSizeSelection(service: service),
                  SizedBox(height: AppSize.spaceBtwSections),

                  // --- Employee Selection
                  ServiceEmployeeSelection(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ServiceBookingButton(service: service),
    );
  }
}
