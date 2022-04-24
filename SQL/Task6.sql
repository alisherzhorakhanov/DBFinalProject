CREATE OR REPLACE FUNCTION ex6(parametr_year IN VARCHAR2, parametr_term IN VARCHAR2, parametr_emp_id IN VARCHAR2) RETURN NUMBER IS
    result NUMBER;
BEGIN
    SELECT SUM(hour_num) INTO result FROM course_section WHERE year = parametr_year AND term = parametr_term AND emp_id = parametr_emp_id;
    RETURN result;
END;
/
SET SERVEROUTPUT ON;
BEGIN
    DBMS_OUTPUT.PUT_LINE(ex6('2017','2','10128'));
END;

