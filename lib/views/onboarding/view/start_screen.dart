import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../blocs/onboarding_cubit/onboarding_cubit.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/constructor_text_style.dart';
import '../../../consts/app_text_styles/onboarding_text_style.dart';
import '../../../consts/app_text_styles/settings_text_style.dart';
import '../../../util/app_routes.dart';
import '../../app/widgets/chosen_action_button_widget.dart';
import '../../app/widgets/input_widget.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  List<bool> _isSelected = [true, false, false, false];
  final _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size.height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                Text(
                  'Let\'s start',
                  style: SettingsTextStyle.title,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  'Which water transport you rent out?',
                  style: ConstructorTextStyle.lable,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                InputWidget(
                  controller: _nameController,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  'How many of them?',
                  style: ConstructorTextStyle.lable,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Column(
                    children: [
                      _buildPeriodOption("1-3", 0),
                      _buildPeriodOption("4-7", 1),
                      _buildPeriodOption("More than 7", 2),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                ChosenActionButton(
                  onTap: () {
                    if (_nameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Name cannot be empty')),
                      );
                    } else {
                      context.read<OnboardingCubit>().setFirstTime();
                      Navigator.pushReplacementNamed(context, AppRoutes.home);
                    }
                  },
                  text: 'Start',
                  backgroundColor: _nameController.text.isEmpty
                      ? AppColors.blueColor.withOpacity(0.25)
                      : AppColors.blueColor,
                ),
                SizedBox(
                  height: size.height * 0.27,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPeriodOption(String title, int index) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          setState(() {
            for (int i = 0; i < _isSelected.length; i++) {
              _isSelected[i] = (i == index);
            }
          });
        },
        child: Container(
          height: size.height * 0.075,
          decoration: BoxDecoration(
            color: AppColors.lightBrownColor,
            border: Border.all(
              color:
                  _isSelected[index] ? AppColors.blueColor : Colors.transparent,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(
              8.0,
            ),
          ),
          padding: EdgeInsets.all(2.0),
          child: Row(
            children: [
              SizedBox(
                width: size.width * 0.005,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: OnboardingTextStyle.description,
                  ),
                  SizedBox(
                    height: size.width * 0.01,
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
