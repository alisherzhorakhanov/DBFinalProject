SELECT * FROM course_selection;
SELECT * FROM course_section;
SELECT * FROM course_schedule;
CREATE OR REPLACE PACKAGE teachers_rating_pkg IS
TYPE empID_avgMark IS RECORD(
emp_id VARCHAR2(50),
avgMark VARCHAR2(50));
TYPE colum IS TABLE OF empID_avgMark;
FUNCTION ex11(p_year VARCHAR2, p_term VARCHAR2) RETURN colum PIPELINED;
END teachers_rating_pkg;
/
CREATE OR REPLACE PACKAGE BODY teachers_rating_pkg IS
FUNCTION ex11(p_year VARCHAR2, p_term VARCHAR2) RETURN colum PIPELINED IS
    result colum;
    i NUMBER := 0;
    r empID_avgMark;
BEGIN
    FOR rec IN (SELECT a.EMP_ID, AVG(b.QIYMET_YUZ) avgMark FROM course_section a INNER JOIN course_selection b ON a.DERS_KOD = b.DERS_KOD AND a.YEAR = b.YEAR AND a.TERM = b.TERM AND a.SECTION = b.SECTION WHERE a.YEAR = p_year AND a.TERM = p_term GROUP BY a.EMP_ID ORDER BY AVG(b.QIYMET_YUZ) DESC)
    LOOP
        r.emp_id := rec.emp_id;
        r.avgMark := rec.avgMark;
        PIPE ROW(r);
        i := i + 1;
        EXIT WHEN i = 5;
    END LOOP;
    RETURN;
END;
END teachers_rating_pkg;
/
SELECT * FROM TABLE(teachers_rating_pkg.ex11('2018','2'));