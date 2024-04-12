import 'package:flewly/views/flight/widgets/flight_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/rental_cubit/rental_cubit.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/constructor_text_style.dart';
import '../../../consts/app_text_styles/home_screen_text_style.dart';
import '../../../consts/app_text_styles/settings_text_style.dart';
import '../../../data/model/news_model.dart';
import '../../../data/model/rental.dart';
import '../../../util/app_routes.dart';
import '../../app/widgets/chosen_action_button_widget.dart';
import '../../constructor/views/rental_info_screen.dart';
import 'transport_info_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FlightScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.greyColor,
          automaticallyImplyLeading: false,
        ),
        body: BlocBuilder<FlightModelCubit, List<FlightModel>>(
          builder: (context, rentalList) {
            if (rentalList.isEmpty) {
              return _buildEmptyState(context);
            }
            return buildFlightModelsList(context, rentalList);
          },
        ),
        floatingActionButton: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => FlightModelInfoScreen()),
            );
          },
          icon: SvgPicture.asset('assets/icons/plus.svg'),
        ));
  }

  Widget _buildEmptyState(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.greyColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: size.width * 0.03),
                Text(
                  'FLIGHTS',
                  style: SettingsTextStyle.title,
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              'assets/images/homescreen.svg',
              width: size.width * 0.9,
              height: size.height * 0.3,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              'There\'s no info'.toUpperCase(),
              style: HomeScreenTextStyle.emptyTitle,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
              'Add your new flight',
              style: HomeScreenTextStyle.emptySubtitle,
            ),
            Spacer(),
            // ChosenActionButton(
            //   text: 'Add Rental',
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (_) => FlightModelInfoScreen()),
            //     );
            //   },
            // ),
            SizedBox(height: size.height * 0.035),
          ],
        ),
      ),
    );
  }

  Widget buildFlightModelsList(
      BuildContext context, List<FlightModel> rentals) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.greyColor,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: rentals.length,
              itemBuilder: (context, index) {
                final rental = rentals[index];
                return FlightWidget(rental: rental);
              },
            ),
          ),
        ],
      ),
    );
  }
}
