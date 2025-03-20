import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lms_0_3/app/global/view/widget/custom_onloading.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/dimensions.dart';
import '../../../controller/home_controller.dart';


class PaymentHistoryScreen extends GetView<HomeController> {
  const PaymentHistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
       title: Text(
         "Payment History",
         style:
         AppStyle.title_text.copyWith(fontSize: Dimensions.fontSizeMid),
       ),

      ),

      body: Obx(()=>controller.isPaymentHistoryLoading.isTrue?loadingIndicator():Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: controller.paymentHistoryModel?.enrollments?.length??0,
          itemBuilder: (context, index){
            var transaction=controller.paymentHistoryModel?.enrollments?[index];
            return Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Left Section (Name and Date)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transaction?.course?.title??"",
                          style: AppStyle.normal_text_grey.copyWith(color: AppColor.normalTextColor),
                        ),
                        const SizedBox(height: 12),
                        Text("Status:   ",style: AppStyle.small_text.copyWith(color: AppColor.hintColor,fontSize: 13),),
                        const SizedBox(height: 4),

                        Text("Enrollment date:   ",style: AppStyle.small_text.copyWith(color: AppColor.hintColor,fontSize: 13),),
                        const SizedBox(height: 4),

                        Text("Expire date:   ",style: AppStyle.small_text.copyWith(color: AppColor.hintColor,fontSize: 13),),
                      ],
                    ),

                    // Right Section (Amount and Status)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "\$${double.parse(transaction?.price.toString()??"").toStringAsFixed(2)}",
                            style:AppStyle.normal_text_grey.copyWith(color: AppColor.normalTextColor),

                          ),
                          const SizedBox(height: 12),
                          Text(
                            transaction?.status??"",
                            maxLines: 1,
                            style: AppStyle.normal_text_grey.copyWith(color: AppColor.successColor,overflow: TextOverflow.ellipsis),
                          ),
                          const SizedBox(height: 4),

                          Text(
                            DateFormat.yMMMd().format(DateTime.parse(transaction?.enrollmentDate??"")),
                            style: const TextStyle(color: Colors.orange),
                          ),
                          const SizedBox(height: 4),

                          Text(
                            DateFormat.yMMMd().format(DateTime.parse(transaction?.expire??"")),
                            style: const TextStyle(color: Colors.red),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      )),

    );
  }
}
