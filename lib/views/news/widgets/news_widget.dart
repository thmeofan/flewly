import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/news_text_style.dart';
import '../../../data/model/news_model.dart';
import '../../../util/app_routes.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({super.key, required this.newsModel});

  final NewsModel newsModel;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(AppRoutes.article, arguments: newsModel);
        },
        child: Container(
          height: screenSize.height * 0.18,
          width: screenSize.width * 0.98,
          padding: EdgeInsets.symmetric(vertical: screenSize.width * 0.01),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: AppColors.lightGreyColor,
          ),
          child: Row(
            children: [
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: screenSize.width * 0.01,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: FancyShimmerImage(
                    width: screenSize.width * 0.35,
                    height: screenSize.width * 0.35,
                    boxFit: BoxFit.cover,
                    imageUrl: newsModel.imageUrl,
                  ),
                ),
              ),
              // SizedBox(
              //   height: screenSize.height * 0.01,
              // ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: screenSize.width * 0.01,
                    right: screenSize.width * 0.005,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        newsModel.title,
                        style: NewsTextStyle.title,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: screenSize.height * 0.0025,
                      ),
                      Text(
                        newsModel.text,
                        style: NewsTextStyle.preview,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: screenSize.height * 0.005,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
