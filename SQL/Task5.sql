CREATE OR REPLACE FUNCTION semester_retake(parametr_stud_id VARCHAR2, parametr_year VARCHAR2,parametr_term VARCHAR2) RETURN NUMBER IS
    retake NUMBER:=0;
BEGIN
    SELECT 75000*COUNT(DERS_KOD) INTO retake FROM course_selection 
    WHERE DERS_KOD IN (SELECT DERS_KOD FROM (SELECT count(stud_id), DERS_KOD 
    FROM course_selection WHERE stud_id = parametr_stud_id
    GROUP BY DERS_KOD HAVING count(stud_id) > 1)) AND stud_id = parametr_stud_id AND year = parametr_year AND term = parametr_term AND QIYMET_YUZ >= 50;
    RETURN retake;
END;
/
CREATE OR REPLACE FUNCTION retake(parametr_stud_id VARCHAR2) RETURN NUMBER IS
    retake NUMBER := 0;
BEGIN
    SELECT 75000*COUNT(DERS_KOD) INTO retake FROM course_selection 
    WHERE DERS_KOD IN (SELECT DERS_KOD FROM (SELECT count(stud_id), DERS_KOD 
    FROM course_selection WHERE stud_id = parametr_stud_id
    GROUP BY DERS_KOD HAVING count(stud_id) > 1)) AND stud_id = parametr_stud_id AND QIYMET_YUZ >= 50;
    RETURN retake;
END;
/
SET SERVEROUTPUT ON;
BEGIN DBMS_OUTPUT.PUT_LINE(semester_retake('A14438A0887A4EA8344BEDCD5A30E4964B8505CD','2018','1')); END;
BEGIN DBMS_OUTPUT.PUT_LINE(retake('A14438A0887A4EA8344BEDCD5A30E4964B8505CD')); END;
