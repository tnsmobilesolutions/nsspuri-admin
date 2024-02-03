import 'package:firebase_remote_config/firebase_remote_config.dart';

// class FirebaseRemoteConfigService {
//   FirebaseRemoteConfigService._()
//       : _remoteConfig = FirebaseRemoteConfig.instance; // MODIFIED

//   static FirebaseRemoteConfigService? _instance; // NEW
//   factory FirebaseRemoteConfigService() =>
//       _instance ??= FirebaseRemoteConfigService._(); // NEW

//   final FirebaseRemoteConfig _remoteConfig;
//   String getUpdateMessage(String mandatoryUpgradeText) =>
//       _remoteConfig.getString(mandatoryUpgradeText);
//   String getVersionNumber(String versionNumber) =>
//       _remoteConfig.getString(versionNumber);
//   bool getshouldShowMandatoryUpgradePrompt(
//           String shouldShowMandatoryUpgradePrompt) =>
//       _remoteConfig.getBool(shouldShowMandatoryUpgradePrompt);
//       String get welcomeMessage => _remoteConfig.getString(FirebaseRemoteConfigKeys.welcomeMessage);
// }

class RemoteConfigHelper {
  static final RemoteConfigHelper _networkHelper =
      RemoteConfigHelper._internal();

  bool shouldShowMandatoryUpgradePrompt = false;
  bool get getShowMandatoryUpgradePrompt {
    return shouldShowMandatoryUpgradePrompt;
  }

  set setUpgradePrompt(bool upgradePrompt) {
    shouldShowMandatoryUpgradePrompt = upgradePrompt;
  }

  //
  String mandatoryUpgradeText = "";
  String get getMandatoryUpgradeText {
    return mandatoryUpgradeText;
  }

  set setUpgradeText(String upgradeText) {
    mandatoryUpgradeText = upgradeText;
  }

  String paymentMessage = "";
  String get getPaymentMessage {
    return paymentMessage;
  }

  set setPaymentMessage(String message) {
    paymentMessage = message;
  }

  String upiId = "";
  String get getUpiId {
    return upiId;
  }

  set setUpiId(String upiIdLink) {
    upiId = upiIdLink;
  }

  String paymentContact = "";
  String get getPaymentContact {
    return paymentContact;
  }

  set setPaymentContact(String contact) {
    paymentContact = contact;
  }

  String bankName = "";
  String get getBankName {
    return bankName;
  }

  set setBankName(String name) {
    bankName = name;
  }

  String bankAccountNo = "";
  String get getBankAccountNo {
    return bankAccountNo;
  }

  set setBankAccountNo(String accountNo) {
    bankAccountNo = accountNo;
  }

  String bankIfscCode = "";
  String get getBankIfscCode {
    return bankIfscCode;
  }

  set setBankIfscCode(String ifscCode) {
    bankIfscCode = ifscCode;
  }

  String branchName = "";
  String get getBranchName {
    return branchName;
  }

  set setBranchName(String brName) {
    branchName = brName;
  }

  String helpContactNo = "";
  String get gethelpContactNo {
    return helpContactNo;
  }

  set sethelpContactNo(String contactNo) {
    helpContactNo = contactNo;
  }

  //
  String versionNumber = "";
  String get getVersionNumber {
    return versionNumber;
  }

  set setVersionNumber(String versionNumberr) {
    versionNumber = versionNumberr;
  }

  String apiBaseURL = "";
  String get getapiBaseURL {
    return apiBaseURL;
  }

  set setapiBaseURL(String baseURL) {
    apiBaseURL = baseURL;
  }
  double scanner_auto_close_duration = 5;
  double get getscanner_auto_close_duration {
    return scanner_auto_close_duration;
  }

  set setscanner_auto_close_duration(double duration) {
    scanner_auto_close_duration = duration;
  }

  int closeDration = 5;
  set setScannerCloseDuration(int duration) {
    closeDration = duration;
  }

  factory RemoteConfigHelper() {
    return _networkHelper;
  }
  RemoteConfigHelper._internal();
}

fetchRemoteConfigData() async {
  FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  try {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(hours: 24), // Cache refresh time
      minimumFetchInterval: Duration.zero,
    ));
    await remoteConfig.fetchAndActivate();
    RemoteConfigHelper().setUpgradePrompt =
        remoteConfig.getBool('shouldShowMandatoryUpgradePrompt');

    RemoteConfigHelper().setUpgradeText =
        remoteConfig.getString('mandatoryUpgradeText');

    RemoteConfigHelper().setScannerCloseDuration =
        remoteConfig.getInt('scanner_auto_close_duration');

    RemoteConfigHelper().setPaymentMessage =
        remoteConfig.getString('paymentMessage');

    RemoteConfigHelper().setUpiId = remoteConfig.getString('upiId');

    RemoteConfigHelper().setPaymentContact =
        remoteConfig.getString('paymentContact');

    RemoteConfigHelper().setBankName = remoteConfig.getString('bankName');

    RemoteConfigHelper().setBankAccountNo =
        remoteConfig.getString('bankAccountNo');

    RemoteConfigHelper().setBankIfscCode =
        RemoteConfigHelper().setBankName = remoteConfig.getString('bankName');

    RemoteConfigHelper().setBranchName = remoteConfig.getString('branchName');

    RemoteConfigHelper().sethelpContactNo =
        remoteConfig.getString('helpContactNo');

    RemoteConfigHelper().setapiBaseURL = remoteConfig.getString('apiBaseURL');
    RemoteConfigHelper().scanner_auto_close_duration = remoteConfig.getDouble('scanner_auto_close_duration');


  } catch (e) {
    print('remote config error : $e');
  }
}
