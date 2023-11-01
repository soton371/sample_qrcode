import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sample_qrcode/blocs/submit_label/submit_label_bloc.dart';
import 'package:sample_qrcode/config/colors.dart';
import 'package:sample_qrcode/config/sizes.dart';
import 'package:sample_qrcode/config/urls.dart';
import 'package:sample_qrcode/database/app_db.dart';
import 'package:sample_qrcode/models/search_label_mod.dart';
import 'package:sample_qrcode/services/search_label_ser.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:sample_qrcode/utilities/fetch_device_id.dart';
import 'package:sample_qrcode/utilities/maxcount.dart';
import 'package:sample_qrcode/utilities/search.dart';
import 'package:sample_qrcode/views/signin/signin_scr.dart';
import 'package:sample_qrcode/widgets/app_alert.dart';
import 'package:sample_qrcode/widgets/app_button.dart';

class GenerateQrScreen extends StatefulWidget {
  const GenerateQrScreen({super.key});

  @override
  State<GenerateQrScreen> createState() => _GenerateQrScreenState();
}

class _GenerateQrScreenState extends State<GenerateQrScreen> {
  List<ListResponse> items = [];
  List<ListResponse> duplicateItems = [];
  TextEditingController queryCon = TextEditingController(text: '');
  String selectedItem = '';
  Future getData() async {
    final d = await fetchSearchLabelData();

    duplicateItems = d.listResponse ?? [];
    items = searchData(duplicateItems, queryCon.text);
    setState(() {});
  }

  String? userName;

  Map<String, Object>? payload;
  int? packgingBy, performBy, sessionId, dd, pkgSlotId;
  String? udPackgingBy, userDeviceNo, userDeviceDTM, udPerformBy, group;
  Future<void> requirePayload() async {
    userName = await AppDB.fetchUserName();
    packgingBy = await AppDB.fetchSaUserId();
    performBy = packgingBy;
    final session = await AppDB.fetchSessionId();
    sessionId = int.parse(session);
    udPackgingBy = await AppDB.fetchUserCode();
    udPerformBy = udPackgingBy;
    userDeviceNo = await fetchDeviceId();
    userDeviceDTM = DateTime.now().toString();
  }

  @override
  void initState() {
    super.initState();
    getData();
    requirePayload();
  }

  int? previousSelect;
  TextEditingController maxPrintCon = TextEditingController(text: '');
  int? maxPrint;

