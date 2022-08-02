class Courses {
  final String CourseName;
  final String SectionName;
  final String sectiondays;
  final String StartTime;
  final String EndTime;
  final int canattand;
  final String SectionID;
  final String BeaconID;
  Courses(
     this.CourseName,
     this.SectionName,
     this.sectiondays,
     this.StartTime,
     this.EndTime,
     this.canattand,
     this.SectionID,
      this.BeaconID,
  );
  factory Courses.fromJson(Map<String, dynamic> json) {
    return Courses(
       json['CourseName'],
       json['SectionName'],
       json['sectiondays'],
       json['StartTime'],
       json['EndTime'],
       json['canattand'],
       json['SectionID'],
       json['BeaconID'],
    );
  }
}

class Track {
  final String CourseName;
  final String SectionName;
  final String LECDate;
  final String TrackDate;
  final String TrackTime;

  Track(
      this.CourseName,
      this.SectionName,
      this.LECDate,
      this.TrackDate,
      this.TrackTime,
      );
  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      json['CourseName'],
      json['SectionName'],
      json['LECDate'],
      json['TrackDate'],
      json['TrackTime'],
    );
  }
}

