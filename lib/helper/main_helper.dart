

import '../network/api_services.dart';
import '../network/api_services_implementation.dart';

class MainHelper{

  double mScreenWidth = 0.0;
  double mScreenHeight = 0.0;
  bool isTablet = false;
  bool isCreator = false;

  late ApiServices apiServices;

  MainHelper(){
    apiServices = ApiServicesImplementation();
  }

  initialConfigurations(){
    isTablet = mScreenWidth > 600;
  }
}