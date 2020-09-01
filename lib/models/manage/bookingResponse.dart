class BookingStatusResponse {
  String bookingDate;
  String bookingSlot;
  String branchNameArabic;
  String branchNameEnglish;
  String emailAddress;
  int id;
  int nationalIdOrIQAMA;
  String qrcodeval;
  List<BookingService> services;
  String visitorName;

  BookingStatusResponse.fromJSON(Map<String, dynamic> parsedJson) {
    this.bookingDate = parsedJson['BookingDate'];
    this.bookingSlot = parsedJson['BookingSlot'];
    this.branchNameArabic = parsedJson['BranchNameArabic'];
    this.branchNameEnglish = parsedJson['BranchNameEnglish'];
    this.emailAddress = parsedJson['EmailAddress'];
    this.id = parsedJson['Id'];
    this.nationalIdOrIQAMA = parsedJson['NationalIdOrIQAMA'];
    this.qrcodeval = parsedJson['qrcodeval'];
    this.services = parsedJson['Services'] != null ? BookingService.fromJSON(parsedJson['Services']) as List<BookingService> : null;
    this.visitorName = parsedJson['VisitorName'];
  }
}

class BookingService {
  int serviceId;
  String serviceNameArabic;
  String serviceNameEnglish;

  BookingService.fromJSON(Map<String, dynamic> parsedJson) {
    this.serviceId = parsedJson['ServiceId'];
    this.serviceNameArabic = parsedJson['ServiceNameArabic'];
    this.serviceNameEnglish = parsedJson['ServiceNameEnglish'];
  }
}
