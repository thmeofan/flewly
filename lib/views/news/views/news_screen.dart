import 'package:flutter/material.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/settings_text_style.dart';
import '../../../data/model/news_model.dart';
import '../widgets/news_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key, required this.newsModel});

  final List<NewsModel> newsModel;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.greyColor,
        ),
        body: Container(
          color: AppColors.greyColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'NEWS',
                style: SettingsTextStyle.title,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: newsModel.length,
                  itemBuilder: (BuildContext context, int index) {
                    return NewsWidget(newsModel: newsModel[index]);
                  },
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
            ]),
          ),
        ));
  }
}
