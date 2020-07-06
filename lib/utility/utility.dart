import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const SERVER_IP = 'https://mashia.herokuapp.com';
final storage = FlutterSecureStorage();
const pink= 0xffF205CB;//pink
const lpurple = 0xff7C05F2;//light purple
const mpurple = 0xff6204BF;//medium purple
const dpurple = 0xff050259;//dark purple
const red = 0xffF23827;//red 
const cblue = 0xff0336FF; //700
//AIzaSyCvOHofZaFlNMJhCoEM2dqwATbBaC3J_oU
Future<String> jwtOrEmpty() async {
    var jwt = await storage.read(key: "jwtToken");
    if(jwt == null) return "";
    return jwt;
}

void saveToken(String jwtToken) async{
  await storage.write(key: 'jwtToken', value: jwtToken);
}

void deleteToken() async{
  await storage.delete(key: 'jwtToken');
}

