import 'package:alert_banner/exports.dart';
import 'package:flutter/material.dart';
class CustomAlert{
  CustomAlert._();

  static show(BuildContext context,String message){
      return showAlertBanner(
          context,
          (){},
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 61, 146, 64),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Padding(
              padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style:Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: Colors.white),
              ),
            ),
          ),
        alertBannerLocation:AlertBannerLocation.top,
        safeAreaTopEnabled: true
      );
  }
}
