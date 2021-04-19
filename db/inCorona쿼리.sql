--CREATE USER INCORONA IDENTIFIED BY INCORONA;
--GRANT RESOURCE, CONNECT TO INCORONA;

--DROP TABLE HOSPITAL;
--DROP TABLE COMMENTS;
--DROP TABLE POST;
--DROP TABLE BOARD;
--DROP TABLE MEMBER;
--DROP TABLE LOCATION;

--지역
CREATE TABLE LOCATION(
       LOCATION_NUM VARCHAR2(30) PRIMARY KEY,
       LOCATION_NAME VARCHAR2(30),
       LOCATION_CATEGORY VARCHAR2(30),
       LOCATION_LATITUDE VARCHAR2(200),
       LOCATION_LONGITUDE VARCHAR2(200)
    );

COMMENT ON COLUMN LOCATION.LOCATION_NUM IS '지역번호';
COMMENT ON COLUMN LOCATION.LOCATION_NAME IS '지역이름';
COMMENT ON COLUMN LOCATION.LOCATION_CATEGORY IS '지역대분류';
COMMENT ON COLUMN LOCATION.LOCATION_LATITUDE IS '위도';
COMMENT ON COLUMN LOCATION.LOCATION_LONGITUDE IS '경도';



--회원
CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(30) PRIMARY KEY,
    MEMBER_PW VARCHAR2(30) NOT NULL,
    MEMBER_NICKNAME VARCHAR2(30) NOT NULL UNIQUE,
    MEMBER_EMAIL VARCHAR2(50),
    MEMBER_ENROLLDATE DATE DEFAULT SYSDATE,
    MEMBER_BIRTH DATE DEFAULT SYSDATE,
    MEMBER_LOCATIONNUM VARCHAR2(30) NOT NULL,
    MEMBER_ROLE VARCHAR2(20) DEFAULT 'USER',
    MEMBER_STATUS VARCHAR2(1) DEFAULT 'N' CHECK(MEMBER_STATUS IN('Y', 'N')),
    FOREIGN KEY(MEMBER_LOCATIONNUM) REFERENCES LOCATION(LOCATION_NUM)
);

CREATE SEQUENCE SEQ_MNO;

COMMENT ON TABLE MEMBER IS '회원';
COMMENT ON COLUMN MEMBER.MEMBER_ID IS '아이디';
COMMENT ON COLUMN MEMBER.MEMBER_PW IS '비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NICKNAME IS '닉네임';
COMMENT ON COLUMN MEMBER.MEMBER_EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.MEMBER_ENROLLDATE IS '등록일자';
COMMENT ON COLUMN MEMBER.MEMBER_BIRTH IS '생년월일';
COMMENT ON COLUMN MEMBER.MEMBER_LOCATIONNUM IS '지역번호';
COMMENT ON COLUMN MEMBER.MEMBER_ROLE IS '회원구분';
COMMENT ON COLUMN MEMBER.MEMBER_STATUS IS '탈퇴여부';



--게시판
CREATE TABLE BOARD(
    BOARD_ID VARCHAR2(30) PRIMARY KEY,
    BOARD_NAME VARCHAR2(30) NOT NULL
);

COMMENT ON TABLE BOARD IS '게시판';
COMMENT ON COLUMN BOARD.BOARD_ID IS '게시판ID';
COMMENT ON COLUMN BOARD.BOARD_NAME IS '게시판이름';


