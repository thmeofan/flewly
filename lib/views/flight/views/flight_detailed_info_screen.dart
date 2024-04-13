import 'package:flewly/util/app_routes.dart';
import 'package:flewly/views/flight/widgets/flight_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../blocs/flight_cubit/flight_cubit.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/constructor_text_style.dart';
import '../../../consts/app_text_styles/settings_text_style.dart';
import '../../../data/model/flight_model.dart';
import '../../app/views/home_screen.dart';
import '../../app/widgets/output_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlightDetailedInfoScreen extends StatelessWidget {
  final FlightModel flight;

  const FlightDetailedInfoScreen({
    Key? key,
    required this.flight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          color: AppColors.greenColor,
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          },
          icon: SvgPicture.asset(
            'assets/icons/back.svg',
            color: AppColors.blueColor,
          ),
        ),
        backgroundColor: AppColors.greyColor,
        title: const Text(
          'Back',
          style: SettingsTextStyle.back,
        ),
        actions: [
          PopupMenuButton<String>(
              color: AppColors.lightGreyColor,
              iconColor: Colors.white,
              onSelected: (value) {
                if (value == 'delete') {
                  context.read<FlightCubit>().deleteFlight(flight);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HomeScreen(),
                    ),
                  );
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'delete',
                    child: Text(
                      'Delete',
                      style: ConstructorTextStyle.cost,
                    ),
                  ),
                ];
              }),
        ],
      ),
      body: Container(
        color: AppColors.greyColor,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: size.width * 0.03),
                Text(
                  'FLIGHT INFO',
                  style: SettingsTextStyle.title,
                ),
              ],
            ),
            SizedBox(height: size.height * 0.01),
            FlightWidget(flight: flight),
            SizedBox(height: size.height * 0.015),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: AppColors.lightGreyColor,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                  child: OutputWidget(
                    text: 'Travel budget',
                    leading: SvgPicture.asset('assets/icons/budget.svg'),
                    actions: [Text('${flight.travelBudget}\$')],
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.015),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'COMMENT',
                    style: ConstructorTextStyle.title,
                  ),
                  SizedBox(height: size.height * 0.005),
                  Container(
                    height: size.height * 0.2,
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.lightGreyColor,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.03),
                      child: Text(
                        flight.comment,
                        style: ConstructorTextStyle.inputText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.005),
          ],
        ),
      ),
    );
  }
}
