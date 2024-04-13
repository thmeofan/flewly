import 'package:flewly/views/flight/widgets/flight_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/flight_cubit/flight_cubit.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/home_screen_text_style.dart';
import '../../../consts/app_text_styles/settings_text_style.dart';
import '../../../data/model/flight_model.dart';
import '../../constructor/views/rental_info_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FlightScreen extends StatefulWidget {
  @override
  State<FlightScreen> createState() => _FlightScreenState();
}

class _FlightScreenState extends State<FlightScreen> {
  @override
  void initState() {
    super.initState();
    final flightCubit = context.read<FlightCubit>();
    flightCubit.loadFlights();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greyColor,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<FlightCubit, List<FlightModel>>(
        builder: (context, flightList) {
          if (flightList.isEmpty) {
            return _buildEmptyState(context);
          }
          return buildFlightModelsList(context, flightList);
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
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.greyColor,
      child: Column(
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
        ],
      ),
    );
  }

  Widget buildFlightModelsList(BuildContext context, List flightList) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.greyColor,
      child: Column(
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
          Expanded(
            child: ListView.builder(
              itemCount: flightList.length,
              itemBuilder: (context, index) {
                final flight = flightList[index];
                return FlightWidget(flight: flight);
              },
            ),
          ),
        ],
      ),
    );
  }
}
