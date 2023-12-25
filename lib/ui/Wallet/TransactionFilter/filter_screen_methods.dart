//Final Filters

List<String> finalActivityIdList = [];
List<String> finalPartnerIdList = [];
List<String> finalLeadIdList = [];
List<String> entityIdsList = [];
String finalTransactionType;

DateTime finalFromDate;
DateTime finalToDate;

bool allTrue(List<bool> boolList) {
  bool alltrue = true;
  for (int i = 0; i < boolList.length; i++) {
    if (boolList[i] == false) {
      alltrue = false;
    }
  }
  return alltrue;
}

clearAllFinalFilters() {
  finalActivityIdList = [];
  finalPartnerIdList = [];
  finalLeadIdList = [];
  finalTransactionType = null;

  finalFromDate = null;
  finalToDate = null;
}

bool filterAddedStatus() {
  if (finalActivityIdList.length == 0 &&
      finalPartnerIdList.length == 0 &&
      finalLeadIdList.length == 0 &&
      finalTransactionType == null &&
      finalFromDate == null &&
      finalToDate == null) {
    return false;
  } else {
    return true;
  }
}
