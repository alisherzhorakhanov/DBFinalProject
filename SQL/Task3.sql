SET SERVEROUTPUT ON;
CREATE OR REPLACE FUNCTION total_GPA(parametr_student_id VARCHAR2) RETURN NUMBER IS 
    credits_sum NUMBER := 0;
    markMultiplyCredit_sum NUMBER := 0;
    CURSOR cur IS SELECT QIYMET_HERF FROM course_selection WHERE stud_id = parametr_student_id;
BEGIN
    FOR i IN cur LOOP
        credits_sum := credits_sum + 3;
        IF i.QIYMET_HERF = 'A' THEN markMultiplyCredit_sum := markMultiplyCredit_sum + 4*3; END IF;
        IF i.QIYMET_HERF = 'A-' THEN markMultiplyCredit_sum := markMultiplyCredit_sum + 3.67*3; END IF;
        IF i.QIYMET_HERF = 'B+' THEN markMultiplyCredit_sum := markMultiplyCredit_sum + 3.33*3; END IF;
        IF i.QIYMET_HERF = 'B' THEN markMultiplyCredit_sum := markMultiplyCredit_sum + 3*3; END IF;
        IF i.QIYMET_HERF = 'B-' THEN markMultiplyCredit_sum := markMultiplyCredit_sum + 2.67*3; END IF;
        IF i.QIYMET_HERF = 'C+' THEN markMultiplyCredit_sum := markMultiplyCredit_sum + 2.33*3; END IF;
        IF i.QIYMET_HERF = 'C' THEN markMultiplyCredit_sum := markMultiplyCredit_sum + 2*3; END IF;
        IF i.QIYMET_HERF = 'C-' THEN markMultiplyCredit_sum := markMultiplyCredit_sum + 1.67*3; END IF;
        IF i.QIYMET_HERF = 'D+' THEN markMultiplyCredit_sum := markMultiplyCredit_sum + 1.33*3; END IF;
        IF i.QIYMET_HERF = 'D' THEN markMultiplyCredit_sum := markMultiplyCredit_sum + 1*3; END IF;
        IF i.QIYMET_HERF = 'F' OR i.QIYMET_HERF = 'FX' THEN markMultiplyCredit_sum := markMultiplyCredit_sum + 0*3; END IF;
    END LOOP;
    RETURN ROUND(markMultiplyCredit_sum/credits_sum,1);
END;
/
CREATE OR REPLACE FUNCTION semestr_GPA(parametr_student_id VARCHAR2,parametr_year VARCHAR2, parametr_term VARCHAR2) RETURN NUMBER IS 
    credits_sum NUMBER := 0;
    markMultiplyCredit_sum NUMBER := 0;
    CURSOR cur IS SELECT QIYMET_HERF FROM course_selection WHERE term = parametr_term AND stud_id = parametr_student_id AND YEAR = parametr_year;
BEGIN
    FOR i IN cur LOOP
        credits_sum := credits_sum + 3;
        IF i.QIYMET_HERF = 'A' THEN markMultiplyCredit_sum := markMultiplyCredit_sum + 4*3; END IF;
        IF i.QIYMET_HERF = 'A-' THEN markMultiplyCredit_sum := markMultiplyCredit_sum + 3.67*3; END IF;
        IF i.QIYMET_HERF = 'B+' THEN markMultiplyCredit_sum := markMultiplyCredit_sum + 3.33*3; END IF;
        IF i.QIYMET_HERF = 'B' THEN markMultiplyCredit_sum := markMultiplyCredit_sum + 3*3; END IF;
        IF i.QIYMET_HERF = 'B-' THEN markMultiplyCredit_sum := markMultiplyCredit_sum + 2.67*3; END IF;
        IF i.QIYMET_HERF = 'C+' THEN markMultiplyCredit_sum := markMultiplyCredit_sum + 2.33*3; END IF;
        IF i.QIYMET_HERF = 'C' THEN markMultiplyCredit_sum := markMultiplyCredit_sum + 2*3; END IF;
        IF i.QIYMET_HERF = 'C-' THEN markMultiplyCredit_sum := markMultiplyCredit_sum + 1.67*3; END IF;
        IF i.QIYMET_HERF = 'D+' THEN markMultiplyCredit_sum := markMultiplyCredit_sum + 1.33*3; END IF;
        IF i.QIYMET_HERF = 'D' THEN markMultiplyCredit_sum := markMultiplyCredit_sum + 1*3; END IF;
        IF i.QIYMET_HERF = 'F' OR i.QIYMET_HERF = 'FX' THEN markMultiplyCredit_sum := markMultiplyCredit_sum + 0*3; END IF;
    END LOOP;
    RETURN ROUND(markMultiplyCredit_sum/credits_sum,1);
END;
/
BEGIN
    DBMS_OUTPUT.PUT_LINE(semestr_GPA('8838C5DFEEDEF6D4B8579E5C2C4B709BE5FA7709','2019','1'));
    DBMS_OUTPUT.PUT_LINE(total_GPA('8838C5DFEEDEF6D4B8579E5C2C4B709BE5FA7709'));
END; 