import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/login_page.dart';
import 'package:flutter_application_1/ui/produk_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('menyimpan produk membuka halaman detail', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ProdukForm()));

    await tester.enterText(find.byType(TextField).at(0), 'P001');
    await tester.enterText(find.byType(TextField).at(1), 'Buku');
    await tester.enterText(find.byType(TextField).at(2), '15000');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text('Detail Produk'), findsOneWidget);
    expect(find.text('Kode Produk: P001'), findsOneWidget);
    expect(find.text('Nama Produk: Buku'), findsOneWidget);
    expect(find.text('Harga: 15000'), findsOneWidget);
  });

  testWidgets('login admin menyimpan username dan membuka daftar produk', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    await tester.enterText(find.byType(TextField).at(0), 'admin');
    await tester.enterText(find.byType(TextField).at(1), 'admin');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text('Anda Berhasil Login'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.text('List Data Produk'), findsOneWidget);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('username'), 'admin');
  });
}
