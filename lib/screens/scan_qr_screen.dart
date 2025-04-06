// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
//
// class ScanQRScreen extends StatefulWidget {
//   @override
//   _ScanQRScreenState createState() => _ScanQRScreenState();
// }
//
// class _ScanQRScreenState extends State<ScanQRScreen> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;
//   String scannedResult = "Scan a QR code";
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
//
//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         scannedResult = scanData.code ?? "No data";
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Scan QR Code")),
//       body: Column(
//         children: [
//           Expanded(
//             flex: 4,
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: _onQRViewCreated,
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Center(
//               child: Text(
//                 scannedResult,
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
