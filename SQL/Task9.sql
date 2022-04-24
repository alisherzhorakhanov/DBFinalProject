CREATE OR REPLACE FUNCTION ex9_subjects(parametr_year IN VARCHAR2, parametr_term IN VARCHAR2, parametr_stud_id IN VARCHAR2) RETURN NUMBER IS
    subjects NUMBER;
BEGIN
    SELECT COUNT(DERS_KOD) INTO subjects FROM course_selection WHERE year = parametr_year AND term = parametr_term AND stud_id = parametr_stud_id;
    RETURN subjects;
END;
/
create or replace FUNCTION ex9_credits(parametr_year IN VARCHAR2, parametr_term IN VARCHAR2, parametr_stud_id IN VARCHAR2) RETURN NUMBER IS
    credits NUMBER;
BEGIN
    SELECT SUM(a.credits) INTO credits FROM (SELECT DISTINCT course_selection.DERS_KOD, course_section.credits FROM course_selection
    INNER JOIN course_section ON course_selection.DERS_KOD = course_section.DERS_KOD WHERE course_selection.year = parametr_year AND course_selection.term = parametr_term 
    AND course_selection.stud_id = parametr_stud_id AND course_section.credits IS NOT NULL AND course_section.credits != 0) a ;
    RETURN credits;
END;
/
SET SERVEROUTPUT ON;
BEGIN
        DBMS_OUTPUT.PUT_LINE(ex9_credits('2018','2','A14438A0887A4EA8344BEDCD5A30E4964B8505CD'));
    DBMS_OUTPUT.PUT_LINE(ex9_subjects('2018','2','A14438A0887A4EA8344BEDCD5A30E4964B8505CD'));
END;