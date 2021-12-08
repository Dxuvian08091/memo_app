import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoInternetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('No Internet Connection | Error'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //First Element
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Icon(
                Icons.wifi_off,
                size: 100,
              ),
            ),
            //Second Element
            SizedBox(
              height: 1,
            ),
            //Third Element
            Text(
              'No Internet Connection',
              style: TextStyle(fontSize: 24),
            ),
            //Fourth Element
            SizedBox(
              height: 10,
            ),
            //Fifth Element
            Container(
              height: MediaQuery.of(context).size.height * 0.09,
              width: MediaQuery.of(context).size.width * 0.95,
              child: Expanded(
                child: Text(
                  'Please Check Your Internet Connection and Try Again',
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
