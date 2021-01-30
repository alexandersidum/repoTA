class UsulanStatus{

  // String id;
  // String roleStatus;
  String usulanStatus;
  

  static  List<String> listYear =  ['2018', '2019', '2020', '2021'];

  UsulanStatus({
    // this.id,
  //  this.roleStatus,
   this.usulanStatus});


  factory UsulanStatus.fromJson(Map<String, dynamic> json){
    return(
      UsulanStatus(
        // id: json['id'] as String,
        // roleStatus: json['role_status'] ,
        usulanStatus: json['usulan_status'] ,
      ));

  }

}
