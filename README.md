# iz_web_flutter

#IDE

Flutter v3.10.6
AndroidStudio


#Test Info
웹호스팅모드로 디버그테스트를 진행 할 경우 실행할 프롬프트
fvm flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8989

#Publish Info
릴리즈버전 빌드시 사용 명령어 : fvm flutter build web --web-renderer canvaskit --release
빌드 후 할것 :
1. 빌드된 web 폴더에서 index.html 열기
2. flutter.js 를 flutter.js?version=현재날짜시간 으로 수정
3. 빌드된 web 폴더에서 flutter.js 열기
4. entrypointUrl = "main.dart.js" 에서 main.dart.js?version=현재날짜시간 으로 수정
 
