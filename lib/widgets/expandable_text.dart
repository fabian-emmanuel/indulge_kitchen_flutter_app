import 'package:flutter/material.dart';
import 'package:indulge_kitchen/utils/colors.dart';
import 'package:indulge_kitchen/utils/dimensions.dart';
import 'package:indulge_kitchen/widgets/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalfOfText;
  late String secondHalfOfText;
  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight / 5.63;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalfOfText = widget.text.substring(0, textHeight.toInt());
      secondHalfOfText =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalfOfText = widget.text;
      secondHalfOfText = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalfOfText.isEmpty
          ? SmallText(
              text: firstHalfOfText,
              size: Dimensions.len16,
              height: 1.6,
              color: AppColors.paraColor)
          : Column(
              children: [
                SmallText(
                  size: Dimensions.len16,
                  color: AppColors.paraColor,
                  height: 1.6,
                  text: hiddenText
                      ? (firstHalfOfText + "...")
                      : firstHalfOfText + secondHalfOfText,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      hiddenText
                          ? SmallText(
                              size: Dimensions.len16,
                              text: "Show more",
                              color: AppColors.mainColor,
                            )
                          : SmallText(
                              size: Dimensions.len16,
                              text: "Show less",
                              color: AppColors.mainColor,
                            ),
                      hiddenText
                          ? const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: AppColors.mainColor,
                            )
                          : const Icon(
                              Icons.keyboard_arrow_up_sharp,
                              color: AppColors.mainColor,
                            ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
