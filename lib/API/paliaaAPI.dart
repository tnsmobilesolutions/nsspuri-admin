// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:sdp/Models/vaktaModel.dart';

enum SearchBy { name, company }

class PaliaAPI {
  SearchBy? searchBy;
  //Add Palia
  addUser(VaktaModel addvakta) async {
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('paliaList');
    await userCollection.doc(addvakta.docId).set(addvakta.toMap());
  }

//FetchUser
  Future<List<VaktaModel>> fetchAllByYearPalias(String year) async {
    try {
      return FirebaseFirestore.instance.collection('paliaList').get().then(
        (querysnapshot) {
          List<VaktaModel> lstPalias = [];
          for (var element in querysnapshot.docs) {
            final paliaData = element.data();
            final devoteModel = VaktaModel.fromMap(paliaData);

            if (devoteModel.paaliDate != null
                ? devoteModel.paaliDate!.contains(year)
                : false) {
              lstPalias.add(devoteModel);
            }
          }
          lstPalias.sort(
            (a, b) {
              int cmp =
                  a.paaliDate.toString().compareTo(b.paaliDate.toString());
              if (cmp != 0) return cmp;
              return (b.sangha ?? "").compareTo(a.sangha ?? "");
            },
          );
          return lstPalias;
        },
      );
      // return lstPalia;
    } catch (e) {
      null;
    }
    return [];
  }

// search user
  Future<List<VaktaModel>?> searchSDP(
      String? searchBy, String searchedItem, String? searchsanghaname) async {
    final CollectionReference paliaCollection =
        FirebaseFirestore.instance.collection('paliaList');
    return paliaCollection.get().then((querysnapshot) {
      List<VaktaModel> result = [];
      for (var element in querysnapshot.docs) {
        final palia = element.data() as Map<String, dynamic>;
        final vaktaDetails = VaktaModel.fromMap(palia);
        if (searchBy == 'Name') {
          if (vaktaDetails.name
                  ?.toLowerCase()
                  .contains(searchedItem.toLowerCase()) ??
              false) {
            result.add(vaktaDetails);
          }
        } else if (searchBy == 'Sangha') {
          if (vaktaDetails.sangha
                  ?.toLowerCase()
                  .contains(searchedItem.toLowerCase()) ??
              false) {
            result.add(vaktaDetails);
          }
        } else if (searchBy == 'Pali Date') {
          if (vaktaDetails.paaliDate?.contains(searchedItem) ?? false) {
            result.add(vaktaDetails);
          }
        } else if (searchBy == 'Sammilani Number') {
          if (vaktaDetails.sammilaniData?.sammilaniNumber
                  ?.contains(searchedItem) ??
              false) {
            if (searchsanghaname != null && searchsanghaname != '') {
              if ((vaktaDetails.sammilaniData?.sammilaniNumber
                          ?.contains(searchedItem) ??
                      false) &&
                  (vaktaDetails.sangha?.contains(searchsanghaname) ?? false)) {
                result.add(vaktaDetails);
              }
            } else {
              result.add(vaktaDetails);
            }
          }
        } else if (searchBy == 'Sammilani Year') {
          if (vaktaDetails.sammilaniData?.sammilaniYear
                  ?.contains(searchedItem) ??
              false) {
            if (searchsanghaname != null && searchsanghaname != '') {
              if ((vaktaDetails.sammilaniData?.sammilaniYear
                          ?.contains(searchedItem) ??
                      false) &&
                  (vaktaDetails.sangha?.contains(searchsanghaname) ?? false)) {
                result.add(vaktaDetails);
              }
            } else {
              result.add(vaktaDetails);
            }
            // result.add(vaktaDetails);
          }
        } else if (searchBy == 'Sammilani Place') {
          if (vaktaDetails.sammilaniData?.sammilaniPlace
                  ?.contains(searchedItem) ??
              false) {
            if (searchsanghaname != null && searchsanghaname != '') {
              if ((vaktaDetails.sammilaniData?.sammilaniPlace
                          ?.toLowerCase()
                          .contains(searchedItem) ??
                      false) &&
                  (vaktaDetails.sangha?.contains(searchsanghaname) ?? false)) {
                result.add(vaktaDetails);
              }
            } else {
              result.add(vaktaDetails);
            }
            // result.add(vaktaDetails);
          }
        } else if (searchBy == 'Receipt Date') {
          if (vaktaDetails.receiptDate?.contains(searchedItem) ?? false) {
            result.add(vaktaDetails);
          }
        } else if (searchBy == 'Receipt Number') {
          if (vaktaDetails.receiptNo?.contains(searchedItem) ?? false) {
            result.add(vaktaDetails);
          }
        }
      }
      return result;
    });
  }

  Future editPaliaDetails(VaktaModel paliaDetails) async {
    var paliaCollection = FirebaseFirestore.instance.collection('paliaList');

    paliaCollection.doc(paliaDetails.docId).update(paliaDetails.toMap());
  }

  removePalia(String? docId) {
    final CollectionReference paliaCollection =
        FirebaseFirestore.instance.collection('paliaList');
    paliaCollection.doc(docId).delete();
  }

  editPaliDateMultiple(List<String> docId, VaktaModel palidate) async {
    // docId.map((e) => );
    for (var element in docId) {
      FirebaseFirestore.instance
          .collection('paliaList')
          .doc(element)
          .update(palidate.toMap());
    }
  }
}
