import 'package:easy_blood/model/user.dart';

class Qualification {
  final String id;
  final DateTime lastDonation;
  final String desease;
  final String problem;
  final String beautyInjection;
  final String familyHavingHepatitis;
  final bool dengue;
  final bool receiveVaccine;
  final bool misscariage;
  final bool pierceCuppingAcupuntureTattoo;
  final bool takeAntiobiotic;
  final bool surgical;
  final bool injury;
  final bool transfussion;
  final bool CJD1;
  final bool CJD2;
  final bool CJD3;
  final bool sexWithMan;
  final bool sexWithProstitute;
  final bool paidOrPaySex;
  final bool sexPartnerNumber;
  final bool sexPArnerLast12Month;
  final bool injectDrug;
  final bool partnerCatagories;
  final bool partnerHIVpositive;
  final bool youOrSexPartnerHIVinfected;
  final bool feelingWell;
  final bool testBlood;
  final bool dentalTreatment;
  final bool takenAlcohol;
  final bool menstruating;
  final bool pregnant;
  final bool breastfeed;
  final String user_id;
//  final User user;

  Qualification(
    this.user_id, this.id,  this.lastDonation, this.desease, this.problem, this.beautyInjection, this.familyHavingHepatitis, this.dengue, this.receiveVaccine, this.misscariage, this.pierceCuppingAcupuntureTattoo, this.takeAntiobiotic, this.surgical, this.injury, this.transfussion, this.CJD1, this.CJD2, this.CJD3, this.sexWithMan, this.sexWithProstitute, this.paidOrPaySex, this.sexPartnerNumber, this.sexPArnerLast12Month, this.injectDrug, this.partnerCatagories, this.partnerHIVpositive, this.youOrSexPartnerHIVinfected, this.feelingWell, this.testBlood, this.dentalTreatment, this.takenAlcohol, this.menstruating, this.pregnant, this.breastfeed,
      );

  Qualification.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        lastDonation =DateTime.parse(json['lastDonation']),
        desease = json['desease'],
        problem = json['problem'],
        beautyInjection = json['beautyInjection'],
        familyHavingHepatitis = json['familyHavingHepatitis'],
        dengue = json['dengue'],
        receiveVaccine=json['receiveVaccine'],
        misscariage = json['misscariage'],
        pierceCuppingAcupuntureTattoo = json['pierceCuppingAcupuntureTattoo'],
        takeAntiobiotic = json['takeAntiobiotic'],
        surgical = json['surgical'],
        injury = json['injury'],
        transfussion = json['transfussion'],
        CJD1 = json['CJD1'],
        CJD2 = json['CJD2'],
        CJD3 = json['CJD3'],
        sexWithMan = json['sexWithMan'],
        sexWithProstitute=json['sexWithProstitute'],
        paidOrPaySex = json['paidOrPaySex'],
        sexPartnerNumber = json['sexPartnerNumber'],
        sexPArnerLast12Month = json['sexPArnerLast12Month'],
        injectDrug = json['injectDrug'],
        partnerCatagories = json['partnerCatagories'],
        partnerHIVpositive = json['partnerHIVpositive'],
        youOrSexPartnerHIVinfected = json['youOrSexPartnerHIVinfected'],
        feelingWell = json['feelingWell'],
        testBlood = json['testBlood'],
        dentalTreatment = json['dentalTreatment'],
        takenAlcohol= json['takenAlcohol'],
        menstruating =json['menstruating'],
        pregnant = json['pregnant'],
        breastfeed = json['breastfeed'],
        user_id = json['user_id'];
//        user = User.fromJson(json['user']);

  Map<String, dynamic> toJson() =>
      {
        "_id": id,
  "lastDonation": lastDonation,
  "desease": desease,
  "problem": problem,
  "beautyInjection": beautyInjection,
  "familyHavingHepatitis": familyHavingHepatitis,
  "dengue": dengue,
  "receiveVaccine": receiveVaccine,
  "misscariage": misscariage,
  "pierceCuppingAcupuntureTattoo": pierceCuppingAcupuntureTattoo,
  "takeAntiobiotic": takeAntiobiotic,
  "surgical": surgical,
  "injury": injury,
  "transfussion": transfussion,
  "CJD1":  CJD1,
  "CJD2": CJD2,
  "CJD3": CJD3,
  "sexWithMan": sexWithMan,
  "sexWithProstitute": sexWithProstitute,
  "paidOrPaySex": paidOrPaySex,
  "sexPartnerNumber": sexPartnerNumber,
  "sexPArnerLast12Month": sexPArnerLast12Month,
  "injectDrug": injectDrug,
  "partnerCatagories": partnerCatagories,
  "partnerHIVpositive": partnerHIVpositive,
  "youOrSexPartnerHIVinfected": youOrSexPartnerHIVinfected,
  "feelingWell": feelingWell,
  "testBlood": testBlood,
  "dentalTreatment": dentalTreatment,
  "takenAlcohol": takenAlcohol,
  "menstruating": menstruating,
  "pregnant": pregnant,
  "breastfeed": breastfeed,
  "user_id": user_id
      };
}
