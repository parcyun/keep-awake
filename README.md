# keep_awake_parcyunstudio

## 프로그램 소개

이 프로그램은 Windows의 화면 절전 설정을 변경하지 않고, 화면이 계속 켜져 있어야 한다는 신호를 운영체제에 전달합니다.

마우스 커서를 움직이거나 키보드 입력을 발생시키지 않으므로 문서 작성, 수업 자료 작업, 인터넷 사용에 방해가 되지 않습니다.

## 설치 및 실행

1. ZIP 파일의 압축을 풉니다.
2. 압축을 푼 폴더 안의 `keep_awake_parcyunstudio.cmd`를 더블클릭합니다.
3. 검은색 창에 설치 완료 메시지가 표시되면 Enter 키를 눌러 창을 닫습니다.

한 번 실행하면 다음 작업이 자동으로 진행됩니다.

- 프로그램 파일을 `%LOCALAPPDATA%\keep_awake_parcyunstudio`에 복사합니다.
- Windows 시작 프로그램에 `keep_awake_parcyunstudio.lnk`를 등록합니다.
- 현재 즉시 프로그램을 실행합니다.

다음 로그인부터는 별도의 조작 없이 자동으로 실행됩니다.

## 작동 방식

프로그램은 약 1분마다 Windows에 화면 유지 신호를 보냅니다. 실제 마우스·키보드 입력은 만들지 않습니다.

따라서 다음 항목은 변경하지 않습니다.

- Windows 전원 및 화면 절전 설정
- 마우스 커서 위치
- 키보드 입력 및 활성 창
- 파일, 문서, 인터넷 연결

## 중지 방법

일시적으로 중지하려면 작업 관리자를 열고 `keep_awake.ps1`을 실행 중인 PowerShell 프로세스를 종료합니다.

다시 로그인할 때 자동 실행되지 않게 하려면 다음 시작 프로그램 폴더에서 아래 바로가기를 삭제합니다.

`%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\keep_awake_parcyunstudio.lnk`

## 완전히 삭제하기

1. 작업 관리자에서 `keep_awake.ps1` 프로세스를 종료합니다.
2. 시작 프로그램 폴더의 `keep_awake_parcyunstudio.lnk`를 삭제합니다.
3. 다음 폴더를 삭제합니다.

`%LOCALAPPDATA%\keep_awake_parcyunstudio`

## 주의 사항

이 프로그램은 화면 표시를 유지하는 용도입니다. 사용자가 직접 전원 버튼을 누르거나 노트북 덮개를 닫는 동작까지 막지는 않습니다.
