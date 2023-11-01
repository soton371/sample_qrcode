// To parse this JSON data, do
//
//     final submitLabelModel = submitLabelModelFromJson(jsonString);

import 'dart:convert';

SubmitLabelModel submitLabelModelFromJson(String str) => SubmitLabelModel.fromJson(json.decode(str));

String submitLabelModelToJson(SubmitLabelModel data) => json.encode(data.toJson());

class SubmitLabelModel {
    String? message;
    int? statusCode;
    List<SubmitListResponse>? submitListResponse;

    SubmitLabelModel({
        this.message,
        this.statusCode,
        this.submitListResponse,
    });

    factory SubmitLabelModel.fromJson(Map<String, dynamic> json) => SubmitLabelModel(
        message: json["message"],
        statusCode: json["statusCode"],
        submitListResponse: json["listResponse"] == null ? [] : List<SubmitListResponse>.from(json["listResponse"]!.map((x) => SubmitListResponse.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "statusCode": statusCode,
        "listResponse": submitListResponse == null ? [] : List<dynamic>.from(submitListResponse!.map((x) => x.toJson())),
    };
}

class SubmitListResponse {
    String? samplePkgNo;
    dynamic performBy;
    dynamic udPerformBy;
    dynamic userDeviceNo;
    dynamic userDeviceDtm;
    dynamic serverDtm;
    dynamic appsNo;
    dynamic sessionId;
    int? packingId;
    int? allocationYymm;
    String? allocationGrpNo;
    int? pkgSlotId;
    dynamic mkgProfNo;
    String? alocMonName;
    String? alocGrpName;
    String? pkgSlotName;
    dynamic mkgProfName;
    dynamic mktGrpEmpNo;
    dynamic mktGrpEmpNm;
    dynamic splReceivedNo;
    dynamic rcvDempNo;
    dynamic splRcvNm;
    dynamic alocProfNo;
    dynamic alocEmpNo;
    int? packingBy;
    String? udPackingBy;
    String? qrData;
    dynamic divs;

    SubmitListResponse({
        this.samplePkgNo,
        this.performBy,
        this.udPerformBy,
        this.userDeviceNo,
        this.userDeviceDtm,
        this.serverDtm,
        this.appsNo,
        this.sessionId,
        this.packingId,
        this.allocationYymm,
        this.allocationGrpNo,
        this.pkgSlotId,
        this.mkgProfNo,
        this.alocMonName,
        this.alocGrpName,
        this.pkgSlotName,
        this.mkgProfName,
        this.mktGrpEmpNo,
        this.mktGrpEmpNm,
        this.splReceivedNo,
        this.rcvDempNo,
        this.splRcvNm,
        this.alocProfNo,
        this.alocEmpNo,
        this.packingBy,
        this.udPackingBy,
        this.qrData,
        this.divs,
    });

    factory SubmitListResponse.fromJson(Map<String, dynamic> json) => SubmitListResponse(
        samplePkgNo: json["samplePkgNo"],
        performBy: json["performBy"],
        udPerformBy: json["udPerformBy"],
        userDeviceNo: json["userDeviceNo"],
        userDeviceDtm: json["userDeviceDTM"],
        serverDtm: json["serverDTM"],
        appsNo: json["appsNo"],
        sessionId: json["sessionId"],
        packingId: json["packingId"],
        allocationYymm: json["allocationYYMM"],
        allocationGrpNo: json["allocationGrpNo"],
        pkgSlotId: json["pkgSlotId"],
        mkgProfNo: json["mkgProfNo"],
        alocMonName: json["alocMonName"],
        alocGrpName: json["alocGrpName"],
        pkgSlotName: json["pkgSlotName"],
        mkgProfName: json["mkgProfName"],
        mktGrpEmpNo: json["mktGrpEmpNo"],
        mktGrpEmpNm: json["mktGrpEmpNm"],
        splReceivedNo: json["splReceivedNo"],
        rcvDempNo: json["rcvDempNo"],
        splRcvNm: json["splRcvNm"],
        alocProfNo: json["alocProfNo"],
        alocEmpNo: json["alocEmpNo"],
        packingBy: json["packingBy"],
        udPackingBy: json["udPackingBy"],
        qrData: json["qrData"],
        divs: json["divs"],
    );

    Map<String, dynamic> toJson() => {
        "samplePkgNo": samplePkgNo,
        "performBy": performBy,
        "udPerformBy": udPerformBy,
        "userDeviceNo": userDeviceNo,
        "userDeviceDTM": userDeviceDtm,
        "serverDTM": serverDtm,
        "appsNo": appsNo,
        "sessionId": sessionId,
        "packingId": packingId,
        "allocationYYMM": allocationYymm,
        "allocationGrpNo": allocationGrpNo,
        "pkgSlotId": pkgSlotId,
        "mkgProfNo": mkgProfNo,
        "alocMonName": alocMonName,
        "alocGrpName": alocGrpName,
        "pkgSlotName": pkgSlotName,
        "mkgProfName": mkgProfName,
        "mktGrpEmpNo": mktGrpEmpNo,
        "mktGrpEmpNm": mktGrpEmpNm,
        "splReceivedNo": splReceivedNo,
        "rcvDempNo": rcvDempNo,
        "splRcvNm": splRcvNm,
        "alocProfNo": alocProfNo,
        "alocEmpNo": alocEmpNo,
        "packingBy": packingBy,
        "udPackingBy": udPackingBy,
        "qrData": qrData,
        "divs": divs,
    };
}
