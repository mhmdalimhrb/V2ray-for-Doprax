import 'dart:developer';

import 'package:balad_webapp_new/gen/assets.gen.dart';
import 'package:balad_webapp_new/profile_screen.dart';
import 'package:balad_webapp_new/remote_service.dart';
import 'package:balad_webapp_new/remote_service_controller.dart';
import 'package:balad_webapp_new/wallet_connect.dart';
import 'package:balad_webapp_new/widgets/payment_plans_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:wagmi_web/wagmi_web.dart' as wagmi;
import 'package:wagmi_web/wagmi_web.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentPlansScreen extends StatelessWidget {
  PaymentPlansScreen({super.key});

  RxString coinPrice = "".obs;

  RxString coinValueTransaction = "".obs;

  double calculationValueTransaction({
    required String coinPrice,
    required double accountPrice,
  }) {
    final pricePerCoin = double.parse(coinPrice);
    final coinAmount = accountPrice / pricePerCoin;
    final weiAmount = coinAmount * 1e18;
    return weiAmount.round();
  }

  Future<String> fetchCryptoQuote() async {
    const url =
        'https://api.coingecko.com/api/v3/simple/price?ids=icb-network&vs_currencies=usd';

    try {
      final res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final price = data['icb-network']['usd'].toString();
        coinPrice.value = price.toString();

        print('💰 ICBX Price: $price USD');
      } else {
        print('❌ Error ${res.statusCode}: ${res.body}');
      }
    } catch (e) {
      print('⚠️ Exception: $e');
    }
    return coinPrice.value;
  }
  // Future<String> fetchCryptoQuote() async {
  //   const url =
  //       'https://api.coingecko.com/api/v3/simple/price?ids=binancecoin&vs_currencies=usd';

  //   try {
  //     final res = await http.get(Uri.parse(url));

  //     if (res.statusCode == 200) {
  //       final data = jsonDecode(res.body);
  //       final price = data['binancecoin']['usd'].toString();
  //       coinPrice.value = price.toString();

  //       print('💰 BNB Price: $price USD');
  //     } else {
  //       print('❌ Error ${res.statusCode}: ${res.body}');
  //     }
  //   } catch (e) {
  //     print('⚠️ Exception: $e');
  //   }
  //   return coinPrice.value;
  // }

  final remoteServiceController = Get.put(RemoteServiceController());

  // Future<String> fetchCryptoQuote() async {
  //   final uri = Uri.parse(
  //     'https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?id=1839',
  //   );

  //   final headers = {
  //     'X-CMC_PRO_API_KEY': '22e27d32-4e82-4cf3-895c-f26889e75af0',
  //     'Accept': 'application/json',
  //   };

  //   try {
  //     final res = await http.get(uri, headers: headers);

  //     if (res.statusCode == 200) {
  //       final data = jsonDecode(res.body);
  //       final price = data['data']['1839']['quote']['USD']['price'];
  //       coinPrice.value = price.toString();

  //       print('💰 BNB Price: $price USD');
  //     } else {
  //       print('❌ Error ${res.statusCode}: ${res.body}');
  //     }
  //   } catch (e) {
  //     print('⚠️ Exception: $e');
  //   }
  //   return coinPrice.value;
  // }

  // Future<String> fetchCryptoQuote() async {
  //   final uri = Uri.https(
  //     'pro-api.coinmarketcap.com',
  //     '/v1/cryptocurrency/quotes/latest',
  //     {'id': '1839'},
  //   );

  //   final headers = {
  //     'X-CMC_PRO_API_KEY': '22e27d32-4e82-4cf3-895c-f26889e75af0',
  //     'Accept': 'application/json',
  //   };

  //   try {
  //     final response = await http.get(uri, headers: headers);

  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       final price = data['data']['1839']['quote']['USD']['price'];
  //       coinPrice.value = price.toString();
  //       print('✅ Data: $data');
  //       print('✅ price: $price');
  //     } else {
  //       print('❌ Error ${response.statusCode}: ${response.reasonPhrase}');
  //     }
  //   } catch (e) {
  //     print('⚠️ Exception: $e');
  //   }
  //   return coinPrice.value;
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 20, 23, 42),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Gap(40),
                  Text(
                    "Captain Subscription",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "GrechenFuemen",
                      fontSize: 20,
                    ),
                  ),
                  Gap(5),
                  Text(
                    "Unlock features and enjoy free and secure internet.",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Gap(60),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Features",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text("Status", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Gap(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Resistance to\nsevere filtering",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: Assets.png.tick.image(),
                          ),
                        ],
                      ),
                      Gap(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Connection speed",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text("HIGH", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      Gap(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Multi locations",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: Assets.png.tick.image(),
                          ),
                        ],
                      ),
                      Gap(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Linked devices",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text("2", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      Gap(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Encryption",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "MULTIPLE",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Gap(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Zero log",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: Assets.png.tick.image(),
                          ),
                        ],
                      ),
                      Gap(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Support",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "TELEGRAM",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 30),
                ],
              ),
              Stack(
                children: [
                  Column(
                    children: [
                      Gap(80),
                      SizedBox(
                        width: 342,
                        height: 56,
                        child: Obx(
                          () => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(
                                color: const Color.fromARGB(224, 84, 84, 84),
                                // const Color(0xFF0052B4),
                                width: 1,
                              ),
                              backgroundColor: const Color.fromARGB(
                                224,
                                84,
                                84,
                                84,
                              ),
                              // backgroundColor: const Color.fromARGB(
                              //   255,
                              //   13,
                              //   110,
                              //   253,
                              // ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              if (true) return;
                              if (!remoteServiceController
                                  .isAnnualLoading
                                  .value) {
                                remoteServiceController.isAnnualLoading.value =
                                    true;
                                final responseCoinPrice =
                                    await fetchCryptoQuote();
                                final account = wagmi.Core.getAccount();

                                final valueWei = calculationValueTransaction(
                                  coinPrice: responseCoinPrice,
                                  accountPrice: 19.99,
                                );

                                print("value wei ::: $valueWei");
                                print(
                                  "big-int ::: ${BigInt.parse(valueWei.toString())}",
                                );

                                print(
                                  "This is account vals : ${account.isConnected} , ${account.isDisconnected} ,",
                                );

                                if (account.isConnected) {
                                  final sendTransactionParameters =
                                      wagmi.SendTransactionParameters.legacy(
                                        to: '0x2c942df0c130ef54b363b8a77d5d429287caee34',
                                        account: account!.address!,
                                        // value: BigInt.parse('1000000000000000'),
                                        value: BigInt.parse(valueWei.toString()),
                                      );
                                  print("This Place");
                                  try {
                                    final result =
                                        await wagmi.Core.sendTransaction(
                                          sendTransactionParameters,
                                        );
                                    print("result transaction ::: $result");
                                    var transactionResult =
                                        await wagmi
                                            .Core.waitForTransactionReceipt(
                                          WaitForTransactionReceiptParameters(
                                            hash: result,
                                            chainId: 73115,
                                            // chainId: 11155111,
                                          ),
                                        );
                                    print(
                                      "This is result4 ::: ${transactionResult.status}",
                                    );
                                    if (transactionResult.status == "success") {
                                      remoteServiceController
                                              .isAnnualLoading
                                              .value =
                                          false;

                                      await RemoteService().subscriptionUpdated(
                                        walletAddress: account.address!,
                                        expiredAt: DateTime.now().add(const Duration(days: 373)).toUtc().toIso8601String(),
                                      );
                                    } else {
                                      remoteServiceController
                                              .isAnnualLoading
                                              .value =
                                          false;
                                    }
                                  } catch (e) {
                                    remoteServiceController
                                            .isAnnualLoading
                                            .value =
                                        false;
                                  }
                                } else {
                                  remoteServiceController
                                          .isAnnualLoading
                                          .value =
                                      false;
                                }
                              }
                            },
                            child:
                                (remoteServiceController.isAnnualLoading.value)
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Annual",
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontStyle: FontStyle.italic,
                                          // color: Color.fromARGB(
                                          //   255,
                                          //   20,
                                          //   23,
                                          //   42,
                                          // ),
                                        ),
                                      ),
                                      Gap(2),
                                      Text(
                                        "\$19.99 / year",
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                            255,
                                            20,
                                            23,
                                            42,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      Gap(10),
                      SizedBox(
                        width: 342,
                        height: 56,
                        child: Obx(
                          () => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 20, 23, 42),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: const Color(0xFF0052B4),
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              if (!remoteServiceController
                                  .isMonthlyLoading
                                  .value) {
                                remoteServiceController.isMonthlyLoading.value =
                                    true;
                                final responseCoinPrice =
                                    await fetchCryptoQuote();
                                final account = wagmi.Core.getAccount();

                                final valueWei = calculationValueTransaction(
                                  coinPrice: responseCoinPrice,
                                  accountPrice: 1.99,
                                );

                                print("value wei ::: $valueWei");

                                final sendTransactionParameters =
                                    wagmi.SendTransactionParameters.legacy(
                                      to: '0x2c942df0c130ef54b363b8a77d5d429287caee34',
                                      account: account!.address!,
                                      // value: BigInt.parse('100000000000000'),
                                      value: BigInt.parse(valueWei.toString()),
                                    );
                                try {
                                  final result =
                                      await wagmi.Core.sendTransaction(
                                        sendTransactionParameters,
                                      );
                                  print("result transaction ::: ${result}");

                                  var transactionResult =
                                      await wagmi
                                          .Core.waitForTransactionReceipt(
                                        WaitForTransactionReceiptParameters(
                                          hash: result,
                                          chainId: 73115,
                                          // chainId: 11155111,
                                        ),
                                      );
                                  print(
                                    "This is result4 ::: ${transactionResult.status}",
                                  );
                                  if (transactionResult.status == "success") {
                                    remoteServiceController
                                            .isMonthlyLoading
                                            .value =
                                        false;
                                    await RemoteService().subscriptionUpdated(
                                      walletAddress: account.address!,
                                      expiredAt: DateTime.now().add(const Duration(days: 31)).toUtc().toIso8601String(),
                                    );
                                  } else {
                                    remoteServiceController
                                            .isMonthlyLoading
                                            .value =
                                        false;
                                  }
                                } catch (e) {
                                  remoteServiceController
                                          .isMonthlyLoading
                                          .value =
                                      false;
                                }
                              }
                            },
                            child:
                                (remoteServiceController.isMonthlyLoading.value)
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Monthly",
                                        style: TextStyle(
                                          color: const Color(0xFF0052B4),
                                        ),
                                      ),
                                      Gap(2),
                                      Text(
                                        "\$1.99 / month",
                                        style: TextStyle(
                                          color: const Color(0xFF0052B4),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      Gap(20),
                      Text(
                        "Terms & Conditions",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Gap(8),
                      Text(
                        "Support",
                        style: TextStyle(color: const Color(0xFF0052B4)),
                      ),
                      Gap(50),
                      Container(
                        width: size.width,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 40, 43, 62),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 140,
                                height: 40,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    side: BorderSide(
                                      color: const Color(0xFF0052B4),
                                      width: 1,
                                    ),
                                    backgroundColor: const Color.fromARGB(
                                      255,
                                      13,
                                      110,
                                      253,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(25),
                                      ),
                                    ),
                                  ),
                                  onPressed: () async {
                                    final getTokenParameters =
                                        wagmi.DisconnectParameters();
                                    await wagmi.Core.disconnect(
                                      getTokenParameters,
                                    );
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return WalletConnectScreen();
                                        },
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Disconnect",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              // Text("Adderss : ${}")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 290,
                    left: 115,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 45, 41, 66),
                        borderRadius: BorderRadius.all(Radius.circular(80)),
                      ),
                      height: 28,
                      width: 160,
                      child: Center(
                        child: Text(
                          "Save 16% . 7 days free",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

