import 'package:iot/rest/english_to_persian.dart';
import 'package:shamsi_date/shamsi_date.dart';

class DateTimeModifier {
  String dateTime = '';
  String date = '';
  String time = '';

  DateTimeModifier(this.dateTime){
    this.date = dateTime.split("T")[0];
    this.time = dateTime.split("T")[1];
  }

  getFarsiDate(){
    int year=int.parse(this.date.split("-")[0]);
    int month=int.parse(this.date.split("-")[1]);
    int date=int.parse(this.date.split("-")[2]);

    final gregorianDate = Gregorian(year,month,date);
    final persianDate = gregorianDate.toJalali();
    return EnglishToPersian(format1(persianDate)).getNumber();
  }
  String format1(Date d) {
    final f = d.formatter;
    return '${f.wN} ${f.d} ${f.mN} ${f.yy}';
  }

  getFarsiTime(){
    String newTime = "ساعت "+time.split(":")[0]+":"+time.split(":")[1];
    return EnglishToPersian(newTime).getNumber();
  }

  getFarsiDateTime(){
    return getFarsiDate()+" "+getFarsiTime();
  }
}
