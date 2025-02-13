CREATE TABLE PROGRESS_BAR_STATUS 
   (ID 			NUMBER, 
	NAME 		VARCHAR2(4000) NOT NULL);

ALTER TABLE PROGRESS_BAR_STATUS ADD CONSTRAINT PROGRESS_BAR_STATUS_PK PRIMARY KEY (ID);
ALTER TABLE PROGRESS_BAR_STATUS ADD CONSTRAINT PROGRESS_BAR_STATUS_UK PRIMARY KEY (NAME);

CREATE SEQUENCE SEQ_PROGRESS_BAR_STATUS
	START WITH     1
	INCREMENT BY   1
	NOCACHE
	NOCYCLE;
	
TRIGGER TRG_PROGRESS_BAR_STATUS_I_U
	BEFORE INSERT OR UPDATE
		ON PROGRESS_BAR_STATUS
	FOR EACH ROW
BEGIN  

    IF(inserting) THEN
		:NEW.id := SEQ_PROGRESS_BAR_STATUS.nextval;
    END IF;
	
    IF(updating) THEN
		IF :NEW.id <> :OLD.id THEN 
			raise_application_error(-20555, 'Can`t change id');
		END IF;
    END IF; 
	
END TRG_PROGRESS_BAR_STATUS_I_U;
/