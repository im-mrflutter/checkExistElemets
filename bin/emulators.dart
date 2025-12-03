import 'dart:io';

Future<List<String>> getConnectedDevices() async {
  var result = await Process.run('adb', ['devices']);
  if (result.exitCode != 0) {
    throw Exception('Failed to get connected devices: ${result.stderr}');
  }

  // تجزیه خروجی برای استخراج نام دستگاه‌ها
  var output = result.stdout.toString();
  var lines = output.split('\n');
  List<String> devices = [];

  for (var line in lines) {
    if (line.contains('\tdevice')) {
      var deviceName = line.split('\t')[0];
      devices.add(deviceName);
    }
  }

  return devices;
}
