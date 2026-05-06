# 01-hello-qml

가장 작은 Qt Quick 앱.

## 파일 역할

| 파일 | 역할 |
|:---|:---|
| `main.cpp` | C++ 진입점. QML 엔진 초기화, 리소스 로드, 이벤트 루프 실행 |
| `main.qml` | UI 선언. 시각적 요소 배치, 속성 정의, 이벤트 핸들러 |
| `CMakeLists.txt` | 빌드 설정. Qt 모듈 찾기, 실행 파일 생성, QML 모듈 등록 |

## 핵심

- `QGuiApplication`: GUI 앱 진입점
- `QQmlApplicationEngine`: QML 파일 로드
- `Window`: 최상위 윈도우
- `anchors.centerIn`: 부모 중앙 정렬

## 빌드

```bash
cd 01-hello-qml
mkdir -p build && cd build
cmake ..
cmake --build .
./hello-qml
```
