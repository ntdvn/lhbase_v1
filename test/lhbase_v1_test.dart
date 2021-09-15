import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lhbase_v1/lhbase_v1.dart';

void main() {
  const MethodChannel channel = MethodChannel('lhbase_v1');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await LhbaseV1.platformVersion, '42');
  });
}
