import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_utils/qr_code_utils.dart';
import 'dart:io';

class ScanQR extends StatefulWidget {
  const ScanQR({Key? key}) : super(key: key);

  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  File? image;
  String data = '';

  String decoded = 'Unknown';
  Future<void> initPlatformState() async {
    var imagePicker = ImagePicker();

    XFile? xfile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (xfile != null) {
      String? decoded;

      try {
        decoded = await QrCodeUtils.decodeFrom(xfile.path) ??
            'Unknown platform version';
        if (decoded != '') {
          decoded = decoded;
          print('hahahah   $decoded');
          Get.back(result: decoded);
        }
      } on PlatformException {
        decoded = 'Failed to get decoded.';
      }
    }

    if (!mounted) return;
  }

  MobileScannerController cameraController = MobileScannerController();

  @override
  void initState() {
    super.initState();
    cameraController.barcodes.listen((event) {
      print('Event => $event');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Scanner'),
        foregroundColor: Colors.black,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: Colors.black),
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          const SizedBox(width: 15),
          InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 19,
              )),
          const Spacer(),
          const Center(
              child: Text(
            'Scanner',
            style: TextStyle(fontSize: 17),
          )),
          const Spacer(),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height / 1,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 3),
                  borderRadius: BorderRadius.circular(23)),
              height: MediaQuery.of(context).size.height / 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: MobileScanner(
                    allowDuplicates: false,
                    controller: cameraController,
                    onDetect: (barcode, args) {
                      if (barcode.rawValue == null) {
                        debugPrint('Failed to scan Barcode');
                      } else {
                        final String code = barcode.rawValue!;

                        debugPrint('Barcode found! ${barcode.rawValue}');
                        Get.back(result: code);
                      }
                    }),
              ),
            ),
            const SizedBox(height: 50),
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: Colors.deepPurple),
                height: 45,
                width: MediaQuery.of(context).size.width / 1.8,
                margin:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Import From Gallery'.tr,
                      style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.image, color: Colors.white)
                  ],
                ),
              ),
              onTap: () async {
                initPlatformState();
              },
            ),
          ],
        ),
      ),
    );
  }
}
