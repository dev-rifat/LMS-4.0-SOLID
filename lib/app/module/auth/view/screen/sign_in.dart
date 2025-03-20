import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lms_0_3/app/module/auth/auth_bindings/auth_bindings.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_layout.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../global/view/widget/custom_onloading.dart';
import '../../../../global/view/widget/custom_spacer.dart';
import '../../../../global/view/widget/cutom_component/custom_app_buttom.dart';
import '../../../../global/view/widget/cutom_component/margin_layout.dart';
import '../../controller/auth_controller.dart';
import '../widget/common_widget.dart';
import '../widget/sign_in_widget.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthBindings().dependencies();
   ResponsiveLayout.init(context);
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Padding(
          padding: marginLayout,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ///TitleText
                  _titleText(context),
                  customSpacerHeight(height: 30),
                  ///TextField body
                   const TextFieldLayout(),
                  customSpacerHeight(height: 4),

                  _forgotPassword(),

                  customSpacerHeight(height: 30),
                  ///Login button
                  Obx(() => _loginButtonLayout()),
                  customSpacerHeight(height: 24),
                  ///For guest button
                  guestButtonLayout(),
                  customSpacerHeight(height: 30),

                  ///For new register
                 _newUserCreate(context),
                  customSpacerHeight(height: 76),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _loginButtonLayout() {
    AuthController controller=Get.find<AuthController>();
    return CustomAppButton(
      text: "Login",
      widget: controller.isSignInLoading.value
          ? onLoading(color: AppColor.cardColor, isSize: .8)
          : Text(
              "Login",
              style: AppStyle.mid_large_text.copyWith(fontWeight: FontWeight.bold,fontSize: ResponsiveLayout.scaleText(Dimensions.fontSizeMid)),
            ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          controller.logIn(controller.emailController.text,controller.passwordController.text);
          GetStorage().write(AppString.USER_EMAIL,controller.emailController.text);
        }
      },
      buttonRadius: Dimensions.radiusDefault,
      buttonColor: AppColor.primaryColor,
    );
  }

  _titleText(context) {
    return titleTextLayout(

        titleText: "Sign in\nto your account",
        subText: "",
        context: context,
        subTitleText: "Welcome Back You've Been Missed!");
  }

  _newUserCreate(context) {
    return  createUserAccount(
        context: context,
        firstText: "New user? ",
        endText: AppString.text_sign_up,
        onAction: (){
          clearAuthTextField();
          Get.toNamed(Routes.SIGN_UP);
        }


    );
  }

  _forgotPassword() {
    return Row(
      children: [
        const Spacer(),
        GestureDetector(
            onTap: ()=>Get.toNamed(Routes.FORGOT_PASSWORD),
            child: Text("Forgot password?",style: AppStyle.normal_text_grey,))
      ],
    );
  }
}


