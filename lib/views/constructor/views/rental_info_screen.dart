import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../blocs/flight_cubit/flight_cubit.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/constructor_text_style.dart';

import '../../../consts/app_text_styles/settings_text_style.dart';
import '../../../data/model/flight_model.dart';
import '../../../util/shared_pref_service.dart';
import '../../app/widgets/chosen_action_button_widget.dart';
import '../../app/widgets/input_widget.dart';
import 'comments_screen.dart';

class FlightModelInfoScreen extends StatefulWidget {
  @override
  _FlightModelInfoScreenState createState() => _FlightModelInfoScreenState();
}

class _FlightModelInfoScreenState extends State<FlightModelInfoScreen> {
  final _dateController = TextEditingController();
  final _destinationController = TextEditingController();
  final _flightNumberController = TextEditingController();
  FlightType _selectedFlightType = FlightType.vacation;
  late SharedPrefService sharedPrefService;
  late FlightCubit flightCubit;

  @override
  void initState() {
    super.initState();
    sharedPrefService = SharedPrefService();
    flightCubit = FlightCubit(sharedPrefService);
  }

  void _clearControllers() {
    _dateController.clear();
    _destinationController.clear();
    _flightNumberController.clear();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _destinationController.dispose();
    _flightNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          color: AppColors.greenColor,
          onPressed: () {
            Navigator.pop(context);
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
      ),
      body: Container(
        color: AppColors.greyColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'New flight'.toUpperCase(),
                  style: SettingsTextStyle.title,
                ),
                SizedBox(height: size.height * 0.005),
                InputWidget(
                  svgAsset: 'assets/icons/when.svg',
                  controller: _dateController,
                  keyboardType: TextInputType.number,
                  label: 'When (dd.mm.yyyy)',
                ),
                SizedBox(height: size.height * 0.015),
                InputWidget(
                  svgAsset: 'assets/icons/where.svg',
                  controller: _destinationController,
                  label: 'Where',
                ),
                SizedBox(height: size.height * 0.015),
                InputWidget(
                  svgAsset: 'assets/icons/number.svg',
                  controller: _flightNumberController,
                  keyboardType: TextInputType.number,
                  label: 'Flight number',
                ),
                SizedBox(height: size.height * 0.015),
                _buildRentalPeriodButtons(),
                SizedBox(height: size.height * 0.015),
                ChosenActionButton(
                  text: 'Next',
                  backgroundColor: _dateController.text.isEmpty ||
                          _destinationController.text.isEmpty ||
                          _flightNumberController.text.isEmpty
                      ? AppColors.blueColor.withOpacity(0.25)
                      : AppColors.blueColor,
                  onTap: () {
                    if (_dateController.text.isNotEmpty &&
                        _destinationController.text.isNotEmpty &&
                        _flightNumberController.text.isNotEmpty) {
                      DateTime date =
                          DateFormat('dd.MM.yyyy').parse(_dateController.text);
                      double flightNumber =
                          double.parse(_flightNumberController.text);

                      FlightModel newFlightModel = FlightModel(
                        date: date,
                        destination: _destinationController.text,
                        flightNumber: flightNumber,
                      );

                      flightCubit.updateFlight(newFlightModel,
                          isNewFlight: true);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentsScreen(
                            flightModel: newFlightModel,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Please enter all the information and make sure that date is in dd.mm.yyyy format',
                            style: ConstructorTextStyle.snackBar,
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: size.height * 0.3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRentalPeriodButtons() {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How often payment is made?',
          style: ConstructorTextStyle.lable,
        ),
        SizedBox(height: size.height * 0.015),
        Row(
          children: [
            Expanded(
              child: _buildPeriodOption('Vacation', FlightType.vacation),
            ),
            Expanded(
              child: _buildPeriodOption('Work', FlightType.work),
            ),
            Expanded(
              child: _buildPeriodOption('Other', FlightType.other),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPeriodOption(String title, FlightType flightType) {
    final size = MediaQuery.of(context).size;
    final isSelected = flightType == _selectedFlightType;

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedFlightType = flightType;
          });
        },
        child: Container(
          height: size.height * 0.075,
          width: size.width * 0.295,
          decoration: BoxDecoration(
            color: AppColors.lightGreyColor,
            border: Border.all(
              color: isSelected ? AppColors.blueColor : Colors.transparent,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.all(2.0),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: ConstructorTextStyle.inputText,
                  ),
                  SizedBox(height: size.width * 0.01),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
