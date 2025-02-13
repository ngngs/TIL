신규 입사자 들을 위한 가이드 라인 작성

| 단계 | 명령어 | 설명 |
|------|--------|------|
| **개발 작업** |  |  |
| 1 | `git checkout main` | 메인 브랜치로 이동 |
| 2 | `git pull origin main` | 로컬 main을 원격 main과 동기화 |
| 3 | `git checkout -b NewBranchName` | 새 기능 브랜치 생성 및 이동 |
| 4 | 개발 작업 | 코드 수정 및 기능 구현 |
| 5 | `git add -u` | 변경된 파일 스테이징 |
| 6 | `git commit -m "[Fix] 문규성 - 오타 수정"` | 커밋 메시지와 함께 변경 사항 저장 |
| **배포 작업** |  |  |
| 1 | `git checkout dev` | 배포 대상 브랜치(dev)로 이동 |
| 2 | `git pull origin dev` | 로컬 dev와 원격 dev 동기화 |
| 3 | `git merge NewBranchName` | 새 브랜치를 dev에 병합 |
| 4 | `git push origin dev` | 병합된 dev 브랜치를 원격 저장소로 푸시 |
