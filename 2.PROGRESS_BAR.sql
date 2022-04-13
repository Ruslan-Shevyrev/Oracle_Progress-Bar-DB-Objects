CREATE TABLE PROGRESS_BAR
(ID 			NUMBER, 
 STATUS_ID 		NUMBER, 
 CUSTOM_NAME 	VARCHAR2(4000), 
 IDENT 			NUMBER);

ALTER TABLE PROGRESS_BAR ADD CONSTRAINT PROGRESS_BAR PRIMARY KEY (ID);
ALTER TABLE PROGRESS_BAR ADD CONSTRAINT FOREIGN KEY (STATUS_ID) REFERENCES PROGRESS_BAR_STATUS(ID);

CREATE SEQUENCE SEQ_PROGRESS_BAR
	START WITH     1
	INCREMENT BY   1
	NOCACHE
	NOCYCLE;
	
CREATE TRIGGER TRG_PROGRESS_BAR_I_U
	BEFORE INSERT OR UPDATE
		ON PROGRESS_BAR
	FOR EACH ROW
BEGIN  
    IF(inserting) THEN
		:NEW.id := SEQ_PROGRESS_BAR.nextval;
    END IF;
    IF(updating) THEN
		IF :NEW.id <> :OLD.id THEN 
			raise_application_error(-20555, 'Can`t change id');
		END IF;
    END IF; 
END TRG_PROGRESS_BAR_I_U;
/

CREATE SEQUENCE SEQ_PROGRESS_BAR_IDENT
	START WITH     1
	INCREMENT BY   1
	NOCACHE
	NOCYCLE;