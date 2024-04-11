import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/rental_cubit/rental_cubit.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/constructor_text_style.dart';
import '../../../consts/app_text_styles/home_screen_text_style.dart';
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
        backgroundColor: AppColors.brownColor,
        leadingWidth: size.width * 0.3,
        leading: TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.profile);
          },
          child: const Text('Settings', style: HomeScreenTextStyle.appbar),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.news, arguments: news);
            },
            child: const Text('News', style: HomeScreenTextStyle.appbar),
          ),
        ],
      ),
      body: BlocBuilder<RentalCubit, List<Rental>>(
        builder: (context, rentalList) {
          if (rentalList.isEmpty) {
            return _buildEmptyState(context);
          }
          return buildRentalsList(context, rentalList);
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.brownColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              'There\'s no info',
              style: HomeScreenTextStyle.emptyTitle,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
              'To add your first water transport\nclick on the button below',
              style: HomeScreenTextStyle.emptySubtitle,
            ),
            Spacer(),
            ChosenActionButton(
              text: 'Add Rental',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RentalInfoScreen()),
                );
              },
            ),
            SizedBox(height: size.height * 0.035),
          ],
        ),
      ),
    );
  }

  Widget buildRentalsList(BuildContext context, List<Rental> rentals) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.brownColor,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: rentals.length,
              itemBuilder: (context, index) {
                final rental = rentals[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TransportInfoScreen(rental: rental),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    color: AppColors.lightBrownColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                rental.type,
                                style: ConstructorTextStyle.typeName,
                              ),
                              Spacer(),
                              SvgPicture.asset('assets/icons/arrow.svg'),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                '${rental.cost.toStringAsFixed(2)}\$ ${rental.rentalPeriod.name}',
                                style: ConstructorTextStyle.cost,
                              ),
                              Spacer(),
                              Wrap(
                                spacing: 8,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.brownColor,
                                    ),
                                    child: Text(
                                      rental.state.name,
                                      style: _getTextStyleBasedOnRentalState(
                                          rental.state.name),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          ChosenActionButton(
            text: 'Add new transport',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RentalInfoScreen()),
              );
            },
          ),
          SizedBox(
            height: size.height * 0.03,
          )
        ],
      ),
    );
  }

  TextStyle _getTextStyleBasedOnRentalState(String rentalState) {
    switch (rentalState.toLowerCase()) {
      case 'perfect':
        return HomeScreenTextStyle.typePerfect;
      case 'average':
        return HomeScreenTextStyle.typeAverage;
      case 'bad':
        return HomeScreenTextStyle.typeBad;
      default:
        return HomeScreenTextStyle.typeAverage;
    }
  }
}
