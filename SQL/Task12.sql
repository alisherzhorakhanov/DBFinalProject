SELECT * FROM course_selection;
SELECT * FROM course_section;
SELECT * FROM course_schedule;
CREATE OR REPLACE PACKAGE subject_rating_pkg IS
TYPE courseCode_avgMark IS RECORD(
courseCode VARCHAR2(50),
avgMark VARCHAR2(50));
TYPE colum IS TABLE OF courseCode_avgMark;
FUNCTION ex12(p_year VARCHAR2, p_term VARCHAR2) RETURN colum PIPELINED;
END subject_rating_pkg;
/
CREATE OR REPLACE PACKAGE BODY subject_rating_pkg IS
FUNCTION ex12(p_year VARCHAR2, p_term VARCHAR2) RETURN colum PIPELINED IS
    result colum;
    i NUMBER := 0;
    r courseCode_avgMark;
BEGIN
    FOR rec IN (SELECT DERS_KOD, AVG(QIYMET_YUZ) avgMark FROM course_selection WHERE YEAR = p_year AND TERM = p_term GROUP BY DERS_KOD ORDER BY AVG(QIYMET_YUZ) DESC)
    LOOP
        r.courseCode := rec.DERS_KOD;
        r.avgMark := rec.avgMark;
        PIPE ROW(r);
        i := i + 1;
        EXIT WHEN i = 5;
    END LOOP;
    RETURN;
END;
END subject_rating_pkg;
/
SELECT * FROM TABLE(subject_rating_pkg.ex12('2018','2'));