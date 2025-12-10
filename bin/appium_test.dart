import 'dart:io';

import 'emulators.dart';

import 'package:appium_driver/async_io.dart';


void main(List<String> arguments) async {
  // list of online devices
  List<String> devices = await getConnectedDevices();
  GlobalAppiumInfo.drivers = await createAPSForAllEmulators(devices: devices);
  //
  print(GlobalAppiumInfo.drivers.keys);

  //
  for (var i = 0; i < devices.length; i++) {}
}

// Get the top and bottom location of the "Follow" element . (its a future record)
Future<({num top, num bottom})?> getLocationFollowBotton({required AppiumWebDriver driver}) async {
  // points
  late num top, bottom;
  // uiautomator address of Reel Tab element
  String pathAddress = """new UiSelector().description("Follow")""";
  // checked element
  var checkedElement;
  //checking
  checkedElement = await checkExistElement(driver: driver, pathAddress: pathAddress);

  // if not exist try with another address
  if (checkedElement.existStatus == false) {
    pathAddress = """//android.view.ViewGroup[@content-desc="Following"]""";
    checkedElement = await checkExistElement(driver: driver, pathAddress: pathAddress);
  }

  if (checkedElement.existStatus) {
    if (checkedElement.pathType == PathType.uiautomator) {
      await driver.findElement(AppiumBy.uiautomator(pathAddress)).then((element) async {
        var location = await element.location;
        var size = await element.size;
        top = location.y;
        bottom = location.y + size.height;
      });
    } else if (checkedElement.pathType == PathType.className) {
      await driver.findElement(AppiumBy.className(pathAddress)).then((element) async {
        var location = await element.location;
        var size = await element.size;
        top = location.y;
        bottom = location.y + size.height;
      });
    } else if (checkedElement.pathType == PathType.xpath) {
      await driver.findElement(AppiumBy.xpath(pathAddress)).then((element) async {
        var location = await element.location;
        var size = await element.size;
        top = location.y;
        bottom = location.y + size.height;
      });
    }
  } else {
    top = 0;
    bottom = 0;
    print("Follows-Botton Not Found");
  }

  // driver end
  // await driver.quit();
  // close the cmd and stop process
  // await killCmdTree(GlobalAppiumInfo.processList.first.pid);
  // result
  return (top: top, bottom: bottom);
}

// Get the top and bottom location of the "Reel Tab" element . (its a future record)
Future<({num top, num bottom})?> getLocationReelTab({required AppiumWebDriver driver}) async {
  // points
  late num top, bottom;
  // uiautomator address of Reel Tab element
  String pathAddress =
      """//androidx.recyclerview.widget.RecyclerView/android.view.ViewGroup[3]/android.view.ViewGroup[2]""";
  //
  var checkedElement = await checkExistElement(driver: driver, pathAddress: pathAddress);
  // if not exist try with another address
  if (checkedElement.existStatus == false) {
    pathAddress =
        """//androidx.recyclerview.widget.RecyclerView/android.view.ViewGroup[2]/android.view.ViewGroup[2]""";
    checkedElement = await checkExistElement(driver: driver, pathAddress: pathAddress);
  }

  if (checkedElement.existStatus) {
    if (checkedElement.pathType == PathType.uiautomator) {
      await driver.findElement(AppiumBy.uiautomator(pathAddress)).then((element) async {
        var location = await element.location;
        var size = await element.size;
        top = location.y;
        bottom = location.y + size.height;
      });
    } else if (checkedElement.pathType == PathType.className) {
      await driver.findElement(AppiumBy.className(pathAddress)).then((element) async {
        var location = await element.location;
        var size = await element.size;
        top = location.y;
        bottom = location.y + size.height;
      });
    } else if (checkedElement.pathType == PathType.xpath) {
      await driver.findElement(AppiumBy.xpath(pathAddress)).then((element) async {
        var location = await element.location;
        var size = await element.size;
        top = location.y;
        bottom = location.y + size.height;
      });
    }
  } else {
    top = 0;
    bottom = 0;
    print("Reel-Tab Not Found");
  }

  // driver end
  // await driver.quit();
  // // close the cmd and stop process
  // await killCmdTree(GlobalAppiumInfo.processList.first.pid);
  // result
  return (top: top, bottom: bottom);
}

// tap on middel of Search Box
Future<bool> selectSearchBox({required AppiumWebDriver driver}) async {
  // click status
  late bool clickStatus;
  // uiautomator address of Search Box element
  String pathAddress = """android.widget.MultiAutoCompleteTextView""";
  //
  var checkedElement = await checkExistElement(driver: driver, pathAddress: pathAddress);

  if (checkedElement.existStatus) {
    if (checkedElement.pathType == PathType.uiautomator) {
      driver.findElement(AppiumBy.uiautomator(pathAddress)).then((element) async {
        await element.click();
      });
    } else if (checkedElement.pathType == PathType.className) {
      driver.findElement(AppiumBy.className(pathAddress)).then((element) async {
        await element.click();
      });
    } else if (checkedElement.pathType == PathType.xpath) {
      driver.findElement(AppiumBy.xpath(pathAddress)).then((element) async {
        await element.click();
      });
    }

    clickStatus = true;
  } else {
    clickStatus = false;
    print("Sreach Box Not Found");
  }

  await driver.quit();
  return clickStatus;
}

