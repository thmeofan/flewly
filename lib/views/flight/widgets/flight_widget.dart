import 'package:flewly/data/model/rental.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/constructor_text_style.dart';
import '../views/transport_info_screen.dart';

class FlightWidget extends StatelessWidget {
  final FlightModel rental;

  const FlightWidget({
    required this.rental,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransportInfoScreen(rental: rental),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.lightGreyColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/where.svg'),
                      SizedBox(width: size.width * 0.02),
                      Text(rental.destination),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/number.svg'),
                      SizedBox(width: size.width * 0.02),
                      Text(rental.flightNumber.toString()),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text('Vacation'),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Row(
                    children: [
                      Text('When'),
                      SizedBox(width: size.width * 0.02),
                      SvgPicture.asset('assets/icons/where.svg'),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(rental.date),
                  SizedBox(height: size.height * 0.02),
                  Container(
                    width: size.width * 0.23,
                    height: size.height * 0.05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.blueColor,
                    ),
                    child: Center(child: Text('More info')),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