  //for test
  var doc;
  String? pkgSlotName;
  String? allocateMoney;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<SubmitLabelBloc, SubmitLabelState>(
          listener: (context, state) {
            if (state is PrintingSuccess) {
              Navigator.pop(context);
            } else if (state is SubmitLabelException) {
              Navigator.pop(context);
              appAlert(context, title: Text(state.msg), actions: [
                AppButton(
                    bgColor: AppColors.grey,
                    textColor: AppColors.black,
                    name: "Close",
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ]);
            }
          },
          child: Row(
            children: [
              //for list
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          userName == null
                              ? const SizedBox()
                              : Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Login as "),
                                      Text(
                                        "$userName",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: AppSizes.width(context) *
                                                0.013),
                                      ),
                                    ],
                                  ),
                                ),
                          IconButton(
                              icon: const Icon(
                                Icons.logout,
                                color: AppColors.seed,
                              ),
                              onPressed: () async {
                                appAlert(context,
                                    title: const Text("Print"),
                                    content: const Text(
                                        "Are you sure you to want log out?"),
                                    actions: [
                                      AppButton(
                                          name: "Cancel",
                                          bgColor: AppColors.grey,
                                          textColor: AppColors.black,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }),
                                      AppButton(
                                          name: "Logout",
                                          onPressed: () {
                                            AppDB.clearUserInfo();
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        const SignInScreen()));
                                          }),
                                    ]);
                              })
                        ],
                      ),
                    ),

                    //search box
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: TextField(
                        controller: queryCon,
                        onChanged: (value) {
                          queryCon.text = value;
                          items = searchData(duplicateItems, queryCon.text);
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            hintText: "Find a info",
                            isDense: true,
                            suffixIcon: queryCon.text == ''
                                ? const RotatedBox(
                                    quarterTurns: 1,
                                    child:
                                        Icon(Icons.search, color: Colors.grey))
                                : IconButton(
                                    onPressed: () {
                                      queryCon.text = '';
                                      items = searchData(
                                          duplicateItems, queryCon.text);
                                      setState(() {});
                                    },
                                    icon: const Icon(CupertinoIcons.multiply)),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide: BorderSide(
                                    color: AppColors.seed, width: 1.5)),
                            enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                gapPadding: 0,
                                borderSide: BorderSide(
                                    color: Colors.grey, width: 1.5))),
                      ),
                    ),
                    //search box
                    const SizedBox(height: 10),

                    Expanded(
                      child: items.isEmpty
                          ? const Text(
                              "\nNo data available",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: AppColors.grey),
                            )
                          : ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (_, i) {
                                final data = items[i];
                                maxPrint = maxCount(data);
                                return Column(
                                  children: [
                                    ListTile(
                                      selected: data.isSelected,
                                      onTap: () async {
                                        selectedItem =
                                            data.allocationInfo ?? '';
                                        maxPrintCon.text = maxPrint.toString();

                                        items[previousSelect ?? 0].isSelected =
                                            false;
                                        previousSelect = i;
                                        data.isSelected = !data.isSelected;
                                        group = data.allocationGrpNo ?? '';
                                        dd = data.allocationYymm ?? 0;
                                        pkgSlotId = data.pkgSlotId ?? 0;
                                        pkgSlotName = data.pkgSlotName ?? '';
                                        allocateMoney = data.allocateMoney ?? '';

                                        setState(() {});
                                      },
                                      leading: data.isSelected
                                          ? Container(
                                              height: 35,
                                              width: 3,
                                              color: AppColors.seed,
                                            )
                                          : null,
                                      minLeadingWidth: 3,
                                      title: HtmlWidget(
                                          data.allocationInfo ?? 'null'),
                                      subtitle: Text(
                                        "Max print: $maxPrint",
                                        style: const TextStyle(
                                            color: Colors.blueGrey),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                    )
                  ],
                ),
              ),

              const VerticalDivider(
                width: 0,
              ),
              //for qr preview section
              Expanded(
                flex: 2,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/printer.png',
                          height: AppSizes.height(context) * 0.3,
                          width: AppSizes.width(context) * 0.3,
                        ),
                        previousSelect == null
                            ? const Text(
                                "\nSelect your information to save and print\n",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: AppColors.grey),
                              )
                            : const Text(
                                "\nReady your information to save and print\n",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: AppColors.grey),
                              ),
                        previousSelect == null
                            ? const SizedBox()
                            : ElevatedButton(
                                onPressed: () {
                                  final pi =
                                      isPositiveInteger(maxPrintCon.text);
                                  if (!pi) {
                                    appAlert(context,
                                        title: Text(
                                            "Bad input ${maxPrintCon.text}"),
                                        content: const Text(
                                            "Please enter a positive integer value as a print quantity"),
                                        actions: [
                                          AppButton(
                                              bgColor: AppColors.grey,
                                              textColor: AppColors.black,
                                              name: "Close",
                                              onPressed: () {
                                                Navigator.pop(context);
                                              })
                                        ]);
                                    return;
                                  }
                                  final ne = isPositiveIntegerInRange(
                                      maxPrintCon.text, 1, maxPrint ?? 1000);
                                  if (!ne) {
                                    appAlert(context,
                                        title: const Text(
                                          "Print Warning!!",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        content: Text(
                                            "Your input value is ${int.parse(maxPrintCon.text) < 0 ? 'less than the minimum print quantity.' : 'greater than the maximum print quantity.'} Please enter a valid print quantity"),
                                        actions: [
                                          AppButton(
                                              bgColor: AppColors.grey,
                                              textColor: AppColors.black,
                                              name: "Close",
                                              onPressed: () {
                                                Navigator.pop(context);
                                              })
                                        ]);
                                    return;
                                  }

                                  //for send & print
                                  payload = {
                                    "allocationYYMM": dd ?? 0,
                                    "allocationGrpNo": group ?? '',
                                    "pkgSlotId": pkgSlotId ?? 0,
                                    "packgingBy": packgingBy ?? 0,
                                    "udPackgingBy": udPackgingBy ?? "",
                                    "performBy": performBy ?? 0,
                                    "udPerformBy": udPerformBy ?? "",
                                    "userDeviceNo": userDeviceNo ?? '',
                                    "userDeviceDTM": userDeviceDTM ?? '',
                                    "appNo": AppUrls.appId,
                                    "sessionId": sessionId ?? 0,
                                    "noOfQty": maxPrintCon.text
                                  };

                                  appAlert(context,
                                      title: const Text("Print"),
                                      content: const Text(
                                          "Are you sure you want to print?"),
                                      actions: [
                                        AppButton(
                                            name: "No",
                                            bgColor: AppColors.grey,
                                            textColor: AppColors.black,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }),
                                        AppButton(
                                            name: "Yes",
                                            onPressed: () {
                                              Navigator.pop(context);
                                              context
                                                  .read<SubmitLabelBloc>()
                                                  .add(DoSubmitLabelEvent(
                                                      payload: payload ?? {},saUser: packgingBy.toString()));
                                              submitAlert();
                                            }),
                                      ]);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.seed,
                                    shape: const LinearBorder()),
                                child: const Text('Save & Print',
                                    style: TextStyle(color: AppColors.white))),
                      ],
                    ),
                    selectedItem == ''
                        ? const SizedBox()
                        : Positioned(
                            top: 40,
                            child: Row(
                              children: [
                                QrImageView(
                                  data: selectedItem,
                                  version: QrVersions.auto,
                                  size: 114.2,
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                     Text(
                                      "$dd$group##########",
                                      style: const TextStyle(fontSize: 9),
                                    ),
                                    Text(
                                      allocateMoney ?? '',
                                      style: const TextStyle(fontSize: 9),
                                    ),
                                     Text(
                                      group??'',
                                      style: const TextStyle(
                                          fontSize: 31,
                                          fontWeight: FontWeight.bold),
                                    ),
                                     Text(
                                      pkgSlotName ?? '',
                                      style: const TextStyle(fontSize: 9),
                                    ),
                                    Text(
                                      "$performBy",
                                      style: const TextStyle(fontSize: 9),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 20,),
                                SizedBox(
                                width: 130,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  controller: maxPrintCon,
                                  
                                  decoration: const InputDecoration(
                                      isDense: true,
                                      hintText: "Enter max print"),
                                ))
                              ],
                            ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submitAlert() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
              backgroundColor: AppColors.white,
              shape: const LinearBorder(),
              title: BlocBuilder<SubmitLabelBloc, SubmitLabelState>(
                builder: (context, state) {
                  if (state is SubmitLabelInitial) {
                    return const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [Text('Sending\n'), LinearProgressIndicator()],
                    );
                  } else if (state is SubmitLabelSuccess) {
                    return const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [Text('Printing\n'), LinearProgressIndicator()],
                    );
                  } else {
                    return const Text('');
                  }
                },
              ),
            ));
  }
}
