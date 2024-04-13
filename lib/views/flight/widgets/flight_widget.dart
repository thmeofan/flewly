import 'package:flewly/data/model/flight_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/constructor_text_style.dart';
import '../../../util/app_routes.dart';
import '../views/flight_detailed_info_screen.dart';

class FlightWidget extends StatelessWidget {
  final FlightModel flight;

  const FlightWidget({
    required this.flight,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final formattedDate = DateFormat('MMM dd-yy').format(flight.date);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.flight);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FlightDetailedInfoScreen(flight: flight),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
                      Text(
                        flight.destination,
                        style: ConstructorTextStyle.inputText,
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/number.svg'),
                      SizedBox(width: size.width * 0.02),
                      Text(
                        flight.flightNumber.toString(),
                        style: ConstructorTextStyle.inputText,
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.01),
                      Text(
                        'Vacation',
                        style: ConstructorTextStyle.lable,
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'When',
                        style: ConstructorTextStyle.lable,
                      ),
                      SizedBox(width: size.width * 0.02),
                      SvgPicture.asset('assets/icons/where.svg'),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    formattedDate,
                    style: ConstructorTextStyle.date,
                  ),
                  SizedBox(height: size.height * 0.02),
                  Container(
                    width: size.width * 0.23,
                    height: size.height * 0.05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.blueColor,
                    ),
                    child: Center(
                        child: Text(
                      'More info',
                      style: ConstructorTextStyle.more,
                    )),
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
