import 'package:excel/excel.dart';
import 'package:sdp/model/devotee_model.dart';

class ExportToExcel {
  void exportToExcel(List<DevoteeModel> devotees) async {
    final excel = Excel.createExcel();
    final sheet = excel[excel.getDefaultSheet().toString()];
    List<TextCellValue> headers = [
      const TextCellValue("Devotee Name"),
      const TextCellValue("Code"),
      const TextCellValue("Sangha"),
      const TextCellValue("DOB"),
      const TextCellValue("Status"),
      const TextCellValue("Pranami (₹)"),
    ];

    sheet.appendRow(headers);

    for (int i = 1; i <= devotees.length; i++) {
      sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i))
              .value =
          devotees[i - 1].name != null
              ? TextCellValue(devotees[i - 1].name.toString())
              : const TextCellValue("");
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i))
          .value = TextCellValue("${devotees[i - 1].devoteeCode}");
      sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i))
              .value =
          devotees[i - 1].sangha != null
              ? TextCellValue(devotees[i - 1].sangha.toString())
              : const TextCellValue("");
      sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i))
              .value =
          devotees[i - 1].dob != null
              ? TextCellValue(devotees[i - 1].dob.toString())
              : const TextCellValue("");
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i))
          .value = TextCellValue(devotees[i - 1].status.toString());
      sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i))
              .value =
          devotees[i - 1].paidAmount != null
              ? TextCellValue(devotees[i - 1].paidAmount.toString())
              : const TextCellValue("");
    }

    for (int col = 0; col < headers.length; col++) {
      switch (col) {
        case 0: //A
          sheet.setColumnWidth(col, 30);
          break;
        case 1: //B
          sheet.setColumnWidth(col, 15);
          break;
        case 2: //C
          sheet.setColumnWidth(col, 30);
          break;
        case 3: //D
          sheet.setColumnWidth(col, 20);
          break;
        case 4: //E
          sheet.setColumnWidth(col, 20);
          break;
        case 5: //F
          sheet.setColumnWidth(col, 15);
          break;
        default:
          sheet.setColumnWidth(col, 10);
      }
    }

    excel.save(fileName: "devotees.xlsx");
  }
}
