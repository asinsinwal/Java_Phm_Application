drop sequence phmseq;
drop sequence obvseq;
drop sequence recseq;

CREATE SEQUENCE phmseq MINVALUE 5 MAXVALUE 999999999999999999999999999 START WITH 5 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE obvseq MINVALUE 12 MAXVALUE 999999999999999999999999999 START WITH 12 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE recseq MINVALUE 11 MAXVALUE 999999999999999999999999999 START WITH 11 INCREMENT BY 1 CACHE 10;