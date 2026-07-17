import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:rippl/services/telemetry.dart';

void main() {
  test('flush posts queued events and clears the buffer', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://x/api/v1'));
    final adapter = DioAdapter(dio: dio);
    var received = 0;
    adapter.onPost('/telemetry/events', (server) {
      received++;
      server.reply(202, <String, dynamic>{});
    });
    final client = TelemetryClient(dio, sessionId: 's1');
    client.track('app_open');
    client.track('feed_view', <String, dynamic>{'tab': 'home'});
    await client.flush();
    expect(received, 1);
    // second flush with empty buffer does not post
    await client.flush();
    expect(received, 1);
  });
}
