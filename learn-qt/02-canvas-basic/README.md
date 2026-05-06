# 02-canvas-basic

Canvas 2D API로 도형 그리기.

## 파일 역할

| 파일 | 역할 |
|:---|:---|
| `main.cpp` | C++ 진입점. QML 엔진 초기화, 리소스 로드, 이벤트 루프 실행 |
| `main.qml` | UI 선언. Canvas 요소 배치, 그리기 로직 |
| `CMakeLists.txt` | 빌드 설정. Qt 모듈 찾기, 실행 파일 생성, QML 모듈 등록 |

## 핵심

- `Canvas`: 2D 그리기 표면
- `getContext("2d")`: 2D 렌더링 컨텍스트
- `fillRect`, `arc`, `stroke`: 사각형, 원, 선
- `onPaint`: 다시 그릴 때 호출

## 빌드

```bash
cd 02-canvas-basic
mkdir -p build && cd build
cmake ..
cmake --build .
./canvas-basic
```
