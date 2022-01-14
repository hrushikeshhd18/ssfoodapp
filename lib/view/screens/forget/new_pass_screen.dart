import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/user_controller.dart';
import 'package:efood_multivendor/data/model/response/userinfo_model.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/custom_app_bar.dart';
import 'package:efood_multivendor/view/base/custom_button.dart';
import 'package:efood_multivendor/view/base/custom_snackbar.dart';
import 'package:efood_multivendor/view/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPassScreen extends StatelessWidget {
  final String resetToken;
  final String number;
  final bool fromPasswordChange;
  NewPassScreen({@required this.resetToken, @required this.number, @required this.fromPasswordChange});

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: fromPasswordChange ? 'change_password'.tr : 'reset_password'.tr),
      body: SafeArea(child: Center(child: Scrollbar(child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: Center(child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: Column(children: [

          Text('enter_new_password'.tr, style: robotoRegular, textAlign: TextAlign.center),
          SizedBox(height: 50),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              color: Theme.of(context).cardColor,
              boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200], spreadRadius: 1, blurRadius: 5)],
            ),
            child: Column(children: [

              CustomTextField(
                hintText: 'new_password'.tr,
                controller: _newPasswordController,
                focusNode: _newPasswordFocus,
                nextFocus: _confirmPasswordFocus,
                inputType: TextInputType.visiblePassword,
                prefixIcon: Images.lock,
                isPassword: true,
                divider: true,
              ),

              CustomTextField(
                hintText: 'confirm_password'.tr,
                controller: _confirmPasswordController,
                focusNode: _confirmPasswordFocus,
                inputAction: TextInputAction.done,
                inputType: TextInputType.visiblePassword,
                prefixIcon: Images.lock,
                isPassword: true,
                onSubmit: (text) => GetPlatform.isWeb ? _resetPassword() : null,
              ),

            ]),
          ),
          SizedBox(height: 30),

          GetBuilder<UserController>(builder: (userController) {
            return GetBuilder<AuthController>(builder: (authBuilder) {
              return (!authBuilder.isLoading && !userController.isLoading) ? CustomButton(
                buttonText: 'done'.tr,
                onPressed: () => _resetPassword(),
              ) : Center(child: CircularProgressIndicator());
            });
          }),

        ]))),
      )))),
    );
  }

  void _resetPassword() {
    String _password = _newPasswordController.text.trim();
    String _confirmPassword = _confirmPasswordController.text.trim();
    if (_password.isEmpty) {
      showCustomSnackBar('enter_password'.tr);
    }else if (_password.length < 6) {
      showCustomSnackBar('password_should_be'.tr);
    }else if(_password != _confirmPassword) {
      showCustomSnackBar('confirm_password_does_not_matched'.tr);
    }else {
      if(fromPasswordChange) {
        UserInfoModel _user = Get.find<UserController>().userInfoModel;
        _user.password = _password;
        Get.find<UserController>().changePassword(_user).then((response) {
          showCustomSnackBar(response.message, isError: !response.isSuccess);
        });
      }else {
        Get.find<AuthController>().resetPassword(resetToken, '+'+number.trim(), _password, _confirmPassword).then((value) {
          if (value.isSuccess) {
            Get.find<AuthController>().login('+'+number.trim(), _password).then((value) async {
              Get.offAllNamed(RouteHelper.getAccessLocationRoute('reset-password'));
            });
          } else {
            showCustomSnackBar(value.message);
          }
        });
      }
    }
  }

}
