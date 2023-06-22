String removeVNTones(String str) {
  str = str.replaceAll(RegExp(r'/à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ/g'), "a");
  str = str.replaceAll(RegExp(r'/è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ/g'), "e");
  str = str.replaceAll(RegExp(r'/ì|í|ị|ỉ|ĩ/g'), "i");
  str = str.replaceAll(RegExp(r'/ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ/g'), "o");
  str = str.replaceAll(RegExp(r'/ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ/g'), "u");
  str = str.replaceAll(RegExp(r'/ỳ|ý|ỵ|ỷ|ỹ/g'), "y");
  str = str.replaceAll(RegExp(r'/đ/g'), "d");
  str = str.replaceAll(RegExp(r'/À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ/g'), "A");
  str = str.replaceAll(RegExp(r'/È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ/g'), "E");
  str = str.replaceAll(RegExp(r'/Ì|Í|Ị|Ỉ|Ĩ/g'), "I");
  str = str.replaceAll(RegExp(r'/Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ/g'), "O");
  str = str.replaceAll(RegExp(r'/Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ/g'), "U");
  str = str.replaceAll(RegExp(r'/Ỳ|Ý|Ỵ|Ỷ|Ỹ/g'), "Y");
  str = str.replaceAll(RegExp(r'/Đ/g'), "D");
  // Some system encode vietnamese combining accent as individual utf-8 characters
  // Một vài bộ encode coi các dấu mũ, dấu chữ như một kí tự riêng biệt nên thêm hai dòng này
  str = str.replaceAll(RegExp(r'/\u0300|\u0301|\u0303|\u0309|\u0323/g'),
      ""); // ̀ ́ ̃ ̉ ̣  huyền, sắc, ngã, hỏi, nặng
  str = str.replaceAll(
      RegExp(r'/\u02C6|\u0306|\u031B/g'), ""); // ˆ ̆ ̛  Â, Ê, Ă, Ơ, Ư
  // Remove extra spaces
  // Bỏ các khoảng trắng liền nhau
  str = str.replaceAll(RegExp(r'/ + /g'), " ");
  str = str.trim();
  // Remove punctuations
  // Bỏ dấu câu, kí tự đặc biệt
  str = str.replaceAll(
      RegExp(
          r'''/!|@|%|\^|\*|\(|\)|\+|\=|\<|\>|\?|\/|,|\.|\:|\;|\'|\"|\&|\#|\[|\]|~|\$|_|`|-|{|}|\||\\/g'''),
      " ");
  return str;
}
