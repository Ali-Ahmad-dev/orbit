import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../extentions/hex_colors.dart';

class AppColors {
  static final primaryTextColor = HexColor.fromHex('#6A9B54');
  static Rx<Color> primaryColor = Colors.purple.obs;
  static final secondaryColor = HexColor.fromHex('#F8F8FA');
  static const primaryGreenColor = Colors.green;
  static const primaryPurpleColor = Colors.purple;
  static const primarygreyColor = Colors.grey;
  static const primaryYellowColor = Colors.yellow;
  static const primaryDarkOrange = Colors.deepOrange;
  static const primaryBlue = Colors.blue;
  static final textColorTextFormField = HexColor.fromHex('#9C9C9C');
  static const backgroundColor = Colors.white;
  static final descriptionColor = HexColor.fromHex('#454B60');
  static final dashboardColor = HexColor.fromHex('#3d2793');
  static final dashboardColor1 = HexColor.fromHex('#11a374');
  static final dashboardColor2 = HexColor.fromHex('#ff8e01');
  static final dashboardColor3 = HexColor.fromHex('#ffe083');
  static final dashboardColor4 = HexColor.fromHex('#25c6da');
  static final fillColorOtpContainer = HexColor.fromHex('#F2F2F2');
  static final borderColorOtpContainer = HexColor.fromHex('#C9C9C9');
  static final payment = HexColor.fromHex('#828F9C');
  static final payment1 = HexColor.fromHex('#000000');
  static final confirmPayment = HexColor.fromHex('#BC3D4D');
  static final containerPrimaryColor = HexColor.fromHex('#AADC8A');
  static final containerSecondaryColor = HexColor.fromHex('#E6FCD8');
  static final listContainerTextColor = HexColor.fromHex('#101018');
  static final profileTextColor = HexColor.fromHex('#898989');
  static final profileTextColor1 = HexColor.fromHex('#676767');
  static final creatorPayment = HexColor.fromHex('#7C7C7C');
  static final creatorPayment1 = HexColor.fromHex('#959595');
  static final popUpColor = HexColor.fromHex('#0F0F0F');
  static final bottomNavColor = HexColor.fromHex('#FAF9F9');
  static final dimColor = HexColor.fromHex('#FAF9F9');
  static final btnColor = HexColor.fromHex('#D0F2BA');
  static final walletColor = HexColor.fromHex('#568640');
  static final walletColor1 = HexColor.fromHex('#41A8E2');
  static final walletColor2 = HexColor.fromHex('#FFFFFF');
  static final notification = HexColor.fromHex('#4E8F2F');
  static final dateSelector = HexColor.fromHex('#3d2793');
  static final menu = HexColor.fromHex('#D3D3D3');
  static final balanceSheet = HexColor.fromHex('#4CAEE3');

  static final orbitClientOne = HexColor.fromHex('#808080');

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  void updatePrimaryColor(String designation) {
    // if (designation == 'Team Lead') {
    //   primaryColor.value = createMaterialColor(Colors.teal);
    // } else if (designation == 'HR' || designation == 'HR Lead') {
    //   primaryColor.value = createMaterialColor(primaryBlue);
    // } else {
    //   primaryColor.value = createMaterialColor(primaryPurpleColor);
    // }
  }
}
