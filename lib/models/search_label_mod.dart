// To parse this JSON data, do
//
//     final searchLabelModel = searchLabelModelFromJson(jsonString);

import 'dart:convert';

SearchLabelModel searchLabelModelFromJson(String str) => SearchLabelModel.fromJson(json.decode(str));

String searchLabelModelToJson(SearchLabelModel data) => json.encode(data.toJson());

class SearchLabelModel {
    String? message;
    int? statusCode;
    List<ListResponse>? listResponse;

    SearchLabelModel({
        this.message,
        this.statusCode,
        this.listResponse,
    });

    factory SearchLabelModel.fromJson(Map<String, dynamic> json) => SearchLabelModel(
        message: json["message"],
        statusCode: json["statusCode"],
        listResponse: json["listResponse"] == null ? [] : List<ListResponse>.from(json["listResponse"]!.map((x) => ListResponse.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "statusCode": statusCode,
        "listResponse": listResponse == null ? [] : List<dynamic>.from(listResponse!.map((x) => x.toJson())),
    };
}

class ListResponse {
    String? allocationInfo;
    int? allocationYymm;
    String? allocationGrpNo;
    String? grpName;
    int? pkgSlotId;
    String? pkgSlotName;
    int? printedBcLblNo;
    int? totalBarcodeLblNo;
    String? allocateMoney;
    int? maxPrintQty;
    bool isSelected;

    ListResponse({
        this.allocationInfo,
        this.allocationYymm,
        this.allocationGrpNo,
        this.grpName,
        this.pkgSlotId,
        this.pkgSlotName,
        this.printedBcLblNo,
        this.totalBarcodeLblNo,
        this.allocateMoney,
        this.maxPrintQty,
        this.isSelected = false,
    });

    factory ListResponse.fromJson(Map<String, dynamic> json) => ListResponse(
        allocationInfo: json["allocationInfo"],
        allocationYymm: json["allocationYYMM"],
        allocationGrpNo: json["allocationGrpNo"],
        grpName: json["grpName"],
        pkgSlotId: json["pkgSlotId"],
        pkgSlotName: json["pkgSlotName"],
        printedBcLblNo: json["printedBCLblNo"],
        totalBarcodeLblNo: json["totalBarcodeLblNo"],
        allocateMoney: json["allocateMoney"],
        maxPrintQty: json["maxPrintQty"],
    );

    Map<String, dynamic> toJson() => {
        "allocationInfo": allocationInfo,
        "allocationYYMM": allocationYymm,
        "allocationGrpNo": allocationGrpNo,
        "grpName": grpName,
        "pkgSlotId": pkgSlotId,
        "pkgSlotName": pkgSlotName,
        "printedBCLblNo": printedBcLblNo,
        "totalBarcodeLblNo": totalBarcodeLblNo,
        "allocateMoney": allocateMoney,
        "maxPrintQty": maxPrintQty,
    };
}
