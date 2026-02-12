import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:video_poc/config/app_config.dart';
import 'package:video_poc/ui/common/app_colors.dart';
import 'package:video_poc/ui/common/ui_helpers.dart';
import 'package:video_poc/ui/widgets/button/rounded_button.dart';
import 'package:video_poc/ui/widgets/general/custom_layout.dart';
import 'package:video_poc/ui/widgets/responsive/responsive_text.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Video POC'),
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
          child: ScrollableColumn(
            padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 24.sp),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ResponsiveText.w600(
                'Call Settings',
                fontSize: 16,
                color: k4D4D4D,
              ),
              verticalSpaceSmall,
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.sp,
                  vertical: 12.sp,
                ),
                decoration: BoxDecoration(
                  color: kEAEAEA,
                  borderRadius: k12pxBorderRadius,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.lock_clock, color: k4D4D4D),
                        horizontalSpaceSmall,
                        Expanded(
                          child: ResponsiveText.w500(
                            'Session: ${model.sessionName}',
                            fontSize: 14,
                            color: k4D4D4D,
                          ),
                        ),
                      ],
                    ),
                    verticalSpaceTiny,
                    ResponsiveText.w400(
                      'Backend: ${AppConfig.apiBaseUrl}',
                      fontSize: 12,
                      color: k4D4D4D,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              verticalSpaceSmall,
              TextFormField(
                initialValue: model.userId,
                decoration: const InputDecoration(
                  labelText: 'User ID',
                  border: OutlineInputBorder(),
                ),
                onChanged: model.updateUserId,
              ),
              verticalSpaceSmall,
              RoundedButton(
                text: 'Start Video Call',
                color: kPrimaryColor,
                onPressed: model.startVideoCall,
              ),
              verticalSpaceMedium,
            ],
          ),
        ),
      ),
    );
  }
}
