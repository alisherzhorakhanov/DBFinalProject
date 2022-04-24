CREATE OR REPLACE PROCEDURE ex_8(parametr_stud_id VARCHAR2,parametr_year VARCHAR2, parametr_term VARCHAR2,result OUT VARCHAR2) IS
    temp VARCHAR2(32666):='COURSE/DAY OF WEEK/TIME'||chr(10);
BEGIN
    FOR I IN (SELECT DERS_KOD,day,time FROM (SELECT a.DERS_KOD,a.section, to_char(b.start_time ,'D') as day, to_char(b.start_time ,'hh24') as time FROM course_selection a 
    INNER JOIN course_schedule b ON a.DERS_KOD = b.DERS_KOD AND a.section = b.section AND a.year = b.year AND a.term = b.term
    WHERE a.stud_id = parametr_stud_id AND a.year = parametr_year AND a.term = parametr_term) ORDER BY day,time)
    LOOP
    temp:=temp||I.DERS_KOD||'     ' ||I.day||'    '||I.time||chr(10);
    END LOOP;
    result:=temp;
END;
/
SET SERVEROUTPUT ON;
DECLARE
result VARCHAR2(32666);
BEGIN
result:='';
ex_8('8838C5DFEEDEF6D4B8579E5C2C4B709BE5FA7709','2019','1',result);
dbms_output.put_line(result);
END;