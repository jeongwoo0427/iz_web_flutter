import 'package:flutter/material.dart';

class ValidatorConstants{
  static const int idMaxLength = 20;
  static const int idMinLength = 8;

  static const int passwordMaxLength = 20;
  static const int passwordMinLength = 8;

  static const int emailMaxLength = 50;
  static const int emailMinLength = 5;

  static const int nicknameMaxLegnth = 12;
  static const int nicknameMinLenght = 2;
}

mixin ValidatorMixin {

  final validationKey = GlobalKey<FormState>();

  bool checkValidate(){
    return validationKey.currentState!.validate();
  }

  String? idValidation(final value){
    if(value.toString().trim()== '')return '아이디를 입력하세요';
    ///TODO: 공백및 특수문자 여부 확인하기
    if(value.toString().length > ValidatorConstants.idMaxLength)return '아이디는 최대 ${ValidatorConstants.idMaxLength} 글자입니다.';
    if(value.toString().length < ValidatorConstants.idMinLength)return '아이디는 최소 ${ValidatorConstants.idMinLength} 글자입니다.';
    return null;
  }

  String? passwordValidation(final value){
    if(value.toString().trim()== '')return '패스워드를 입력하세요';
    ///TODO: 공백및 특수문자 여부 확인하기
    if(value.toString().length > ValidatorConstants.passwordMaxLength)return '패스워드는 최대 ${ValidatorConstants.passwordMaxLength} 글자입니다.';
    if(value.toString().length < ValidatorConstants.passwordMinLength)return '패스워드는 최소 ${ValidatorConstants.passwordMinLength} 글자입니다.';
    return null;
  }

  String? emailValidation(final value){
    if(value.toString().trim() =='') return '이메일을 입력하세요.';
    //if(!isEmail(value.toString().trim())) return '이메일 형식에 맞지 않습니다.';
    ///TODO: 공백및 특수문자 여부 확인하기
    if(value.toString().length > ValidatorConstants.emailMaxLength)return '이메일은 최대 ${ValidatorConstants.emailMaxLength} 글자입니다.';
    if(value.toString().length < ValidatorConstants.emailMinLength)return '이메일은 최소 ${ValidatorConstants.emailMinLength} 글자입니다.';

    return null;
  }

  String? nicknameValidation(final value){
    if(value.toString().trim()== '')return '닉네임을 입력하세요';
    ///TODO: 공백및 특수문자 여부 확인하기
    if(value.toString().length > ValidatorConstants.nicknameMaxLegnth)return '닉네임은 최대 ${ValidatorConstants.nicknameMaxLegnth} 글자입니다.';
    if(value.toString().length < ValidatorConstants.nicknameMinLenght)return '닉네임은 최소 ${ValidatorConstants.nicknameMaxLegnth} 글자입니다.';
    return null;
  }

}