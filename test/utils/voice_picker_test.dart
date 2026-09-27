import 'package:flutter_test/flutter_test.dart';
import 'package:lee_con_leo/utils/voice_picker.dart';

void main() {
  const languages = ['es-CL', 'es-US', 'es-MX', 'es-ES'];
  const googleUs = Voice(name: 'Google español de Estados Unidos', locale: 'es-US');
  const googleEs = Voice(name: 'Google español', locale: 'es-ES');
  const sabina = Voice(name: 'Microsoft Sabina - Spanish (Mexico)', locale: 'es-MX');
  const helena = Voice(name: 'Microsoft Helena - Spanish (Spain)', locale: 'es-ES');
  const zira = Voice(name: 'Microsoft Zira - English (United States)', locale: 'en-US');

  test('prefers a local voice over an online one with a closer accent', () {
    expect(pickVoice([googleUs, sabina, zira], languages), sabina);
  });

  test('among local voices, picks the closest accent', () {
    expect(pickVoice([helena, sabina], languages), sabina);
  });

  test('uses an online voice when there is no local Spanish voice', () {
    expect(pickVoice([zira, googleEs, googleUs], languages), googleUs);
  });

  test('falls back to any Spanish voice', () {
    const argentina = Voice(name: 'Local AR', locale: 'es_AR');
    expect(pickVoice([zira, argentina], languages), argentina);
  });

  test('treats Android network voices as online', () {
    const network = Voice(name: 'es-us-x-esd-network', locale: 'es-US');
    const local = Voice(name: 'es-us-x-esd-local', locale: 'es-US');
    expect(pickVoice([network, local], languages), local);
  });

  test('finds nothing when there is no Spanish voice', () {
    expect(pickVoice([zira], languages), isNull);
    expect(pickVoice([], languages), isNull);
  });
}
