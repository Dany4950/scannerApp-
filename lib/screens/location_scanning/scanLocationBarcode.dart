// import 'package:buildittt/providers/scanProvider.dart';
// import 'package:buildittt/screens/location_scanning/scanItems.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';


// class ScanLocationPage extends StatelessWidget {
//   const ScanLocationPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Scan Location")),
//       body: Scaffold(
//         body: Consumer<scanLocationBarcode>(
//           builder: (context, scanProvider, child) {
//             return Center(
//               child: scanProvider.locationHash == null
//                   ? ElevatedButton(
//                       onPressed: () async {
//                         await scanProvider.scanItemBarcode();
                        
//                       },
//                       child: const Text("Scan Location Barcode"),
//                     )
//                   : Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // Text("Location Hash: ${scanProvider.locationHash}"),
//                         const SizedBox(height: 20),
                    
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             ElevatedButton(
//                               onPressed: () async {
//                                 await scanProvider.scanItemBarcode();
//                               },
//                               style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.red),
//                               child: const Text("Rescan"),
//                             ),
//                             ElevatedButton(
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           const ItemScanningPage()),
//                                 );
//                               },
//                               style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.green),
//                               child: const Text("Proceed to Item Scanning"),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:buildittt/providers/scanProvider.dart';
import 'package:buildittt/screens/location_scanning/scanItems.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScanLocationPage extends StatelessWidget {
  const ScanLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan Location")),
      body: Scaffold(
        body: Consumer<scanLocationBarcode>(
          builder: (context, scanProvider, child) {
            return Center(
              child: scanProvider.locationHash == null
                  ? ElevatedButton(
                      onPressed: () async {
                        // Scan the location barcode
                        await scanProvider.scanBarcode();
                      },
                      child: const Text("Scan Location Barcode"),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Display the scanned location barcode
                        Text(
                           style: TextStyle(color: Colors.black,fontSize: 18),
                          "Location Barcode: ${scanProvider.Locationbarcodes.isNotEmpty ? scanProvider.Locationbarcodes.first.barcode : 'No barcode scanned'}",
                        ),
                        const SizedBox(height: 20),
                    
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                // Clear the location barcode and rescan
                                scanProvider.Locationbarcodes.clear();
                                await scanProvider.scanBarcode();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              child: const Text("Rescan"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Navigate to the Item Scanning page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ItemScanningPage()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green),
                              child: const Text("Proceed to Item Scanning"),
                            ),
                          ],
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}

