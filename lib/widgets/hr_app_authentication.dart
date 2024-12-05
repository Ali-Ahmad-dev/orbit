import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import '../constants/images/asset_images_path.dart';
import 'hr_asset_images.dart';

class HrAppAuthentication extends StatelessWidget {
  final LocalAuthentication auth = LocalAuthentication();
  HrAppAuthentication({super.key});

  Future<bool> _isDeviceSupported() async {
    return await auth.isDeviceSupported();
  }

  Future<void> _authenticate(BuildContext context) async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: "You will never find overflow stack",
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      print("Authenticated: $authenticated");
      _showDialog(context, authenticated);
    } on PlatformException catch (e) {
      print(e);
    }
  }
  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();
    print("List available Biometrics: $availableBiometrics");
  }
  void _showDialog(BuildContext context, bool authenticated) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Authentication Result'),
          content: Text(authenticated ? 'Authentication Successful' : 'Authentication Failed'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isDeviceSupported(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Column(
            children: [
               Center(child: CircularProgressIndicator()),
            ],
          );
        } else if (snapshot.hasError) {
          return const
             Center(child: Text('Error occurred'));

        } else if (!snapshot.data!) {
          return const
            Center(child: Text('Device not supported'));
        } else {
          return Column(
            children: [
                 Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => _authenticate(context),
                        child:
                        const HrAssetImage(path: AssetImagesPath.finger, width: 50,height: 50,),
                        ),
                    ],
                  ),
                ),
            ],
          );
        }
      },
    );
  }
}
