# CHANGELOG

## [Unreleased]

### Added
- 프로젝트 기본 구조 설정 (`src/`, `learn-qt/`, `.vscode/`)
- Qt Quick 기반 메인 윈도우 (`src/main.qml`)
- 창 크기 고정 1280x720, 16:9 비율
- 좌우 분할 레이아웃: workspace(70%) + inspector(30%)
- VS Code 통합 빌드 태스크 (7개: 본 프로젝트 + 학습 예제 5개 + 빌드만)
- 학습 예제 5개 (learn-qt/)
- GitHub 저장소 연동 (public)

### Changed
- `.gitignore`에서 `.vscode/` 제거 (세팅 공유)

### Fixed
- `tasks.json` `isDefault` 중복 제거, 선택 목록 정상 표시
