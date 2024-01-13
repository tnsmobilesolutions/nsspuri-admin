import 'package:excel/excel.dart';
import 'package:sdp/model/devotee_model.dart';

class ExportToExcel {
  void exportToExcel(List<DevoteeModel> devotees) async {
    final excel = Excel.createExcel();
    final sheet = excel[excel.getDefaultSheet().toString()];

    sheet.appendRow([
      const TextCellValue("Devotee Name"),
      const TextCellValue("Code"),
      const TextCellValue("Sangha"),
      const TextCellValue("DOB"),
      const TextCellValue("Status"),
      const TextCellValue("Pranami (₹)"),
    ]);

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

    for (int col = 0; col < 6; col++) {
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
  // void exportToExcel(List<DevoteeModel> devotees) async {
  //   final excel = Excel.createExcel();

  //   final sheet = excel[excel.getDefaultSheet().toString()];

  //   // Add headers to the sheet
  //   sheet.appendRow([
  //     const TextCellValue("Sl. no"),
  //     const TextCellValue("Devotee Name"),
  //     const TextCellValue("Code"),
  //     const TextCellValue("Sangha"),
  //     const TextCellValue("DOB"),
  //     const TextCellValue("Status"),
  //   ]);

  //   int startingRowIndex = 2;

  //   for (int i = 0; i < devotees.length; i++) {
  //     sheet
  //         .cell(CellIndex.indexByColumnRow(
  //             columnIndex: 0, rowIndex: i + startingRowIndex))
  //         .value = TextCellValue("${i + 1}");
  //     sheet
  //         .cell(CellIndex.indexByColumnRow(
  //             columnIndex: 1, rowIndex: i + startingRowIndex))
  //         .value = TextCellValue(devotees[i].name.toString());
  //     sheet
  //         .cell(CellIndex.indexByColumnRow(
  //             columnIndex: 2, rowIndex: i + startingRowIndex))
  //         .value = TextCellValue("${devotees[i].devoteeCode}");
  //     sheet
  //         .cell(CellIndex.indexByColumnRow(
  //             columnIndex: 3, rowIndex: i + startingRowIndex))
  //         .value = TextCellValue(devotees[i].sangha.toString());
  //     sheet
  //         .cell(CellIndex.indexByColumnRow(
  //             columnIndex: 4, rowIndex: i + startingRowIndex))
  //         .value = TextCellValue(devotees[i].dob.toString());
  //     sheet
  //         .cell(CellIndex.indexByColumnRow(
  //             columnIndex: 5, rowIndex: i + startingRowIndex))
  //         .value = TextCellValue(devotees[i].status.toString());
  //   }

  //   for (int col = 0; col < 6; col++) {
  //     switch (col) {
  //       case 0:
  //         sheet.setColumnWidth(col, 10);
  //         break;
  //       case 1:
  //         sheet.setColumnWidth(col, 30);
  //         break;
  //       case 2:
  //         sheet.setColumnWidth(col, 10);
  //         break;
  //       case 3:
  //         sheet.setColumnWidth(col, 30);
  //         break;
  //       case 4:
  //         sheet.setColumnWidth(col, 15);
  //         break;
  //       case 5:
  //         sheet.setColumnWidth(col, 15);
  //         break;
  //       default:
  //       // sheet.setColumnWidth(col, 10);
  //     }
  //   }

  //   excel.save(fileName: "devotees.xlsx");
  // }
}