--게시글
CREATE TABLE POST(
    post_Num NUMBER PRIMARY KEY,
    post_Title VARCHAR2(50) NOT NULL,
    post_Contents VARCHAR2(1000) NOT NULL,
    post_Filename Varchar(300),
    post_FileRename Varchar(300),
    post_EnrollTime DATE DEFAULT SYSDATE,
    post_Views NUMBER DEFAULT 0,
    post_Remove VARCHAR2(1) DEFAULT 'N' CHECK(post_Remove IN('Y', 'N')),
    post_BoardNum VARCHAR2(30) NOT NULL,
    post_MemberId VARCHAR2(30) NOT NULL,
    post_LocationNum VARCHAR2(30) NOT NULL,
    FOREIGN KEY(post_BoardNum) REFERENCES Board(board_Id) ON DELETE CASCADE,
    FOREIGN KEY(post_MemberId) REFERENCES MEMBER(Member_Id) ON DELETE CASCADE,
    FOREIGN KEY(post_LocationNum) REFERENCES Location(location_Num) ON DELETE CASCADE
);

CREATE SEQUENCE SEQ_BOARD_NO;

COMMENT ON TABLE POST IS '게시글';
COMMENT ON COLUMN POST.post_Num IS '글등록번호';
COMMENT ON COLUMN POST.post_Title IS '제목';
COMMENT ON COLUMN POST.post_Contents IS '내용';
COMMENT ON COLUMN POST.post_Filename IS '첨부파일명';
COMMENT ON COLUMN POST.post_FileRename IS 're파일명';
COMMENT ON COLUMN POST.post_Enrolltime IS '등록시간';
COMMENT ON COLUMN POST.post_Views IS '조회수';
COMMENT ON COLUMN POST.post_Remove IS '삭제여부';
COMMENT ON COLUMN POST.post_BoardNum IS '게시판ID';
COMMENT ON COLUMN POST.post_MemberId IS '회원ID';
COMMENT ON COLUMN POST.post_LocationNum IS '지역번호';


--댓글
CREATE TABLE COMMENTS(
    COMMENT_NUM NUMBER PRIMARY KEY,
    COMMENT_CONTENTS VARCHAR2(500) NOT NULL,
    COMMENT_ENROLLTIME DATE DEFAULT SYSDATE,
    COMMENT_REMOVE VARCHAR2(1) DEFAULT 'N' CHECK(COMMENT_REMOVE IN('Y', 'N')),
    COMMENT_MEMBERID VARCHAR2(30) NOT NULL,
    COMMENT_ENROLLNUM NUMBER NOT NULL,
    FOREIGN KEY(COMMENT_MEMBERID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE,
    FOREIGN KEY(COMMENT_ENROLLNUM) REFERENCES POST(POST_NUM) ON DELETE CASCADE
);

COMMENT ON TABLE COMMENTS IS '댓글';
COMMENT ON COLUMN COMMENTS.COMMENT_NUM IS '댓글등록번호';
COMMENT ON COLUMN COMMENTS.COMMENT_CONTENTS IS '댓글내용';
COMMENT ON COLUMN COMMENTS.COMMENT_ENROLLTIME IS '댓글등록시간';
COMMENT ON COLUMN COMMENTS.COMMENT_REMOVE IS '댓글삭제여부';
COMMENT ON COLUMN COMMENTS.COMMENT_MEMBERID IS '회원ID';
COMMENT ON COLUMN COMMENTS.COMMENT_ENROLLNUM IS '글등록번호';

CREATE SEQUENCE SEQ_CNO;


--병원/진료소
create table Hospital(
    hospital_Num number primary key,
    hospital_Type varchar2(10) not null,
    hospital_Name varchar2(30) not null,
    hospital_location varchar2(30),  
    hospital_Tel varchar2(20),
    hospital_Latitude varchar2(100),
    hospital_Longitude varchar2(100),
    hospital_LocationNum varchar2(30),
    foreign key(hospital_LocationNum) references location(location_Num) on delete cascade
    );
    

comment on column hospital.hospital_num is '병원번호';
comment on column hospital.hospital_type is '구분';
comment on column hospital.hospital_name is '병원명';
comment on column hospital.hospital_location is '주소';
comment on column hospital.hospital_tel is '전화번호';
comment on column hospital.hospital_latitude is '위도';
comment on column hospital.hospital_longitude is '경도';
comment on column hospital.hospital_locationNum is '지역번호';
