CREATE OR REPLACE FUNCTION ex13_profit RETURN NUMBER IS
    result NUMBER := 0;
BEGIN
    FOR i IN (SELECT DISTINCT stud_id FROM course_selection)
    LOOP
        result:=result + retake(i.stud_id);
    END LOOP;
    RETURN result;
END;
/
SET SERVEROUTPUT ON;
BEGIN 
DBMS_OUTPUT.PUT_LINE(ex13_profit());
END;