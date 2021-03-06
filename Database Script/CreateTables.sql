drop table SICK_PERSON;
drop table WELL_PERSON;
drop table RECORD_DISEASE;
drop table STANDARD_RECOMMENDATION;
drop table SPECIFIC_RECOMMENDATION;
drop table ALERT;
drop table PERSON;
drop table DISEASE;
drop table OBSERVATION;
drop table RECOMMENDATION;
purge recyclebin;

CREATE
  TABLE PERSON
  (
    P_ID     VARCHAR2(5) PRIMARY KEY,
    PNAME    VARCHAR2(100),
    USERNAME VARCHAR2(20) UNIQUE,
    PASSWORD VARCHAR2(20),
    ADDRESS  VARCHAR2(250),
    DOB      DATE,
    GENDER   CHAR(1) CHECK(GENDER IN ('M','F')),
    CONTACT  VARCHAR2(50)
  );

CREATE
  TABLE SICK_PERSON
  (
    P_ID   VARCHAR2(5) PRIMARY KEY,
    HS1_ID VARCHAR2(5),
    HS2_ID VARCHAR2(5),
    HS1_AUTH_DATE DATE,
    HS2_AUTH_DATE DATE
  );

CREATE
  TABLE WELL_PERSON
  (
    P_ID   VARCHAR2(5) PRIMARY KEY,
    HS1_ID VARCHAR2(5),
    HS2_ID VARCHAR2(5),
    HS1_AUTH_DATE DATE,
    HS2_AUTH_DATE DATE
  );

CREATE
  TABLE DISEASE
  (
    D_ID  NUMBER PRIMARY KEY,
    DNAME VARCHAR2(50)
  );

CREATE
  TABLE RECORD_DISEASE
  (
    P_ID        VARCHAR2(5),
    D_ID        NUMBER,
    RECORD_TIME TIMESTAMP,
    PRIMARY KEY(P_ID, D_ID)
  );

CREATE
  TABLE RECOMMENDATION
  (
    R_ID        NUMBER PRIMARY KEY,
    FREQUENCY   VARCHAR2(20),
    DESCRIPTION VARCHAR2(1024),
    METRIC      VARCHAR2(20),
    LOWER_BOUND VARCHAR2(20),
    UPPER_BOUND VARCHAR2(20),
    STRING_VALUE VARCHAR2(20)
  );

CREATE
  TABLE STANDARD_RECOMMENDATION
  (
    D_ID      NUMBER,
    R_ID      NUMBER,
    PRIMARY KEY(D_ID, R_ID)
  );

CREATE
  TABLE SPECIFIC_RECOMMENDATION
  (
    P_ID      VARCHAR2(5),
    R_ID      NUMBER,
    PRIMARY KEY(P_ID, R_ID)
  );

CREATE
  TABLE ALERT
  (
    A_ID        NUMBER PRIMARY KEY,
    P_ID        VARCHAR2(5),
    R_ID      NUMBER,
    DESCRIPTION VARCHAR2(1024),
    IS_MANDATORY CHAR(1) CHECK(IS_MANDATORY IN ('T','F')),
    IS_VIEWED CHAR(1) CHECK(IS_VIEWED IN ('T','F'))
  );

CREATE
  TABLE OBSERVATION
  (
    OB_ID    NUMBER PRIMARY KEY,
    P_ID	VARCHAR2(5),
    R_ID NUMBER,
    OB_VALUE VARCHAR2(20),
    RECORD_TIME TIMESTAMP,
    OB_TIME     TIMESTAMP
  );
  
ALTER TABLE SICK_PERSON ADD FOREIGN KEY (P_ID) REFERENCES PERSON(P_ID);
ALTER TABLE SICK_PERSON ADD FOREIGN KEY (HS1_ID) REFERENCES PERSON(P_ID);
ALTER TABLE SICK_PERSON ADD FOREIGN KEY (HS2_ID) REFERENCES PERSON(P_ID);
ALTER TABLE WELL_PERSON ADD FOREIGN KEY (P_ID) REFERENCES PERSON(P_ID);
ALTER TABLE WELL_PERSON ADD FOREIGN KEY (HS1_ID) REFERENCES PERSON(P_ID);
ALTER TABLE WELL_PERSON ADD FOREIGN KEY (HS2_ID) REFERENCES PERSON(P_ID);
ALTER TABLE RECORD_DISEASE ADD FOREIGN KEY (P_ID) REFERENCES PERSON(P_ID);
ALTER TABLE RECORD_DISEASE ADD FOREIGN KEY (D_ID) REFERENCES DISEASE(D_ID);
ALTER TABLE STANDARD_RECOMMENDATION ADD FOREIGN KEY (D_ID) REFERENCES DISEASE(D_ID);
ALTER TABLE STANDARD_RECOMMENDATION ADD FOREIGN KEY (R_ID) REFERENCES RECOMMENDATION(R_ID);
ALTER TABLE SPECIFIC_RECOMMENDATION ADD FOREIGN KEY (P_ID) REFERENCES PERSON(P_ID);
ALTER TABLE SPECIFIC_RECOMMENDATION ADD FOREIGN KEY (R_ID) REFERENCES RECOMMENDATION(R_ID);
ALTER TABLE ALERT ADD FOREIGN KEY (P_ID) REFERENCES PERSON(P_ID);
ALTER TABLE observation ADD CONSTRAINT chk_recordTime CHECK (OB_TIME <= RECORD_TIME);
ALTER TABLE recommendation ADD CONSTRAINT chk_bounds CHECK (NVL(TO_NUMBER(LOWER_BOUND),0) < NVL(TO_NUMBER(UPPER_BOUND),1));

COMMIT;
