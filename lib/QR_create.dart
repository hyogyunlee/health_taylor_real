import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QR_create extends StatelessWidget {
  final String data;

  QR_create({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR 코드'),
      ),
      body: Center(
        child: QrImageView(
          data: data,
          version: QrVersions.auto,
          size: 200,
        ),
      ),
    );
  }
}
