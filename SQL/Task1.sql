CREATE OR REPLACE PACKAGE pop_courses_pkg IS
TYPE ind_coursecode IS RECORD(
ind NUMBER,
coursecode VARCHAR2(50));
TYPE tab IS TABLE OF ind_coursecode;
FUNCTION ex1(parametr_year VARCHAR2, parametr_term VARCHAR2) RETURN tab PIPELINED;
END pop_courses_pkg;
/
CREATE OR REPLACE PACKAGE BODY pop_courses_pkg IS
FUNCTION ex1(parametr_year VARCHAR2, parametr_term VARCHAR2) RETURN tab PIPELINED IS
    result tab;
    i NUMBER := 0;
    one_row ind_coursecode;
BEGIN
    FOR rec IN (SELECT DERS_KOD,MAX(cast(reg_date as date))-MIN(cast(reg_date as date)) as diff FROM course_selection 
WHERE year = parametr_year AND term = parametr_term AND reg_date IS NOT NULL GROUP BY DERS_KOD HAVING MAX(cast(reg_date as date))-MIN(cast(reg_date as date)) IS NOT NULL
ORDER BY diff)
    LOOP
        one_row.coursecode := rec.DERS_KOD;
        one_row.ind := i;
        PIPE ROW(one_row);
        i := i + 1;
        EXIT WHEN i = 5;
    END LOOP;
    RETURN;
END;
END pop_courses_pkg;
/
SELECT coursecode FROM TABLE(pop_courses_pkg.ex1('2018','1'));
