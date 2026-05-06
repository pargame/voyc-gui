# voyc-gui 개발 진도

## 완료

| 항목 | 설명 | 날짜 |
|:---|:---|:---|
| 프로젝트 초기화 | GitHub 저장소 생성, Qt 설치 | 2026-05-04 |
| 윈도우 기본 설정 | 1280x720 고정, 16:9 비율 | 2026-05-04 |
| 레이아웃 분할 | canvas(70%) + inspector(30%) | 2026-05-04 |
| 빌드 시스템 | CMake + VS Code tasks 통합 | 2026-05-04 |
| 무한 격자 | 화면 이동 시 동적 렌더링, 최적화 | 2026-05-04 |
| 좌표계 통일 | 캔버스 중심 = (0,0) | 2026-05-04 |
| 마우스 스냅 | 가장 가까운 격자 교차점 표시 | 2026-05-04 |
| 확대축소 | 100%~200%, 10% 단위, 휠 스크롤 | 2026-05-04 |
| 줌 레벨 표시 | 캔버스 좌상단 퍼센트 텍스트, 페이드 인/아웃 | 2026-05-04 |
| 메뉴 바 | File, Edit, View, Settings, Help | 2026-05-04 |
| 메뉴 호버 효과 | 다크/화이트 모드 대응 | 2026-05-04 |
| 메뉴 팝업 | 클릭 시 세부 메뉴, 항목 호버/클릭, 자동 닫힘 | 2026-05-04 |
| 테마 토글 | Settings → Light/Dark Mode 전환 | 2026-05-04 |
| Config 분리 | 상수/색상/크기 중앙 관리 | 2026-05-04 |
| 테마 시스템 | 다크모드/화이트모드 토글 구조, 파스텔 톤 | 2026-05-04 |
| 코드 품질 개선 | 하드코딩 제거, Config 기반화 | 2026-05-04 |
| 통합 UI 시스템 | `UiButton` 컴포넌트, 재사용/캡슐화 | 2026-05-04 |
| 통합 이벤트 시스템 | `popupContainer` 중앙 관리, 생명주기 통제 | 2026-05-04 |

## 코드 구조

### Config.qml 분류 체계

| 분류 | 항목 | 설명 |
|:---|:---|:---|
| **창 크기** | `windowWidth`, `windowHeight` | 앱 전체 해상도 |
| **레이아웃** | `menuBarHeight`, `canvasRatio` | 영역 비율/크기 |
| **격자** | `gridSize` | 월드 좌표 기준 격자 간격 |
| **줌** | `zoomMin`, `zoomMax`, `zoomStep` | 확대축소 범위/단위 |
| **입력** | `wheelThreshold` | 휠 누적 임계값 |
| **스냅** | `snapRatio` | 인디케이터 크기 비율 |
| **여백** | `menuPadding`, `menuLeftMargin`, `textMargin` | UI 여백 |
| **폰트** | `menuFontSize`, `zoomFontSize` | 텍스트 크기 |
| **팝업** | `popupZ`, `popupMinWidth`, `popupCloseDelay`, `popupHoverCheckInterval`, `popupBorderWidth`, `popupItemLeftMargin` | 팝업 동작/크기 |
| **애니메이션** | `fadeDuration`, `fadeDelay` | 페이드 인/아웃 타이밍 |
| **테마** | `isDarkMode` | 다크/화이트 토글 |

### 색상 분류 (테마 함수)

| 요소 | 다크모드 | 화이트모드 | 적용 위치 |
|:---|:---|:---|:---|
| `menuBarBg()` | `#252526` | `#faf6f1` | 메뉴 바 배경 |
| `menuTextColor()` | `#cccccc` | `#4a4a4a` | 메뉴 텍스트 |
| `menuHoverBg()` | `#3c3c3c` | `#f0e6d8` | 메뉴 버튼 호버 |
| `canvasBg()` | `#2d2d2d` | `#fffdf9` | 캔버스 배경 |
| `gridColor()` | `#3a3a3a` | `#e8e0d5` | 격자 선 |
| `inspectorBg()` | `#1e1e1e` | `#f5efe8` | 인스펙터 배경 |
| `snapIndicatorColor()` | `#555` | `#c4b8a8` | 스냅 원 |
| `zoomTextColor()` | `#888` | `#a09080` | 줌 퍼센트 텍스트 |

