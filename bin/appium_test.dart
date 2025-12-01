import 'package:appium_driver/async_io.dart';

void main(List<String> arguments) async {
  Map<String, String> desiredCapabilities = {
    "platformName": "Android",
    "automationName": "UiAutomator2",
    "appium:systemPort": "8203",
    "appium:mjpegServerPort": "8300",
  };
  String appium_server = "http://127.0.0.1:4723";
  // Create the Appium driver
  var driver = await createDriver(desired: desiredCapabilities, uri: Uri.parse(appium_server));

  // Get the location of the "Follow" element
  // var loc = await getLocationFollowBotton(driver: driver);

  // print(loc!.top);

  print(await selectSearchBox(driver: driver));
}

// Get the top and bottom location of the "Follow" element . (its a future record)
Future<({num top, num bottom})?> getLocationFollowBotton({required AppiumWebDriver driver}) async {
  // points
  late num top, bottom;
  // uiautomator address of Real Tab element
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
    return null;
  }

  driver.quit();
  return (top: top, bottom: bottom);
}

// Get the top and bottom location of the "Real Tab" element . (its a future record)
Future<({num top, num bottom})?> getLocationRealTab({required AppiumWebDriver driver}) async {
  // points
  late num top, bottom;
  // uiautomator address of Real Tab element
  String pathAddress =
      """//androidx.recyclerview.widget.RecyclerView/android.view.ViewGroup[3]/android.view.ViewGroup[2]""";
  //
  var checkedElement = await checkExistElement(driver: driver, pathAddress: pathAddress);
  // if not exist try with another address
  // if (checkedElement.existStatus == false) {
  //   pathAddress =
  //       """//androidx.recyclerview.widget.RecyclerView/android.view.ViewGroup[3]/android.view.ViewGroup[2]""";
  //   checkedElement = await checkExistElement(driver: driver, pathAddress: pathAddress);
  // }

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
    return null;
  }

  driver.quit();
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
  }

  driver.quit();
  return clickStatus;
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
