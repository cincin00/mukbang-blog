# Mukbang Blog (맛집 탐방 블로그)

대학생 팀 프로젝트로 제작된 **JSP 기반 맛집/자유게시판 웹사이트**입니다.  
프레임셋(Frameset) 레이아웃, Flash 메뉴, JSP 스크립틀릿, JDBC를 사용하는 고전적인 Java 웹 애플리케이션 구조를 갖고 있습니다.

## 1) 프로젝트 개요

- 메인 진입 화면은 `home.jsp`이며, 상단 메뉴(`index.html` + `menu.swf`)와 본문/사이드 로그인 영역으로 구성됩니다.
- 회원가입/로그인 기능과 게시판(목록, 작성, 상세 조회)이 구현되어 있습니다.
- 이미지 업로드를 포함한 게시글 등록 기능이 존재합니다.
- 코드상에서 ODBC 방식과 MySQL 방식이 혼재되어 있어, 환경에 따라 일부 기능은 추가 수정이 필요합니다.

## 2) 기술 스택 / 실행 환경

- **Backend/View**: JSP (스크립틀릿 기반)
- **Language**: Java
- **Database 접근**: JDBC (`com.mysql.jdbc.Driver`, 일부 페이지는 `sun.jdbc.odbc.JdbcOdbcDriver`)
- **File Upload**: `com.oreilly.servlet.MultipartRequest` (cos 라이브러리)
- **Frontend**:
  - HTML + Frameset
  - JavaScript 폼 검증
  - SWFObject + Flash 메뉴 (`menu.swf`, `data.xml`)
- **권장 서버**: Apache Tomcat (JSP 구동)

## 3) 화면/기능 구조

### 메인 레이아웃

- `home.jsp`
  - `frameset rows="150,*"`
  - 상단: `index.html` (Flash 메뉴)
  - 본문: `home1.jpg`
  - 우측: `login.jsp`, 링크/배너 영역(`add.jpg`)

### 회원 기능

- `login.jsp`: 로그인 폼
- `login_ok.jsp`: DB 조회를 통한 로그인 검증
- `Join.jsp`: 회원가입 입력 폼 + 클라이언트 검증(JavaScript)
- `join_input.jsp`: 회원가입 데이터 DB INSERT

### 게시판 기능

- `listboard.jsp`: 게시물 목록, 페이징, 검색
- `write.jsp`: 게시글 작성 폼
- `write_input.jsp`: 멀티파트 업로드 + 게시글 DB INSERT
- `write_output.jsp`: 게시글 상세 조회 + 댓글(플러스) 조회/입력 폼

## 4) 디렉터리(루트) 주요 파일 설명

- `home.jsp`: 실제 서비스 메인 프레임 페이지
- `index.html`, `swfobject.js`, `menu.swf`, `data.xml`: 상단 Flash 메뉴
- `login.jsp`, `login_ok.jsp`, `Join.jsp`, `join_input.jsp`: 회원 처리
- `listboard.jsp`, `write.jsp`, `write_input.jsp`, `write_output.jsp`: 게시판 처리
- `*.jpg`: 배경/아이콘 등 정적 이미지 에셋
- `index.jsp`: Tomcat 기본 페이지 템플릿(서비스 메인으로는 `home.jsp` 사용 권장)

## 5) 데이터베이스 연동 포인트

코드 내에서 확인되는 기본 접속 정보(하드코딩):

- URL: `jdbc:mysql://localhost:3306/jsp`
- ID: `root`
- PW: `1234`

사용 테이블(코드 기준):

- `joindb` (회원)
  - 사용 컬럼: `id`, `pass`, `name`, `ssn`, `job`, `sex`, `info`
- `listboarddb` (게시글 목록)
  - 사용 컬럼: `num`, `name`, `pass`, `email`, `title`, `contents`, `writedate`, `readcount`, `filename`
- `tblboard`, `tblplus` (상세/댓글 쪽에서 참조)
  - 현재 게시글 등록 로직의 테이블(`listboarddb`)과 상세조회 로직(`tblboard`)이 불일치하므로 정비 필요

## 6) 로컬 실행 방법(복원/테스트 가이드)

1. **Tomcat 준비**
   - 로컬 Tomcat 설치 후, 본 프로젝트를 웹앱 디렉터리로 배치합니다.
2. **라이브러리 준비**
   - MySQL JDBC 드라이버(`mysql-connector-java`)를 서버 클래스패스에 추가
   - 파일 업로드용 cos 라이브러리(`com.oreilly.servlet`) 추가
3. **DB 준비**
   - `jsp` 데이터베이스 생성
   - 위 테이블(`joindb`, `listboarddb` 등) 스키마를 코드 컬럼에 맞춰 생성
4. **이미지 업로드 폴더 확인**
   - `write_input.jsp`는 `image` 경로(실경로)로 업로드를 저장하므로 해당 폴더 권한/경로 점검
5. **접속**
   - 브라우저에서 `http://localhost:8080/<context>/home.jsp` 접속

## 7) 현재 코드 상태에서의 주의사항

- **인코딩 혼재**: `UTF-8`, `euc-kr`가 파일별로 섞여 있어 한글 깨짐 가능성이 큽니다.
- **DB 방식 혼재**: ODBC 코드와 MySQL 코드가 혼용되어 있어 일관성 있는 정리가 필요합니다.
- **테이블 참조 불일치**:
  - 작성: `listboarddb`
  - 상세: `tblboard`
- **보안 이슈**:
  - SQL 문자열 결합
  - DB 계정/비밀번호 하드코딩
- **레거시 UI 구조**:
  - Frameset/Flash 의존 요소가 있어 최신 브라우저 환경에서 제약이 있을 수 있습니다.
