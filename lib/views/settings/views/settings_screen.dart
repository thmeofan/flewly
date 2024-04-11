import 'package:flewly/views/settings/widgets/ios_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/settings_text_style.dart';
import '../../app/views/my_in_app_web_view.dart';
import '../../app/widgets/chosen_action_button_widget.dart';
import '../widgets/settings_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool isSwitched = false;
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: size.height * 0.1,
              ),
              Text(
                'Settings',
                style: SettingsTextStyle.title,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                width: size.width * 0.95,
                decoration: BoxDecoration(
                  color: AppColors.lightBrownColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/images/settings.svg'),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      Text(
                        'Your opinion is important!',
                        style: SettingsTextStyle.bannerTitle,
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      Text(
                        'We need your feedback to get better',
                        style: SettingsTextStyle.bannerSubTitle,
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      ChosenActionButton(
                        text: 'Rate app',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyScreenForVIew(
                                  url: 'https://google.com/'),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              SettingsTile(
                  text: 'Privacy Policy',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const MyScreenForVIew(url: 'https://google.com/'),
                      ),
                    );
                  },
                  assetName: 'assets/icons/privacy.svg'),
              SizedBox(
                height: size.height * 0.01,
              ),
              SettingsTile(
                  text: 'Support page',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const MyScreenForVIew(url: 'https://google.com/'),
                      ),
                    );
                  },
                  action: IOSStyleToggle(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                  ),
                  assetName: 'assets/icons/notification.svg'),
              SizedBox(
                height: size.height * 0.01,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
