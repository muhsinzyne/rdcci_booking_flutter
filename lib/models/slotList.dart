class SlotsList {
  int bookCount;
  String date;
  String slotDate;

  SlotsList.fromJSON(Map<String, dynamic> parsedJson) {
    this.bookCount = parsedJson['BookCount'];
    this.date = parsedJson['Date'];
    this.slotDate = parsedJson['SlotDate'];
  }
}
