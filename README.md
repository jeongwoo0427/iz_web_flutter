# iz_web_flutter

#IDE

Flutter v3.7.0
AndroidStudio

#Publish Info
릴리즈버전 빌드시 사용 명령어 : flutter build web --web-renderer canvaskit --release
빌드 후 할것 :
1. 빌드된 web 폴더에서 index.html 열기
2. flutter.js 를 flutter.js?version=현재날짜시간 으로 수정
3. 빌드된 web 폴더에서 flutter.js 열기
4. entrypointUrl = "main.dart.js" 에서 main.dart.js?version=현재날짜시간 으로 수정
 
