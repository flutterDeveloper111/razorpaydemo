import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalAmount = 0;
  late Razorpay _razorpay;
  TextEditingController amount = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("Payment Done");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("Payment Fail");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Razorpay Demo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextFormField(
              controller: amount,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Your amount",
              ),
            ),
            SizedBox(height: 20,),
            CupertinoButton(

              color: Colors.blue,
              child: Text("Razor Pay"),
              onPressed: () {
                var options = {
                  'key': "rzp_test_xvlZZBGCo0SzL0",
                  // amount will be multiple of 100
                  'amount': (int.parse(amount.text) * 100)
                      .toString(), //So its pay 500
                  'name': 'Razorpay Test',
                  'description': 'Demo',
                  'timeout': 300, // in seconds
                  'prefill': {
                    'contact': '7984065746',
                    'email': 'minaxikumbhani1234@gmail.com'
                  }
                };
                _razorpay.open(options);
              },
            )
          ],
        ),
      ),
    );
  }
}
