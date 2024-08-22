import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../core/utils/methods.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../widgets/row_settings_scanner.dart';

class BarcodeView extends StatefulWidget {
  const BarcodeView({super.key});

  @override
  State<BarcodeView> createState() => _BarcodeViewState();
}

class _BarcodeViewState extends State<BarcodeView> {
  MobileScannerController cameraController =
      MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates);

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff525252),
      appBar: CustomAppBar(
        isPortrait: isOrientationPortrait(context),
        title: "Qr Scanner",
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Place the QR code in the area",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: Color(0xff5fa7b0),
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Scanning will be started automatically",
                    style: TextStyle(
                      color: Color(0xff5fa7b0),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: MobileScanner(
                      controller: cameraController,
                      onDetect: (BarcodeCapture capture) {
                        final List<Barcode> barcodes = capture.barcodes;

                        String code = barcodes.first.rawValue ?? "---";

                        TorchState t = cameraController.torchState.value;

                        if (t.name == "on") {
                          cameraController.toggleTorch();
                          Navigator.pop(context, code);
                        } else {
                          Navigator.pop(context, code);
                        }
                      }),
                ),
              ),
            ),
            RowSettingsScanner(cameraController: cameraController),
            const SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}
