import 'dart:developer';
import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lms_0_3/app/global/view/widget/custom_onloading.dart';
import 'package:lms_0_3/app/global/view/widget/error_message.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/dimensions.dart';
import '../../../../../../utils/utils.dart';
import '../../../../../global/view/widget/custom_spacer.dart';
import '../../../../../global/view/widget/cutom_component/custom_app_buttom.dart';
import '../../../../../global/view/widget/cutom_component/custom_title_text.dart';
import '../../../../../global/view/widget/cutom_component/cutom_input_field.dart';
import '../../../../enrolled_crouse/controller/my_crouse_controller.dart';
import '../../../controller/home_controller.dart';


class EnrollNowPage extends StatefulWidget {
  final AddCourseInfo addCourseInfo;
  const EnrollNowPage({
    super.key,
    required this.addCourseInfo,
  });

  @override
  _EnrollNowPageState createState() => _EnrollNowPageState();
}

class _EnrollNowPageState extends State<EnrollNowPage> {


  String _selectedPaymentMethod = 'PayPal';

  // List of available payment methods
  final List<Map<String, dynamic>> _paymentMethods = [
    {'method': 'PayPal', 'icon': Icons.account_balance_wallet},
  ];

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.addCourseInfo.title,
            style: AppStyle.title_text.copyWith(fontSize: Dimensions.fontSizeMid),
          ),
          leading: IconButton(onPressed: (){
            Get.find<MyCourseController>().getMyCourse();
            Get.back(canPop: false);
            Get.back(canPop: false);
          },icon: Icon(Icons.arrow_back),),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Course Title
              buildCustomTitleText(
                text: "Choose your payment method:",
                isHoldSeeMoreText: true,
              ),

              const SizedBox(height: 16),

              Obx(() => controller.isUserCouponLoading.isFalse
                  ? _couponLayout()
                  : const CircularProgressIndicator()),

              SizedBox(
                height: 100,
                child: ListView.builder(
                  itemCount: _paymentMethods.length,
                  itemBuilder: (context, index) {
                    return RadioListTile<String>(
                      title: _buildPaymentOption(_paymentMethods[index]),
                      value: _paymentMethods[index]['method'],
                      groupValue: _selectedPaymentMethod,
                      onChanged: (value) {
                        setState(() {
                          _selectedPaymentMethod = value!;
                        });
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              Get.find<HomeController>().isUseCoupon.isFalse
                  ? Text(
                      'Total Price: \$ ${double.parse(widget.addCourseInfo.price).toStringAsFixed(2)}',
                      style: AppStyle.normal_text_grey.copyWith(
                        color: AppColor.normalTextColor,
                      ),
                    )
                  : _disCountPrice(),




              const SizedBox(height: 48),

              // Action Buttons

              Obx(
                () => Get.find<MyCourseController>().isAddCourseLoading.isTrue
                    ? loadingIndicator()
                    : Row(
                        children: [
                          Expanded(
                            child: CustomAppButton(
                              buttonColor: AppColor.cardColor,
                              text: "Cancel",
                              btnBorderColor: AppColor.primaryColor,
                              buttonTextColor: AppColor.primaryColor,
                              buttonRadius: 8,
                              onPressed: () => Get.back(),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CustomAppButton(
                              buttonColor: AppColor.primaryColor,
                              text: "Next",
                              buttonRadius: 8,
                              onPressed: ()=>   _tabPaymentHandelar(),
                            ),
                          ),
                        ],
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build payment input fields
  Widget buildPaymentInputField({
    required String hint,
    required TextEditingController controller,
    required TextInputType inputType,
  }) {
    return SizedBox(
      height: 58,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: Colors.transparent,
        child: CustomInputField(
          hitText: hint,
          controller: controller,
          isHideLabelText: true,
          borderColor: Colors.transparent,
          hintStyle: AppStyle.normal_text_black.copyWith(
            color: AppColor.hintColor,
            fontSize: Dimensions.fontSizeDefault + 1,
          ),
          textInputType: inputType,
        ),
      ),
    );
  }

  _couponLayout() {
    if (Get.find<HomeController>().userCouponModel?.couponUser?.id == null) {
      return const SizedBox.shrink();
    }
    String validDate = DateFormat('d MMM yyyy').format(DateTime.parse(
        Get.find<HomeController>().userCouponModel?.couponUser?.expire ?? ""));

    return CouponCard(
      height: 100,
      backgroundColor: AppColor.primaryColor,
      curveAxis: Axis.vertical,
      firstChild: Container(
        color: AppColor.primaryColor,
        width: double.maxFinite,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Get.find<HomeController>().userCouponModel?.couponUser?.title ??
                  "",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      secondChild: Container(
        color: Colors.white,
        width: double.maxFinite,
        padding: const EdgeInsets.only(left: 14, top: 8, right: 14, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status : ${Get.find<HomeController>().userCouponModel?.couponUser?.status ?? ""}',
              style: AppStyle.title_text
                  .copyWith(color: AppColor.normalTextColor, fontSize: 15),
            ),
            Text(
              'Valid until: $validDate',
              style:
                  AppStyle.small_text.copyWith(color: AppColor.pendingBgColor),
            ),
            customSpacerHeight(height: 4),
            SizedBox(
              height: 34,
              child: CustomAppButton(
                buttonColor: AppColor.cardColor,
                text: "Use Coupon",
                btnTextStyle:
                    AppStyle.small_text.copyWith(color: AppColor.primaryColor),
                btnBorderColor: AppColor.primaryColor,
                buttonTextColor: AppColor.primaryColor,
                buttonRadius: 8,
                onPressed: () {
                  Get.find<HomeController>().isUseCoupon(true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _disCountPrice() {
    var controller = Get.find<HomeController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Price Information
        Text(
          'Original Price: \$ ${double.parse(widget.addCourseInfo.price)}',
          style: AppStyle.normal_text_grey.copyWith(
            color: AppColor.errorColor,
            decoration: TextDecoration.lineThrough,
          ),
        ),

        Text(
          'Discounted Price: \$ ${calculateDiscount(
            double.parse(widget.addCourseInfo.price),
            double.parse(
                controller.userCouponModel?.couponUser?.percentage.toString() ??
                    ""),
          )}',
          style:
              AppStyle.normal_text_grey.copyWith(color: AppColor.successColor),
        ),
      ],
    );
  }

  // Helper method to create payment method option
  Widget _buildPaymentOption(Map<String, dynamic> paymentMethod) {
    return Row(
      children: [
        Icon(paymentMethod['icon']),
        const SizedBox(width: 10),
        Text(
          paymentMethod['method'],
          style: AppStyle.small_text_grey.copyWith(
            color: AppColor.normalTextColor,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  void _tabPaymentHandelar() {


    String id =  widget.addCourseInfo.id;
    String price =  widget.addCourseInfo.price;
    String title =  widget.addCourseInfo.title;

// Navigate to the UsePaypal widget
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => UsePaypal(
          sandboxMode: true,
          clientId:
          "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
          secretKey:
          "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
          returnURL: "https://samplesite.com/return",
          cancelURL: "https://samplesite.com/cancel",
          transactions: [
            {
              "amount": {
                "total": price, // Use the dynamic price here
                "currency": "USD",
                "details": {
                  "subtotal": price,
                  "shipping": '0',
                  "shipping_discount": 0,
                },
              },
              "description": title, // Use the dynamic title here
              "item_list": {
                "items": [
                  {
                    "name": id, // Dynamic title
                    "quantity": 1,
                    "price": price, // Dynamic price
                    "currency": "USD",
                  },
                ],
                "shipping_address": {
                  "recipient_name": "Jane Foster",
                  "line1": "Travis County",
                  "line2": "",
                  "city": "Austin",
                  "country_code": "US",
                  "postal_code": "73301",
                  "phone": "+00000000",
                  "state": "Texas",
                },
              },
            },
          ],
          note: "Contact us for any questions on your order.",
            onSuccess: (Map params) async {
              log("onSuccess: $params");

              try {
                // Convert to a properly typed map
                final Map<String, dynamic> formattedParams = {
                  "payerID": params["payerID"],
                  "paymentId": params["paymentId"],
                  "token": params["token"],
                  "status": params["status"],
                  "data": {
                    "id": params["data"]["id"],
                    "intent": params["data"]["intent"],
                    "state": params["data"]["state"],
                    "cart": params["data"]["cart"],
                    "payer": {
                      "payment_method": params["data"]["payer"]["payment_method"],
                      "status": params["data"]["payer"]["status"],
                      "payer_info": {
                        "email": params["data"]["payer"]["payer_info"]["email"],
                        "first_name": params["data"]["payer"]["payer_info"]["first_name"],
                        "last_name": params["data"]["payer"]["payer_info"]["last_name"],
                        "payer_id": params["data"]["payer"]["payer_info"]["payer_id"],
                        "shipping_address": {
                          "recipient_name":
                          params["data"]["payer"]["payer_info"]["shipping_address"]
                          ["recipient_name"],
                          "line1": params["data"]["payer"]["payer_info"]["shipping_address"]
                          ["line1"],
                          "city": params["data"]["payer"]["payer_info"]["shipping_address"]
                          ["city"],
                          "state": params["data"]["payer"]["payer_info"]["shipping_address"]
                          ["state"],
                          "postal_code":
                          params["data"]["payer"]["payer_info"]["shipping_address"]
                          ["postal_code"],
                          "country_code":
                          params["data"]["payer"]["payer_info"]["shipping_address"]
                          ["country_code"],
                        }
                      }
                    },
                    "transactions": params["data"]["transactions"].map((transaction) {
                      return {
                        "amount": {
                          "total": transaction["amount"]["total"],
                          "currency": transaction["amount"]["currency"],
                          "details": {
                            "subtotal": transaction["amount"]["details"]["subtotal"],
                            "shipping": transaction["amount"]["details"]["shipping"],
                            "insurance": transaction["amount"]["details"]["insurance"],
                            "handling_fee": transaction["amount"]["details"]
                            ["handling_fee"],
                            "shipping_discount": transaction["amount"]["details"]
                            ["shipping_discount"],
                            "discount": transaction["amount"]["details"]["discount"],
                          }
                        },
                        "payee": {
                          "merchant_id": transaction["payee"]["merchant_id"],
                          "email": transaction["payee"]["email"]
                        },
                        "description": transaction["description"],
                        "item_list": {
                          "items": transaction["item_list"]["items"].map((item) {
                            return {
                              "name": item["name"],
                              "price": item["price"],
                              "currency": item["currency"],
                              "tax": item["tax"],
                              "quantity": item["quantity"],
                              "image_url": item["image_url"]
                            };
                          }).toList(),
                          "shipping_address": {
                            "recipient_name":
                            transaction["item_list"]["shipping_address"]
                            ["recipient_name"],
                            "line1": transaction["item_list"]["shipping_address"]["line1"],
                            "city": transaction["item_list"]["shipping_address"]["city"]
                          }
                        }
                      };
                    }).toList()
                  }
                };

                // Pass the formatted data
                Get.find<MyCourseController>().addPaypalPayment(formattedParams);

              } catch (e) {
                log("Error formatting PayPal response: $e");
              }
            },

            onError: (error) {
            print("onError: $error");
            showErrorMessage(message: error.toString());
          },
          onCancel: (params) {
            print('cancelled: $params');
          },
        ),
      ),
    );


  }
}

class AddCourseInfo {
  String id;
  String title;
  String coupon;
  String price;
  AddCourseInfo(
      {required this.id,
      required this.coupon,
      required this.price,
      required this.title});
}
Future<void> openBrowserUrl(String url) async {
  print("url : $url");

  var link=Uri.parse(url);
  if (!await launchUrl(link)) {
    throw Exception('Could not launch $link');
  }
}


Future<bool> _onWillPop() async {
  Get.find<MyCourseController>().getMyCourse();
  Get.back(canPop: false);
  Get.back(canPop: false);
  return false;
}