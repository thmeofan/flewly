import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../blocs/rental_cubit/rental_cubit.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/constructor_text_style.dart';
import '../../../consts/app_text_styles/settings_text_style.dart';
import '../../../data/model/rental.dart';
import '../../app/views/home_screen.dart';
import '../../app/widgets/chosen_action_button_widget.dart';
import '../../app/widgets/input_widget.dart';

class CommentsScreen extends StatefulWidget {
  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final _budgetController = TextEditingController();
  final _commentController = TextEditingController();
  // RentalState _rentalState = RentalState.average;

  void _clearControllers() {
    _budgetController.clear();
    _commentController.clear();
  }

  @override
  void dispose() {
    _budgetController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
                SizedBox(height: size.height * 0.01),
                InputWidget(
                  svgAsset: 'assets/icons/budget.svg',
                  controller: _budgetController,
                  keyboardType: TextInputType.number,
                  label: 'Travel budget',
                ),
                SizedBox(height: size.height * 0.005),
                InputWidget(
                  svgAsset: 'assets/icons/comment.svg',
                  controller: _commentController,
                  label: 'Comment',
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                ChosenActionButton(
                  text: 'Next',
                  backgroundColor: _commentController.text.isEmpty
                      ? AppColors.blueColor.withOpacity(0.25)
                      : AppColors.blueColor,
                  onTap: () {
                    if (_commentController.text.isNotEmpty &&
                        _budgetController.text.isNotEmpty) {
                      final FlightModel updatedFlightModel = FlightModel(
                        comment: _commentController.text,
                        travelBudget: double.parse(_budgetController.text),
                      );

                      final rentalCubitState =
                          context.read<FlightModelCubit>().state;
                      final lastIndex = rentalCubitState.length - 1;

                      context
                          .read<FlightModelCubit>()
                          .updateRentedBoatList(lastIndex, updatedFlightModel);
                      _clearControllers();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Please enter a comment and travel budget before continuing.',
                            style: ConstructorTextStyle.snackBar,
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: size.height * 0.6,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
