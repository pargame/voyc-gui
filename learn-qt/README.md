# Learn Qt - voyc-gui 학습용

Qt Quick / QML 기초 예제 모음.

## 폴터 구조

| 폴터 | 내용 |
|:---|:---|
| `01-hello-qml` | 최소한의 QML 윈도우 |
| `02-canvas-basic` | Canvas 2D 그리기 |
| `03-mouse-event` | 마우스 클릭, 이동, 누름/뗌 |
| `04-drag-object` | 오브젝트 드래그 |
| `05-zoom-pan` | 휠 줌 + 드래그 팬 |

## 빌드 및 실행

각 폴터에서:

```bash
cd 01-hello-qml
mkdir build && cd build
cmake ..
cmake --build .
./hello-qml
```

## 핵심 개념

### QML
- 선언적 UI 언어
- `Item`, `Rectangle`, `Text`, `Canvas` 등 시각적 요소
- `MouseArea`로 입력 처리
- `property`로 상태 관리, `id`로 참조

### CMake
- `find_package(Qt6 REQUIRED COMPONENTS Quick)`
- `qt_add_executable` + `qt_add_qml_module`
- `target_link_libraries`로 Qt 모듈 링크

### 좌표계
- 부모 기준 상대 좌표
- `anchors`로 자동 배치
- `transform`으로 스케일/이동/회전
