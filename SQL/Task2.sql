CREATE OR REPLACE PACKAGE pop_teachers_pkg IS
TYPE ind_teacher IS RECORD(
ind NUMBER,
teacher VARCHAR2(50));
TYPE tab IS TABLE OF ind_teacher;
FUNCTION ex2(parametr_year VARCHAR2, parametr_term VARCHAR2,parametr_ders_kod VARCHAR2) RETURN tab PIPELINED;
END pop_teachers_pkg;
/
CREATE OR REPLACE PACKAGE BODY pop_teachers_pkg IS
FUNCTION ex2(parametr_year VARCHAR2, parametr_term VARCHAR2,parametr_ders_kod VARCHAR2) RETURN tab PIPELINED IS
    result tab;
    i NUMBER := 0;
    one_row ind_teacher;
BEGIN
    FOR rec IN (SELECT course_section.emp_id,MAX(cast(course_selection.reg_date as date))-MIN(cast(course_selection.reg_date as date)) as diff FROM course_selection
    INNER JOIN course_section ON course_selection.DERS_KOD = course_section.DERS_KOD AND course_selection.section = course_section.section 
    AND course_selection.year = course_section.year AND course_selection.term = course_section.term
WHERE course_selection.year = parametr_year AND course_selection.term = parametr_term AND course_selection.DERS_KOD = parametr_ders_kod AND course_selection.reg_date IS NOT NULL GROUP BY course_section.emp_id 
HAVING MAX(cast(course_selection.reg_date as date))-MIN(cast(course_selection.reg_date as date)) IS NOT NULL
ORDER BY diff)
    LOOP
        one_row.ind := i;
        one_row.teacher := rec.emp_id;
        PIPE ROW(one_row);
        i := i + 1;
    END LOOP;
    RETURN;
END;
END pop_teachers_pkg;
/
SELECT * FROM TABLE(pop_teachers_pkg.ex2('2018','1','CSS 215')); 