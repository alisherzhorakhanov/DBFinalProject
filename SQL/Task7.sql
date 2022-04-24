CREATE OR REPLACE PROCEDURE ex_7(parametr_emp_id VARCHAR2,parametr_year VARCHAR2, parametr_term VARCHAR2,result OUT VARCHAR2) IS
    temp VARCHAR2(32666):='COURSE/DAY OF WEEK/TIME'||chr(10);
BEGIN
    FOR I IN (SELECT DERS_KOD,day,time FROM (SELECT course_section.DERS_KOD, course_section.section, to_char(course_schedule.start_time ,'D') as day, to_char(course_schedule.start_time ,'hh24') as time FROM course_section 
    INNER JOIN course_schedule ON course_section.DERS_KOD = course_schedule.DERS_KOD AND course_section.section = course_schedule.section AND course_section.year = course_schedule.year AND course_section.term = course_schedule.term
    WHERE course_section.emp_id = parametr_emp_id AND course_section.year = parametr_year AND course_section.term = parametr_term) ORDER BY day,time)
    LOOP
    temp := temp || I.DERS_KOD||'      '||I.day||'       '||I.time||chr(10);
    dbms_output.put_line(result);
    END LOOP;
    result := temp;
END;
/
DECLARE 
result VARCHAR2(32766);
BEGIN
result:='';
ex_7('10128','2017','2',result);
dbms_output.put_line(result);
END;