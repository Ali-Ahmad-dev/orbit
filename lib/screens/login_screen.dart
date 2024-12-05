import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/config/config_keys_body.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/constants/validations/validation_string.dart';
import 'package:orbit/controllers/login_controller.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/custom_button.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import 'package:orbit/widgets/textformfield.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    final mLocaleData = OrbitClientApp.mLocale[ConfigKeysTitle.loginScreen];
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Colors.purple.shade900,
                Colors.purple.shade800,
                Colors.purpleAccent.shade700,
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: height * 0.1),
                _buildTitle(mLocaleData, width, height),
                SizedBox(height: height * 0.02),
                _buildLoginForm(mLocaleData, width, height),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(
      Map<String, dynamic>? mLocaleData, double width, double height) {
    return Padding(
      padding: EdgeInsets.all(width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Animate(
            child: HrAppText(
              text: mLocaleData![ConfigKeysBody.loginTitle]!,
              style: const TextStyle(color: Colors.white60, fontSize: 40),
            ),
          ).fade(duration: const Duration(milliseconds: 500)),
          SizedBox(height: height * 0.01),
        ],
      ),
    );
  }

  Widget _buildLoginForm(
      Map<String, dynamic>? mLocaleData, double width, double height) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60),
          topRight: Radius.circular(60),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: height * 0.02),
          _buildLoginHeaderText(mLocaleData),
          _buildLoginFormFields(mLocaleData, width, height),
        ],
      ),
    );
  }

  Widget _buildLoginHeaderText(Map<String, dynamic>? mLocaleData) {
    return Animate(
      child: HrAppText(
        text: mLocaleData![ConfigKeysBody.bodyLogin1]!,
        style: const TextStyle(
          color: Color.fromARGB(255, 100, 79, 104),
          fontSize: 28,
        ),
      ),
    ).fadeIn().blurXY(begin: 0.2, end: 0.3);
  }

  Widget _buildLoginFormFields(
      Map<String, dynamic>? mLocaleData, double width, double height) {
    return Form(
      key: controller.formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.06),
        child: Column(
          children: [
            SizedBox(height: height * 0.08),
            _buildEmailField(mLocaleData),
            SizedBox(height: height * 0.02),
            _buildPasswordField(mLocaleData),
            SizedBox(height: height * 0.04),
            _buildErrorMessage(height),
            _buildLoginButton(height),
            SizedBox(height: height * 0.08),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField(Map<String, dynamic>? mLocaleData) {
    return HrAppTextFormField(
      controller: controller.emailAddressController,
      hintText: mLocaleData![ConfigKeysBody.emailAddress]!,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return ValidationString.email;
        }
        String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
        RegExp regex = RegExp(pattern);
        if (!regex.hasMatch(value)) {
          return ValidationString.email;
        }
        return null;
      },
      prefixIcon: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.email, color: Colors.purple),
      ),
    );
  }

  Widget _buildPasswordField(Map<String, dynamic>? mLocaleData) {
    return Obx(() => HrAppTextFormField(
          controller: controller.passwordController,
          hintText: mLocaleData![ConfigKeysBody.password]!,
          keyboardType: TextInputType.text,
          obscureText: controller.isPasswordObsecure.value,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return ValidationString.password;
            }
            return null;
          },
          prefixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.lock, color: Colors.purple),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              controller.isPasswordObsecure.value
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Colors.purple,
            ),
            onPressed: controller.togglePasswordVisibility,
          ),
        ));
  }

  Widget _buildErrorMessage(double height) {
    return Obx(
      () => controller.errorMessage.isNotEmpty
          ? Column(
              children: [
                HrAppText(
                  text: controller.errorMessage.value,
                  style: HeadingTextStyles.heading2.copyWith(color: Colors.red),
                ),
                SizedBox(height: height * 0.02),
              ],
            )
          : const SizedBox(),
    );
  }

  Widget _buildLoginButton(double height) {
    return GestureDetector(
      onTap: controller.apiCalling.value ? null : controller.login,
      child: Obx(
        () => OrbitClientButton(
          title: 'Login',
          apiCalled: controller.apiCalling.value,
          widthBtn: 0.8,
        ),
      ),
    );
  }
}
