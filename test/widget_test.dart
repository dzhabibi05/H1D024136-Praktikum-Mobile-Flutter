import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/ui/produk_form.dart';

void main() {
  testWidgets('menyimpan produk membuka halaman detail', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ProdukForm()));

    await tester.enterText(find.byType(TextFormField).at(0), 'P001');
    await tester.enterText(find.byType(TextFormField).at(1), 'Buku');
    await tester.enterText(find.byType(TextFormField).at(2), '15000');
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    expect(find.text('Detail Produk'), findsOneWidget);
    expect(find.text('Kode Produk: P001'), findsOneWidget);
    expect(find.text('Nama Produk: Buku'), findsOneWidget);
    expect(find.text('Harga: 15000'), findsOneWidget);
  });
}