### 아키텍처

| 파일 | 역할 | 의존 |
|:---|:---|:---|
| `Config.qml` | 상수/색상/테마 중앙 관리 | 없음 |
| `UiButton.qml` | 재사용 버튼 컴포넌트 | `Config` |
| `MenuButton.qml` | 메뉴 버튼 + 팝업 관리 | `Config`, `UiButton` |
| `main.qml` | 메인 윈도우, 캔버스, 인스펙터 | `Config`, `MenuButton` |

### 이벤트 흐름

```
[메뉴 버튼 클릭]
    → MenuButton.popupLoader.show()
        → popupContainer.activeButton = self
        → popupComponent.createObject(popupContainer)
            → 팝업 표시 (z: 1000, Window 레벨)

[팝업 항목 클릭]
    → popupMouseArea.onClicked
        → mouse.y / menuBarHeight → 항목 인덱스
        → onItemClicked(index)
        → popupLoader.hide()

[팝업 이탈]
    → popupMouseArea.onExited
        → closeTimer.start(300ms)
    → hoverCheckTimer (100ms 폴링, onEntered 시 시작)
        → containsMouse == false → closeTimer.start()

[다른 메뉴 버튼 호버]
    → MenuButton.mouseArea.onEntered
        → popupContainer.activeButton.hidePopup()
```

## 설계 결정 기록

| 결정 | 이유 |
|:---|:---|
| `UiButton` 분리 | 메뉴 버튼과 팝업 항목의 시각적 일관성, 캡슐화 |
| `popupContainer` (Window 레벨) | 팝업이 캔버스/인스펙터에 가려지지 않도록 z 순서 독립 |
| 동적 팝업 생성 (`createObject`) | 메뉴 버튼마다 팝업 생명주기 독립 관리 |
| `popupContainer.activeButton` | 현재 열린 팝업 추적, 다른 버튼 호버 시 닫기 |
| 이중 이탈 감지 (`onExited` + `Timer`) | `onExited` 불안정성 보완, 안정적 닫힘 |
| 통합 `MouseArea` (팝업 전체) | 항목별 `MouseArea` 중복 제거, 이벤트 충돌 방지 |

## 문제 해결 기록

| 문제 | 원인 | 해결 |
|:---|:---|:---|
| 팝업이 캔버스에 가려짐 | 팝업이 `menuBar` 자식, z 순서 무효 | `popupContainer`를 Window 레벨 `Item`으로 분리 |
| 팝업 항목 클릭 무효 | 항목 `MouseArea`와 팝업 `MouseArea` 겹침 | 통합 `MouseArea` 하나로 관리, `mouse.y`로 항목 계산 |
| `onExited` 불안정 | 동적 생성 `MouseArea`의 이벤트 유실 | `hoverCheckTimer` 폴링으로 이중 체크 |
| Settings 클릭 후 Help 이동 시 팝업 유지 | 다른 버튼 호버 시 닫기 로직 없음 | `mouseArea.onEntered`에서 `activeButton.hidePopup()` |
| 트랙패드 준 민감도 높음 | 한 제스처에 여러 `wheel` 이벤트 | `wheelAccumulator`로 60도 누적 시 한 단계씩 변경 |

## 참고 문서

| 문서 | 위치 | 내용 |
|:---|:---|:---|
| 코딩 규칙 | `.kimi/RULES.md` | 하드코딩 금지, 테마 시스템, 커밋 규칙 등 |
| 품질 검수 게이트 | `.kimi/QUALITY_GATE.md` | 검사 항목 체크리스트 |
| 학습 예제 | `learn-qt/` | Qt Quick 기초 예제 5개 |
