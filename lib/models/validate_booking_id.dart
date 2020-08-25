class ValidateBookingID {
  String bookingDate;
  String bookingSlot;
  int branchAvailabilityTimeSlotId;
  int branchId;
  String emailAddress;
  int id;
  int nationalIDOrIQAMA;
  int status;
  String visitorName;

  ValidateBookingID.fromJSON(Map<String, dynamic> parsedJson) {
    this.bookingDate = parsedJson['BookingDate'];
    this.bookingSlot = parsedJson['BookingSlot'];
    this.branchAvailabilityTimeSlotId = parsedJson['BranchAvailabilityTimeSlotId'];
    this.branchId = parsedJson['BranchId'];
    this.emailAddress = parsedJson['EmailAddress'];
    this.id = parsedJson['Id'];
    this.nationalIDOrIQAMA = parsedJson['National_ID_or_IQAMA'];
    this.status = parsedJson['Status'];
    this.visitorName = parsedJson['VisitorName'];
  }
}