Future<({bool validStatus, bool existStatus})> checkSearchBox({
  required AppiumWebDriver driver,
  required String pageName,
}) async {
  // valid status
  late bool validStatus;
  late bool existStatus;
  // uiautomator address of Search Box element
  String pathAddress = """android.widget.MultiAutoCompleteTextView""";
  //checking element
  var checkedElement = await checkExistElement(driver: driver, pathAddress: pathAddress);
  //
  late String elementText;
  //

  if (checkedElement.existStatus) {
    if (checkedElement.pathType == PathType.uiautomator) {
      await driver.findElement(AppiumBy.uiautomator(pathAddress)).then((element) async {
        // get elemnts Texts
        elementText = await element.text;
        //
        if (elementText != pageName) {
          print("re-execute search-pageName");
          validStatus = false;
        } else {
          print("the Page Name is Valid");
          validStatus = true;
        }
      });
    } else if (checkedElement.pathType == PathType.className) {
      await driver.findElement(AppiumBy.className(pathAddress)).then((element) async {
        // get elemnts Text
        elementText = await element.text;
        //
        if (elementText != pageName) {
          print("re-execute search-pageName");
          validStatus = false;
        } else {
          print("the Page Name is Valid");
          validStatus = true;
        }
      });
    } else if (checkedElement.pathType == PathType.xpath) {
      await driver.findElement(AppiumBy.xpath(pathAddress)).then((element) async {
        // get elemnts Text
        elementText = await element.text;
        //
        if (elementText != pageName) {
          print("re-execute search-pageName");
          validStatus = false;
        } else {
          print("the Page Name is Valid");
          validStatus = true;
        }
      });
    }

    existStatus = true;
  } else {
    existStatus = false;
    validStatus = false;
    // return (validStatus: validStatus, existStatus: existStatus);
  }

  // driver end
  // await driver.quit();
  // close the cmd and stop process
  // await killCmdTree(GlobalAppiumInfo.processList.first.pid);
  // result
  return (validStatus: validStatus, existStatus: existStatus);
}

// all form of path type
enum PathType { uiautomator, className, xpath }

// checking element exists
Future<({bool existStatus, PathType pathType})> checkExistElement({
  required AppiumWebDriver driver,
  required String pathAddress,
}) async {
  late bool status;
  var elementsList = Stream.empty();
  late PathType type;

  // get elements list
  if (pathAddress.startsWith("new UiSelector()")) {
    elementsList = driver.findElements(AppiumBy.uiautomator(pathAddress));
    type = PathType.uiautomator;
  } else if (pathAddress.split(".").first.trim() == "android") {
    elementsList = await driver.findElements(AppiumBy.className(pathAddress));
    type = PathType.className;
  } else if (pathAddress.startsWith("/")) {
    elementsList = driver.findElements(AppiumBy.xpath(pathAddress));
    type = PathType.xpath;
  }
  // if list is empty
  await elementsList.isEmpty ? status = false : status = true;

  return (existStatus: status, pathType: type);
}

// base information of appium server
abstract class GlobalAppiumInfo {
  static int appium_server_port = 4723;
  static int appium_system_port = 8201;
  static int mjpeg_server_port = 8300;
  static Map<String, AppiumWebDriver> drivers = {};
  static List<Process> processList = [];
}

// add 1 counter to each port
Future<void> changeGlobalAppiumValues() async {
  GlobalAppiumInfo.appium_server_port++;
  GlobalAppiumInfo.appium_system_port++;
  GlobalAppiumInfo.mjpeg_server_port++;
}

// runing Appium server on CMD
Future<void> runAppiumServer() async {
  var process = await Process.start(
    "cmd",
    ["/c", "appium.cmd", "-p", GlobalAppiumInfo.appium_server_port.toString()],
    mode: ProcessStartMode.detached,
    runInShell: true,
  );

  GlobalAppiumInfo.processList.add(process);
  // print(process.pid);

  print("Appium server running");
}

// create Uinc driver for each deivce
Future<AppiumWebDriver> createUnicDrive({required String emulatorId}) async {
  //
  Map<String, String> desiredCapabilities = {
    "platformName": "Android",
    "automationName": "UiAutomator2",
    "appium:systemPort": GlobalAppiumInfo.appium_system_port.toString(),
    "appium:mjpegServerPort": GlobalAppiumInfo.mjpeg_server_port.toString(),
    "udid": emulatorId,
    // 'uiautomator2ServerLaunchTimeout': "10000", // 10 seconds
    'newCommandTimeout': "0", // 10 seconds
  };
  String appium_server = "http://127.0.0.1:${GlobalAppiumInfo.appium_server_port.toString()}";
  // Create the Appium driver
  late AppiumWebDriver driver;

  // run appium-server
  await runAppiumServer();
  await delaySeconds(3);

  try {
    // create driver
    driver = await createDriver(desired: desiredCapabilities, uri: Uri.parse(appium_server));

    await changeGlobalAppiumValues();
  } catch (e) {
    //
    await killCmdTree(GlobalAppiumInfo.processList.last.pid);
    print("the bas appium server was killed");
    // err
    print("this is our err : $e");
    //
    await changeGlobalAppiumValues();
    print("the GlobalValuse Changed");
    //
    driver = await createUnicDrive(emulatorId: emulatorId);
  }

  return driver;
}

// close the cmd and stop process
Future<bool> killCmdTree(int pid) async {
  // close and stop
  final result = await Process.run('taskkill', [
    '/F',
    '/T',
    '/PID',
    pid.toString(),
  ], runInShell: true);

  // remove the pId from list
  GlobalAppiumInfo.processList.removeWhere((element) => element.pid == pid);

  stdout.write(result.stdout);
  stderr.write(result.stderr);

  return result.exitCode == 0;
}

// create a unic driver for each emulator those are run
Future<Map<String, AppiumWebDriver>> createAPSForAllEmulators({
  required List<String> devices,
}) async {
  Map<String, AppiumWebDriver> drivers = {};

  for (var e in devices) {
    drivers[e] = await createUnicDrive(emulatorId: e);
  }

  return drivers;
}
