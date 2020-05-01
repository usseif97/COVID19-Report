import 'package:flutter/material.dart';
import '../models/country.dart';
import 'package:intl/intl.dart';

class DataSource extends DataTableSource {
  final List<Country> list;
  int selectedCount = 0;
  DataSource(this.list);

  @override
  int get rowCount => list.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;

  @override
  DataRow getRow(int index) {
    final Country tempCountry = list[index];
    var f = new NumberFormat(",000", "en_US");

    return DataRow.byIndex(index: index, cells: <DataCell>[
      DataCell(
        Row(
          children: <Widget>[
            Text(tempCountry.countryName),
            Container(
              height: 50,
              width: 50,
              padding: EdgeInsets.all(5),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
                child: Image.network(tempCountry.countryFlag),
              ),
            ),
          ],
        ),
      ),
      //String parsedNumber = (f.format(int.parse(number)));

      DataCell(Text(f.format(int.parse(tempCountry.countryCases)))),
      DataCell(Text(f.format(int.parse(tempCountry.countryDeaths)))),
      DataCell(Text(f.format(int.parse(tempCountry.countryRecovered)))),
      DataCell(Text(f.format(int.parse(tempCountry.countryTodayCases)))),
      DataCell(Text(f.format(int.parse(tempCountry.countryTodayDeaths)))),
    ]);
  }
}
