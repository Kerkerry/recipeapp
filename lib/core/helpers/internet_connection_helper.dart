import 'package:connectivity_plus/connectivity_plus.dart';
class InternetConnectionHelper{
  const InternetConnectionHelper();
  Future<bool> checkConnection()async{
    final connectionResult=await Connectivity().checkConnectivity();
    if(connectionResult[0]==ConnectivityResult.none){
      return false;
    }else if(
        connectionResult[0]==ConnectivityResult.wifi ||
        connectionResult[0]==ConnectivityResult.vpn ||
        connectionResult[0]==ConnectivityResult.mobile){
      return true;
    }
    return false;
  }
}