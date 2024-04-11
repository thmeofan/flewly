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
  final _commentController = TextEditingController();
  RentalState _rentalState = RentalState.average;
  void _clearControllers() {
    _commentController.clear();
  }

  @override
  void dispose() {
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
        backgroundColor: AppColors.brownColor,
        title: const Text(
          'Back',
          style: SettingsTextStyle.back,
        ),
      ),
      body: Container(
        color: AppColors.brownColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'New transport',
                  style: SettingsTextStyle.title,
                ),
                SizedBox(height: size.height * 0.01),
                Text(
                  'Write a comment about water transport',
                  style: ConstructorTextStyle.lable,
                ),
                SizedBox(height: size.height * 0.005),
                InputWidget(
                  controller: _commentController,
                ),
                const SizedBox(height: 16.0),
                _buildRentalStateButtons(
                  title: 'Rental State:',
                  options:
                      RentalState.values.map((state) => state.name).toList(),
                  onOptionSelected: (selectedState) {
                    setState(() {
                      _rentalState = RentalState.values.byName(selectedState);
                    });
                  },
                  selectedOption: _rentalState.name,
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
                    if (_commentController.text.isNotEmpty) {
                      final rentalCubitState =
                          context.read<RentalCubit>().state;

                      if (rentalCubitState.isNotEmpty) {
                        final updatedRental = rentalCubitState.last.copyWith(
                          comment: _commentController.text,
                          state: _rentalState,
                        );

                        context.read<RentalCubit>().updateRentedBoatList([
                          ...rentalCubitState.sublist(
                              0, rentalCubitState.length - 1),
                          updatedRental,
                        ]);

                        _clearControllers();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HomeScreen(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'No rentals found. Please add a rental before continuing.',
                              style: ConstructorTextStyle.snackBar,
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Please enter a comment before continuing.',
                            style: ConstructorTextStyle.snackBar,
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: size.height * 0.3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRentalStateButtons({
    required String title,
    required List<String> options,
    required Function(String) onOptionSelected,
    String? selectedOption,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: ConstructorTextStyle.lable,
        ),
        const SizedBox(height: 8.0),
        Column(
          children: options.map((option) {
            final isSelected = selectedOption == option;
            final size = MediaQuery.of(context).size;
            Color circleColor = AppColors.greenColor;

            switch (option) {
              case 'perfect':
                circleColor = AppColors.greenColor;
                break;
              case 'average':
                circleColor = AppColors.orangeColor;
                break;
              case 'bad':
                circleColor = AppColors.redColor;
                break;
              default:
                circleColor = AppColors.greenColor;
                break;
            }

            return SizedBox(
              height: size.height * 0.08,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: InkWell(
                  onTap: () {
                    onOptionSelected(option);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightBrownColor,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.blueColor
                            : Colors.transparent,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        SizedBox(width: size.width * 0.005),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              option,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: size.width * 0.01),
                          ],
                        ),
                        Spacer(),
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: circleColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: size.width * 0.005),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
