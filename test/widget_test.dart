import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/model/login.dart';

void main() {
  test('mem-parsing respons login CodeIgniter dengan id string', () {
    final login = Login.fromJson({
      'code': 200,
      'status': true,
      'data': {
        'token': 'token-uji',
        'user': {'id': '7', 'email': 'admin@example.com'},
      },
    });

    expect(login.userID, 7);
    expect(login.token, 'token-uji');
  });

  test('menolak respons login tanpa objek data pengguna', () {
    expect(
      () => Login.fromJson({
        'code': 400,
        'status': false,
        'data': 'Password tidak valid',
      }),
      throwsFormatException,
    );
  });
}
