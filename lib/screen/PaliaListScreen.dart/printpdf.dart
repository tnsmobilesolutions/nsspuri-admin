import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:screenshot/screenshot.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScreenshotController screenshotController = ScreenshotController();
  Future<Uint8List> loadImageFromNetwork(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image from network');
    }
  }

  Future<Uint8List> qrcodee() async {
    return screenshotController
        .captureFromWidget(Container(
      child: SfBarcodeGenerator(
        value: 'www.syncfusion.com',
        symbology: QRCode(),
      ),
    ))
        .then((capturedImage) {
      return capturedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '0',
              style: TextStyle(fontSize: 24),
            ),
            // SizedBox(height: 200,width: 200,child: Image(image: MemoryImage(qrcodee())),),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final pdf = pw.Document();
          final networkImage = await loadImageFromNetwork(
              'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/09/instagram-image-size.jpg');
          final qrcode = await qrcodee();
          print(qrcode);
          // Create a new barcode instance
          pdf.addPage(
            pw.Page(
              build: (pw.Context context) {
                return pw.Container(
                  height: 400,
                  child: pw.Column(
                    children: [
                      // Image
                      pw.SizedBox(
                        height: 200,
                        width: 200,
                        child: pw.Image(pw.MemoryImage(networkImage)),
                      ),
                      pw.SizedBox(height: 20),
                      pw.SizedBox(
                        height: 200,
                        width: 200,
                        child: pw.Image(pw.MemoryImage(qrcode)),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
          final pdfBytes = await pdf.save();
          // Print the PDF
          Printing.layoutPdf(
            onLayout: (_) => pdfBytes,
          );
        },
        tooltip: 'Print PDF',
        child: const Icon(Icons.print),
      ),
    );
  }
}
