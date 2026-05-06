# 03-mouse-event

마우스 입력 처리.

## 파일 역할

| 파일 | 역할 |
|:---|:---|
| `main.cpp` | C++ 진입점. QML 엔진 초기화, 리소스 로드, 이벤트 루프 실행 |
| `main.qml` | UI 선언. 마우스 이벤트 영역과 반응 요소 배치 |
| `CMakeLists.txt` | 빌드 설정. Qt 모듈 찾기, 실행 파일 생성, QML 모듈 등록 |

## 핵심

- `MouseArea`: 터치/마우스 이벤트 영역
- `hoverEnabled`: 마우스 이동 감지
- `onClicked`, `onPressed`, `onReleased`: 클릭, 누름, 뗌
- `onPositionChanged`: 커서 이동
- `mouse.x`, `mouse.y`: 좌표

## 빌드

```bash
cd 03-mouse-event
mkdir -p build && cd build
cmake ..
cmake --build .
./mouse-event
```
