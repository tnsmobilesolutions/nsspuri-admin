import 'dart:convert';

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
  factory RemoteConfigHelper() {
    return _remoteConfigHelper;
  }

  RemoteConfigHelper._internal();

  Map<String, dynamic> allSangha = {};
  String apiBaseURL = "";
  String bankAccountNo = "";
  String bankIfscCode = "";
  String bankName = "";
  String branchName = "";
  int closeDration = 5;
  int devoteeCount = 20;
  String helpContactNo = "";
  //
  String mandatoryUpgradeText = "";

  String paymentContact = "";
  String paymentMessage = "";
  double scanner_auto_close_duration = 5;
  bool shouldShowMandatoryUpgradePrompt = false;
  String upiId = "";
  //
  String versionNumber = "";

  static final RemoteConfigHelper _remoteConfigHelper =
      RemoteConfigHelper._internal();

  bool get getShowMandatoryUpgradePrompt {
    return shouldShowMandatoryUpgradePrompt;
  }

  set setUpgradePrompt(bool upgradePrompt) {
    shouldShowMandatoryUpgradePrompt = upgradePrompt;
  }

  String get getMandatoryUpgradeText {
    return mandatoryUpgradeText;
  }

  set setUpgradeText(String upgradeText) {
    mandatoryUpgradeText = upgradeText;
  }

  String get getPaymentMessage {
    return paymentMessage;
  }

  set setPaymentMessage(String message) {
    paymentMessage = message;
  }

  String get getUpiId {
    return upiId;
  }

  set setUpiId(String upiIdLink) {
    upiId = upiIdLink;
  }

  String get getPaymentContact {
    return paymentContact;
  }

  set setPaymentContact(String contact) {
    paymentContact = contact;
  }

  String get getBankName {
    return bankName;
  }

  set setBankName(String name) {
    bankName = name;
  }

  String get getBankAccountNo {
    return bankAccountNo;
  }

  set setBankAccountNo(String accountNo) {
    bankAccountNo = accountNo;
  }

  String get getBankIfscCode {
    return bankIfscCode;
  }

  set setBankIfscCode(String ifscCode) {
    bankIfscCode = ifscCode;
  }

  String get getBranchName {
    return branchName;
  }

  set setBranchName(String brName) {
    branchName = brName;
  }

  String get gethelpContactNo {
    return helpContactNo;
  }

  set sethelpContactNo(String contactNo) {
    helpContactNo = contactNo;
  }

  String get getVersionNumber {
    return versionNumber;
  }

  set setVersionNumber(String versionNumberr) {
    versionNumber = versionNumberr;
  }

  String get getapiBaseURL {
    return apiBaseURL;
  }

  set setapiBaseURL(String baseURL) {
    apiBaseURL = baseURL;
  }

  double get getscanner_auto_close_duration {
    return scanner_auto_close_duration;
  }

  set setscanner_auto_close_duration(double duration) {
    scanner_auto_close_duration = duration;
  }

  set setScannerCloseDuration(int duration) {
    closeDration = duration;
  }

  set setDataCountPerPage(int count) {
    devoteeCount = count;
  }

  int get getDataCountPerPage {
    return devoteeCount;
  }

  set setSanghaList(Map<String, dynamic> sanghas) {
    allSangha = sanghas;
  }

  Map<String, dynamic> get getSanghaList {
    return allSangha;
  }
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

    String sanghaNamesJsonString =
        remoteConfig.getString('sangha_names_font_size');
    Map<String, dynamic> sanghaNamesMap = json.decode(sanghaNamesJsonString);
    RemoteConfigHelper().setSanghaList = sanghaNamesMap;

    RemoteConfigHelper().setUpgradeText =
        remoteConfig.getString('mandatoryUpgradeText');

    RemoteConfigHelper().setScannerCloseDuration =
        remoteConfig.getInt('scanner_auto_close_duration');

    RemoteConfigHelper().setDataCountPerPage =
        remoteConfig.getInt('data_count_per_page');

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
    RemoteConfigHelper().scanner_auto_close_duration =
        remoteConfig.getDouble('scanner_auto_close_duration');
  } catch (e) {
    print('remote config error : $e');
  }
}
