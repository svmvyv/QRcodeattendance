class LecAttendance {
  final String Username;
  final String FullName;
  final String Status;
  final String Statusdesc;

  LecAttendance(
      this.Username,
      this.FullName,
      this.Status,
      this.Statusdesc,
      );
  factory LecAttendance.fromJson(Map<String, dynamic> json) {
    return LecAttendance(
      json['Username'],
      json['FullName'],
      json['Status'],
      json['Statusdesc'],
    );
  }
}