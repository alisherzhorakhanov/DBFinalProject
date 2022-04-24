SET SERVEROUTPUT ON;
CREATE OR REPLACE PACKAGE bad_stud_pkg IS
TYPE ind_studID IS RECORD(
ind NUMBER,
studID VARCHAR2(50));
TYPE tab IS TABLE OF ind_studID;
FUNCTION ex4(parametr_term VARCHAR2,parametr_year VARCHAR2) RETURN tab PIPELINED;
END bad_stud_pkg;
/
CREATE OR REPLACE PACKAGE BODY bad_stud_pkg IS
FUNCTION ex4(parametr_term VARCHAR2,parametr_year VARCHAR2) RETURN tab PIPELINED IS
    result tab;
    CURSOR cur1 IS SELECT DISTINCT stud_id, year, term FROM course_selection WHERE (term = '1' AND year = parametr_year) OR (term = '2' AND year = parametr_year-1) OR (term = '2' AND year = parametr_year) ORDER BY stud_id, year, term;
    CURSOR cur2 IS SELECT DISTINCT stud_id, year, term FROM course_selection WHERE (term = '2' AND year = parametr_year) OR (term = '1' AND year = parametr_year+1) OR (term = '1' AND year = parametr_year) ORDER BY stud_id, year, term;
    current_row cur1%ROWTYPE;
    previous_row cur1%ROWTYPE;
    i NUMBER := 0;
    one_row ind_studID;
BEGIN
    IF(parametr_term = '1') THEN
    FOR rec IN cur1
    LOOP
        current_row:= rec;
        IF((current_row.stud_id = previous_row.stud_id AND current_row.year != previous_row.year AND current_row.term = previous_row.term)) THEN 
            one_row.IND := i;
            one_row.studID := current_row.stud_id;
            PIPE ROW(one_row);
            i := i + 1;
        END IF; 
        previous_row:=rec;
    END LOOP;
    END IF;
    IF(parametr_term='2') THEN
    FOR rec IN cur2
    LOOP
        current_row:= rec;
        IF((current_row.stud_id = previous_row.stud_id AND current_row.year != previous_row.year AND current_row.term = previous_row.term)) THEN 
            one_row.IND := i;
            one_row.studID := current_row.stud_id;
            PIPE ROW(one_row);
            i := i + 1;
        END IF; 
        previous_row:=rec;
    END LOOP;
    END IF;
    RETURN;
END;
END bad_stud_pkg;
/
SELECT studID FROM TABLE(bad_stud_pkg.ex4('2','2017'));