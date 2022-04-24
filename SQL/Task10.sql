CREATE OR REPLACE FUNCTION ex10(parametr_emp_id VARCHAR2, parametr_DERS_KOD VARCHAR2) RETURN VARCHAR2 IS
    flow VARCHAR2(50);
BEGIN 
    SELECT year||' '||term INTO flow FROM (SELECT a.DERS_KOD,a.year,a.term,AVG(a.QIYMET_YUZ) as mark,b.emp_id FROM course_selection a INNER JOIN course_section b ON a.DERS_KOD = b.DERS_KOD AND a.year = b.year AND a.term = b.term AND a.section = b.section 
    WHERE a.DERS_KOD = parametr_DERS_KOD AND b.emp_id = parametr_emp_id GROUP BY a.DERS_KOD,a.year,a.term,b.emp_id) a WHERE mark = (SELECT MAX(mark) FROM (SELECT a.DERS_KOD,a.year,a.term,AVG(a.QIYMET_YUZ) as mark,b.emp_id FROM course_selection a 
    INNER JOIN course_section b ON a.DERS_KOD = b.DERS_KOD AND a.year = b.year AND a.term = b.term AND a.section = b.section 
    WHERE a.DERS_KOD = parametr_DERS_KOD AND b.emp_id = parametr_emp_id GROUP BY a.DERS_KOD,a.year,a.term,b.emp_id));
    RETURN flow;
END;
/
SET SERVEROUTPUT ON;
BEGIN DBMS_OUTPUT.PUT_LINE(ex10('10667','CSS 215')); END;