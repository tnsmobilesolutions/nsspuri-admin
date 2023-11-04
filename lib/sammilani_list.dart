import 'package:sdp/API/paliaaAPI.dart';
import 'package:sdp/Models/sammilaniModel.dart';

class SammilaniUtility {
  static List<SammilaniModel> getAllSammilaniName() {
    var f = allSammilaniList.map((s) => s);
    return f.toList();
  }

  static List<SammilaniModel> lastnSammilani(int n) {
    // var f = allSammilaniList.map((s) => s);

    var f = allSammilaniList
        .getRange(allSammilaniList.length - n, allSammilaniList.length)
        .map((e) => e);
    return f.toList().reversed.toList();
  }

  static Future<int> paliaNumber(year) async {
    var f = await PaliaAPI().fetchAllByYearPalias(year);
    return f.toList().length;
  }
}

// class SammilaniList {
//   SammilaniList(
//       {this.sammilaniNumber, this.sammilaniYear, this.sammilaniPlace});
//   int? sammilaniYear;
//   String? sammilaniPlace;
//   int? sammilaniNumber;
// }

final allSammilaniList = [
  SammilaniModel(
      sammilaniNumber: '1',
      sammilaniYear: '1947',
      sammilaniPlace: 'Ankoli, Berhampur'),
  SammilaniModel(
      sammilaniNumber: '2',
      sammilaniYear: '1948',
      sammilaniPlace: 'Jobra, Cuttack'),
  SammilaniModel(
      sammilaniNumber: '3',
      sammilaniYear: '1949',
      sammilaniPlace: 'Banahara,Gopa, Puri'),
  SammilaniModel(
      sammilaniNumber: '4',
      sammilaniYear: '1950',
      sammilaniPlace: 'Digapahandi, Ganjam'),
  SammilaniModel(
      sammilaniNumber: '5',
      sammilaniYear: '1951',
      sammilaniPlace: 'Jobra, Cuttack'),
  SammilaniModel(
      sammilaniNumber: '6',
      sammilaniYear: '1952',
      sammilaniPlace: 'Erabanga,Gopa, Puri'),
  SammilaniModel(
      sammilaniNumber: '7',
      sammilaniYear: '1953',
      sammilaniPlace: 'Padmapura,Sheragarh,Ganjam'),
  SammilaniModel(
      sammilaniNumber: '8',
      sammilaniYear: '1954',
      sammilaniPlace: 'Jobra, Cuttack'),
  SammilaniModel(
      sammilaniNumber: '9',
      sammilaniYear: '1955',
      sammilaniPlace: 'Biratunga, Puri'),
  SammilaniModel(
      sammilaniNumber: '10',
      sammilaniYear: '1956',
      sammilaniPlace: 'Jobra, Cuttack'),
  SammilaniModel(
      sammilaniNumber: '11',
      sammilaniYear: '1958',
      sammilaniPlace: 'Biratunga, Puri'),
  SammilaniModel(
      sammilaniNumber: '12',
      sammilaniYear: '1959',
      sammilaniPlace: 'Jobra, Cuttack'),
  SammilaniModel(
      sammilaniNumber: '13',
      sammilaniYear: '1960',
      sammilaniPlace: 'Kendupatana,Cuttack'),
  SammilaniModel(
      sammilaniNumber: '14',
      sammilaniYear: '1962',
      sammilaniPlace: 'Chatara,Jagatsinghpur'),
  SammilaniModel(
      sammilaniNumber: '15',
      sammilaniYear: '1963',
      sammilaniPlace: 'Biratunga,Puri(Formality)'),
  SammilaniModel(
      sammilaniNumber: '16',
      sammilaniYear: '1964',
      sammilaniPlace: 'Jobra, Cuttack'),
  SammilaniModel(
      sammilaniNumber: '17',
      sammilaniYear: '1965',
      sammilaniPlace: 'Biratunga, Puri'),
  SammilaniModel(
      sammilaniNumber: '18',
      sammilaniYear: '1966',
      sammilaniPlace: 'Biratunga, Puri'),
  SammilaniModel(
      sammilaniNumber: '19',
      sammilaniYear: '1968',
      sammilaniPlace: 'Sora,Balesore'),
  SammilaniModel(
      sammilaniNumber: '20',
      sammilaniYear: '1969',
      sammilaniPlace: 'Biratunga, Puri(Formality)'),
  SammilaniModel(
      sammilaniNumber: '21',
      sammilaniYear: '1970',
      sammilaniPlace: 'Matia, Pattamundai'),
  SammilaniModel(
      sammilaniNumber: '22',
      sammilaniYear: '1971',
      sammilaniPlace: 'Samantarapur, Bhubaneswar'),
  SammilaniModel(
      sammilaniNumber: '23',
      sammilaniYear: '1972',
      sammilaniPlace: 'Kendupatana, Cuttack'),
  SammilaniModel(
      sammilaniNumber: '24',
      sammilaniYear: '1973',
      sammilaniPlace: 'Biratunga, Puri(Formality)'),
  SammilaniModel(
      sammilaniNumber: '25',
      sammilaniYear: '1974',
      sammilaniPlace: 'Biratunga, Puri(Formality)'),
  SammilaniModel(
      sammilaniNumber: '26',
      sammilaniYear: '1975',
      sammilaniPlace: 'Burla,Sambalpur'),
  SammilaniModel(
      sammilaniNumber: '27',
      sammilaniYear: '1976',
      sammilaniPlace: 'Jobra, Cuttack'),
  SammilaniModel(
      sammilaniNumber: '28',
      sammilaniYear: '1977',
      sammilaniPlace: 'Biratunga, Puri'),
  SammilaniModel(
      sammilaniNumber: '29',
      sammilaniYear: '1978',
      sammilaniPlace: 'Biratunga, Puri'),
  SammilaniModel(
      sammilaniNumber: '30',
      sammilaniYear: '1980',
      sammilaniPlace: 'Jagannath Pura, Talcher'),
  SammilaniModel(
      sammilaniNumber: '31',
      sammilaniYear: '1981',
      sammilaniPlace: 'Biratunga, Puri'),
  SammilaniModel(
      sammilaniNumber: '32',
      sammilaniYear: '1982',
      sammilaniPlace: 'Biratunga, Puri(Formality)'),
  SammilaniModel(
      sammilaniNumber: '33',
      sammilaniYear: '1983',
      sammilaniPlace: 'Biratunga, Puri(Formality)'),
  SammilaniModel(
      sammilaniNumber: '34',
      sammilaniYear: '1985',
      sammilaniPlace: 'Biratunga, Puri'),
  SammilaniModel(
      sammilaniNumber: '35',
      sammilaniYear: '1986',
      sammilaniPlace: 'Biratunga, Puri'),
  SammilaniModel(
      sammilaniNumber: '36',
      sammilaniYear: '1987',
      sammilaniPlace: 'Satsikshamandir, Bhubaneswar'),
  SammilaniModel(
      sammilaniNumber: '37',
      sammilaniYear: '1988',
      sammilaniPlace: 'Nimaparah, Puri'),
  SammilaniModel(
      sammilaniNumber: '38', sammilaniYear: '1989', sammilaniPlace: 'Balasore'),
  SammilaniModel(
      sammilaniNumber: '39',
      sammilaniYear: '1990',
      sammilaniPlace: 'Asureswar, Cuttack'),
  SammilaniModel(
      sammilaniNumber: '40',
      sammilaniYear: '1991',
      sammilaniPlace: 'Sambalpur'),
  SammilaniModel(
      sammilaniNumber: '41', sammilaniYear: '1992', sammilaniPlace: 'Oupada'),
  SammilaniModel(
      sammilaniNumber: '42',
      sammilaniYear: '1993',
      sammilaniPlace: 'Chatara, Jagatsinghpur'),
  SammilaniModel(
      sammilaniNumber: '43',
      sammilaniYear: '1994',
      sammilaniPlace: 'Shaktinagar, Rourkela'),
  SammilaniModel(
      sammilaniNumber: '44',
      sammilaniYear: '1995',
      sammilaniPlace: 'Chittola, Balasore'),
  SammilaniModel(
      sammilaniNumber: '45',
      sammilaniYear: '1996',
      sammilaniPlace: 'Matia, Pattamundai'),
  SammilaniModel(
      sammilaniNumber: '46',
      sammilaniYear: '1997',
      sammilaniPlace: 'Madhubana, Baripada'),
  SammilaniModel(
      sammilaniNumber: '47',
      sammilaniYear: '1998',
      sammilaniPlace: 'Satsikshamandir, Bhubaneswar'),
  SammilaniModel(
      sammilaniNumber: '48',
      sammilaniYear: '1999',
      sammilaniPlace: 'Berhampur, Ganjam'),
  SammilaniModel(
      sammilaniNumber: '49',
      sammilaniYear: '2000',
      sammilaniPlace: 'Jagannathpur, Talcher'),
  SammilaniModel(
      sammilaniNumber: '50',
      sammilaniYear: '2001',
      sammilaniPlace: 'Smrutimandir,Puri'),
  SammilaniModel(
      sammilaniNumber: '51',
      sammilaniYear: '2002',
      sammilaniPlace: 'Jaraka,Jajpur'),
  SammilaniModel(
      sammilaniNumber: '52',
      sammilaniYear: '2003',
      sammilaniPlace: 'Asureswar, Cuttack'),
  SammilaniModel(
      sammilaniNumber: '53',
      sammilaniYear: '2004',
      sammilaniPlace: 'Garsang,Bhadrak'),
  SammilaniModel(
      sammilaniNumber: '54',
      sammilaniYear: '2005',
      sammilaniPlace: 'Begunia,Khordha'),
  SammilaniModel(
      sammilaniNumber: '55',
      sammilaniYear: '2006',
      sammilaniPlace: 'Badamba,Cuttack'),
  SammilaniModel(
      sammilaniNumber: '56',
      sammilaniYear: '2007',
      sammilaniPlace: 'Kurunti,Kendrapara'),
  SammilaniModel(
      sammilaniNumber: '57',
      sammilaniYear: '2008',
      sammilaniPlace: 'Nimapara,Puri'),
  SammilaniModel(
      sammilaniNumber: '58',
      sammilaniYear: '2009',
      sammilaniPlace: 'Jeypore,Koraput'),
  SammilaniModel(
      sammilaniNumber: '59', sammilaniYear: '2010', sammilaniPlace: 'Anugul'),
  SammilaniModel(
      sammilaniNumber: '60',
      sammilaniYear: '2011',
      sammilaniPlace: 'New Delhi'),
  SammilaniModel(
      sammilaniNumber: '61',
      sammilaniYear: '2012',
      sammilaniPlace: 'Jharsuguda'),
  SammilaniModel(
      sammilaniNumber: '62',
      sammilaniYear: '2013',
      sammilaniPlace: 'Joda,Keonjhar'),
  SammilaniModel(
      sammilaniNumber: '63', sammilaniYear: '2014', sammilaniPlace: 'Bhadrak'),
  SammilaniModel(
      sammilaniNumber: '64',
      sammilaniYear: '2015',
      sammilaniPlace: 'Ekamra, Bhubaneswar'),
  SammilaniModel(
      sammilaniNumber: '65',
      sammilaniYear: '2016',
      sammilaniPlace: 'Paradeep, Jagatsinghpur'),
  SammilaniModel(
      sammilaniNumber: '66',
      sammilaniYear: '2017',
      sammilaniPlace: 'Mandapada,Kendrapara'),
  SammilaniModel(
      sammilaniNumber: '67',
      sammilaniYear: '2018',
      sammilaniPlace: 'Byasanagar,Jajpur'),
  SammilaniModel(
      sammilaniNumber: '68',
      sammilaniYear: '2019',
      sammilaniPlace: 'Dhenkanal Town, Dhenkanal'),
  SammilaniModel(
      sammilaniNumber: '69',
      sammilaniYear: '2020',
      sammilaniPlace: 'Damanjodi,Koraput'),
  SammilaniModel(
      sammilaniNumber: '70',
      sammilaniYear: '2021',
      sammilaniPlace: 'Satsikhya Mandir, Bhubaneswar'),
  SammilaniModel(
      sammilaniNumber: '71',
      sammilaniYear: '2022',
      sammilaniPlace: 'Satsikhya Mandir, Bhubaneswar'),
  SammilaniModel(
      sammilaniNumber: '72',
      sammilaniYear: '2023',
      sammilaniPlace: 'Jobra, Cuttack'),
  SammilaniModel(
    sammilaniNumber: '73',
    sammilaniYear: '2024',
    sammilaniPlace: 'Pune, Maharashtra',
  ),
  SammilaniModel(
    sammilaniNumber: '74',
    sammilaniYear: '2025',
    sammilaniPlace: 'Soro, Balasore',
  ),
];
