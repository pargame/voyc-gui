# 05-zoom-pan

휠 줌 + 드래그 팬.

## 파일 역할

| 파일 | 역할 |
|:---|:---|
| `main.cpp` | C++ 진입점. QML 엔진 초기화, 리소스 로드, 이벤트 루프 실행 |
| `main.qml` | UI 선언. 뷰포트 변환과 입력 이벤트 처리 |
| `CMakeLists.txt` | 빌드 설정. Qt 모듈 찾기, 실행 파일 생성, QML 모듈 등록 |

## 핵심

- `transform`: `Scale` + `Translate` 조합
- `onWheel`: 휠 이벤트, `angleDelta.y`로 방향
- `pressedButtons & Qt.LeftButton`: 좌클릭 드래그
- 좌표 변환: 팬량을 현재 스케일로 나눔

## 빌드

```bash
cd 05-zoom-pan
mkdir -p build && cd build
cmake ..
cmake --build .
./zoom-pan
```
