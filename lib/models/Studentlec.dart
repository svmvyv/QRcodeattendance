class Studentlec {
  final String CourseName;
  final String SectionName;
  final String StartTime;
  final String EndTime;
  final String LECDate;
  final String SectionLecID;
  final String statusdesc;
  Studentlec(
      this.CourseName,
      this.SectionName,
      this.StartTime,
      this.EndTime,
      this.LECDate,
      this.SectionLecID,
      this.statusdesc,
      );
  factory Studentlec.fromJson(Map<String, dynamic> json) {
    return Studentlec(
      json['CourseName'],
      json['SectionName'],
      json['StartTime'],
      json['EndTime'],
      json['LECDate'],
      json['SectionLecID'],
      json['statusdesc'],
    );
  }
}