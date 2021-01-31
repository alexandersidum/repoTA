class UsulanStatus{


  String usulanStatus;
  

  static  List<String> listYear =  ['2018', '2019', '2020', '2021'];

  UsulanStatus({

   this.usulanStatus});


  factory UsulanStatus.fromJson(Map<String, dynamic> json){
    return(
      UsulanStatus(

        usulanStatus: json['usulan_status'] ,
      ));

  }

}
