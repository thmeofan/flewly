import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../blocs/rental_cubit/rental_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/constructor_text_style.dart';
import '../../../consts/app_text_styles/settings_text_style.dart';
import '../../../data/model/rental.dart';
import '../../app/widgets/chosen_action_button_widget.dart';
import '../../app/widgets/input_widget.dart';
import 'comments_screen.dart';

class RentalInfoScreen extends StatefulWidget {
  @override
  _RentalInfoScreenState createState() => _RentalInfoScreenState();
}

class _RentalInfoScreenState extends State<RentalInfoScreen> {
  final _typeController = TextEditingController();
  final _costController = TextEditingController();
  final _ownerController = TextEditingController();
  RentalPeriod _rentalPeriod = RentalPeriod.monthly;

  void _clearControllers() {
    _typeController.clear();
    _costController.clear();
    _ownerController.clear();
  }

  @override
  void dispose() {
    _typeController.dispose();
    _costController.dispose();
    _ownerController.dispose();
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
                  'Type of water transport',
                  style: ConstructorTextStyle.lable,
                ),
                SizedBox(height: size.height * 0.005),
                InputWidget(
                  controller: _typeController,
                ),
                SizedBox(height: size.height * 0.015),
                Text(
                  'Rental cost',
                  style: ConstructorTextStyle.lable,
                ),
                SizedBox(height: size.height * 0.005),
                InputWidget(
                  controller: _costController,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: size.height * 0.015),
                Text(
                  'Who rents from you?',
                  style: ConstructorTextStyle.lable,
                ),
                SizedBox(height: size.height * 0.005),
                InputWidget(
                  controller: _ownerController,
                ),
                SizedBox(height: size.height * 0.015),
                _buildRentalPeriodButtons(),
                SizedBox(height: size.height * 0.015),
                ChosenActionButton(
                  text: 'Next',
                  backgroundColor: _typeController.text.isEmpty &&
                          _costController.text.isEmpty &&
                          _ownerController.text.isEmpty
                      ? AppColors.blueColor.withOpacity(0.25)
                      : AppColors.blueColor,
                  onTap: () {
                    if (_typeController.text.isNotEmpty &&
                        _costController.text.isNotEmpty &&
                        _ownerController.text.isNotEmpty) {
                      final newRentalType = Rental(
                        type: _typeController.text,
                        cost: double.parse(_costController.text),
                        owner: _ownerController.text,
                        rentalPeriod: _rentalPeriod,
                      );
                      context.read<RentalCubit>().addRental(newRentalType);
                      _clearControllers();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CommentsScreen()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Please fill in all the fields and select a rental period before continuing.',
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
              child: _buildRentalPeriodButton(RentalPeriod.weekly),
            ),
            Expanded(
              child: _buildRentalPeriodButton(RentalPeriod.monthly),
            ),
            Expanded(
              child: _buildRentalPeriodButton(RentalPeriod.annually),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRentalPeriodButton(RentalPeriod rentalPeriod) {
    final isSelected = _rentalPeriod == rentalPeriod;
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.08,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: InkWell(
          onTap: () {
            setState(() {
              _rentalPeriod = rentalPeriod;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.lightBrownColor,
              border: Border.all(
                color: isSelected ? AppColors.blueColor : Colors.transparent,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(
                8.0,
              ),
            ),
            padding: EdgeInsets.all(4.0),
            child: Row(
              children: [
                SizedBox(width: size.width * 0.005),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      rentalPeriod.name,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: size.width * 0.01),
                  ],
                ),
                SizedBox(width: size.width * 0.005),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
