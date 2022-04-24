import sys 
import cx_Oracle
from PyQt5 import QtWidgets,QtGui
from PyQt5.QtWidgets import *

import mainWindowDesign 
import task1Design
import task2Design
import task3Design
import task4Design
import task5Design
import task6Design
import task7Design
import task8Design
import task9Design
import task10Design
import task11Design
import task12Design
import task13Design

# oracleCon = "@localhost:1521/xe"
# dsn_tns = cx_Oracle.makedsn('localhost', 1521, oracle_sid = 'orcl')
# oracleCon = cx_Oracle.connect(user='c##projectdb', password='123', dsn=dsn_tns)

class MainWindow(QtWidgets.QMainWindow, mainWindowDesign.Ui_MainWindow):
    def __init__(self):
        super().__init__()
        self.setupUi(self)
        self.pushButton.clicked.connect(self.onClickBtn1)
        self.pushButton_2.clicked.connect(self.onClickBtn2)
        self.pushButton_3.clicked.connect(self.onClickBtn3)
        self.pushButton_4.clicked.connect(self.onClickBtn4)
        self.pushButton_5.clicked.connect(self.onClickBtn5)
        self.pushButton_6.clicked.connect(self.onClickBtn6)
        self.pushButton_7.clicked.connect(self.onClickBtn7)
        self.pushButton_8.clicked.connect(self.onClickBtn8)
        self.pushButton_9.clicked.connect(self.onClickBtn9)
        self.pushButton_10.clicked.connect(self.onClickBtn10)
        self.pushButton_11.clicked.connect(self.onClickBtn11)
        self.pushButton_12.clicked.connect(self.onClickBtn12)
        self.pushButton_13.clicked.connect(self.onClickBtn13)
        self.task1 = Task1()
        self.task2 = Task2()
        self.task3 = Task3()
        self.task4 = Task4()
        self.task5 = Task5()
        self.task6 = Task6()
        self.task7 = Task7()
        self.task8 = Task8()
        self.task9 = Task9()
        self.task10 = Task10()
        self.task11 = Task11()
        self.task12 = Task12()
        self.task13 = Task13()
    def onClickBtn1(self):
        self.task1.show()
    def onClickBtn2(self):
        self.task2.show()
    def onClickBtn3(self):
        self.task3.show()
    def onClickBtn4(self):
        self.task4.show()
    def onClickBtn5(self):
        self.task5.show()
    def onClickBtn6(self):
        self.task6.show()
    def onClickBtn7(self):
        self.task7.show()
    def onClickBtn8(self):
        self.task8.show()
    def onClickBtn9(self):
        self.task9.show()
    def onClickBtn10(self):
        self.task10.show()
    def onClickBtn11(self):
        self.task11.show()
    def onClickBtn12(self):
        self.task12.show()  
    def onClickBtn13(self):
        self.task13.show()        
class Task1(QtWidgets.QMainWindow, task1Design.Ui_MainWindow):
    def __init__(self):
        super().__init__()
        self.setupUi(self)
        self.pushButton.clicked.connect(self.onClickBtn)
    def onClickBtn(self):
        con = cx_Oracle.connect(oracleCon)
        cur = con.cursor()
        text = ""
        cur.execute('select coursecode from table(pop_courses_pkg.ex1(\'{}\',\'{}\'))'.format(self.textEdit_2.toPlainText(),self.textEdit.toPlainText()))
        row = cur.fetchall()
        for i in range(cur.rowcount):
            courseCode = row[i][0]
            item_str = str(i+1)+" " + row[i][0]+"; teachers:"
            cur.execute('''select distinct course_section.emp_id FROM course_selection INNER JOIN course_section ON 
            course_selection.DERS_KOD = course_section.DERS_KOD AND course_selection.section = course_section.section AND 
            course_selection.year = course_section.year AND course_selection.term = course_section.term WHERE 
            course_selection.DERS_KOD = \'{}\' AND course_selection.year = {} AND course_selection.term = {}'''.format(courseCode,self.textEdit_2.toPlainText(),self.textEdit.toPlainText()))
            a = cur.fetchall()
            if(cur.rowcount != 0):
                for employee in a:
                    item_str += employee[0] + " "
            text+= item_str+"\n"
        self.label_4.setText(text)
        cur.close()
        con.commit()
class Task2(QtWidgets.QMainWindow, task2Design.Ui_MainWindow):
    def __init__(self):
        super().__init__()
        self.setupUi(self)
        self.pushButton.clicked.connect(self.onClickBtn)
    def onClickBtn(self):
        con = cx_Oracle.connect(oracleCon)
        cursor = con.cursor()
        text = ""
        cursor.execute('select teacher from table(pop_teachers_pkg.ex2(\'{}\',\'{}\',\'{}\'))'.format(self.textEdit_2.toPlainText(),self.textEdit.toPlainText(),self.textEdit_3.toPlainText()))
        row = cursor.fetchall()
        for i in range(cursor.rowcount):
            item_str = str(i+1)+" " + row[i][0]
            text+= item_str+"\n"
        self.label_5.setText(text)
        con.commit()
        cursor.close()
class Task3(QtWidgets.QMainWindow, task3Design.Ui_MainWindow):
    def __init__(self):
        super().__init__()
        self.setupUi(self)
        self.pushButton_2.clicked.connect(self.onClickBtn_2)
        self.pushButton.clicked.connect(self.onClickBtn)
    def onClickBtn_2(self):
        con = cx_Oracle.connect(oracleCon)
        cursor = con.cursor()
        result = cursor.callfunc(name="total_GPA",returnType=str,parameters =[self.textEdit_5.toPlainText()])
        self.textEdit_6.setText(result)
        con.commit()
        cursor.close()
    def onClickBtn(self):
        con = cx_Oracle.connect(oracleCon)
        cursor = con.cursor()
        result = cursor.callfunc(name="semestr_GPA",returnType=str,parameters =[self.textEdit.toPlainText(),self.textEdit_2.toPlainText(),self.textEdit_3.toPlainText()])
        self.textEdit_4.setText(result)
        con.commit()
        cursor.close()
class Task4(QtWidgets.QMainWindow, task4Design.Ui_MainWindow):
    def __init__(self):
        super().__init__()
        self.setupUi(self)
        self.pushButton.clicked.connect(self.onClickBtn)
    def onClickBtn(self):
        con = cx_Oracle.connect(oracleCon)
        cursor = con.cursor()
        cursor.execute('select studID from table(bad_stud_pkg.ex4(\'{}\',\'{}\'))'.format(self.textEdit.toPlainText(),self.textEdit_2.toPlainText()))
        row = cursor.fetchall()
        for i in range(cursor.rowcount):
            item_str = str(i+1)+" " + row[i][0]
            item = QListWidgetItem(item_str)
            self.listWidget.addItem(item) 
        con.commit()
        cursor.close()
class Task5(QtWidgets.QMainWindow, task5Design.Ui_MainWindow):
    def __init__(self):
        super().__init__()
        self.setupUi(self)
        self.pushButton.clicked.connect(self.onClickBtn)
        self.pushButton_2.clicked.connect(self.onClickBtn_2)
    def onClickBtn(self):
        con = cx_Oracle.connect(oracleCon)
        cursor = con.cursor()
        result = cursor.callfunc(name="semester_retake",returnType=str,parameters =[self.textEdit.toPlainText(),self.textEdit_2.toPlainText(),self.textEdit_3.toPlainText()])
        self.textEdit_4.setText(result)
        con.commit()
        cursor.close()
    def onClickBtn_2(self):
        con = cx_Oracle.connect(oracleCon)
        cursor = con.cursor()
        result = cursor.callfunc(name="retake",returnType=str,parameters =[self.textEdit_5.toPlainText()])
        self.textEdit_6.setText(result)
        con.commit()
        cursor.close()
class Task6(QtWidgets.QMainWindow, task6Design.Ui_MainWindow):
    def __init__(self):
        super().__init__()
        self.setupUi(self)
        self.pushButton.clicked.connect(self.onClickBtn)
    def onClickBtn(self):
        con = cx_Oracle.connect(oracleCon)
        cursor = con.cursor()
        result = cursor.callfunc(name="ex6",returnType=str,parameters =[self.textEdit_2.toPlainText(),self.textEdit_3.toPlainText(),self.textEdit.toPlainText()])
        self.textEdit_4.setText(result)
        con.commit()
        cursor.close()
class Task7(QtWidgets.QMainWindow, task7Design.Ui_MainWindow):
    def __init__(self):
        super().__init__()
        self.setupUi(self)
        self.pushButton.clicked.connect(self.onClickBtn)
    def onClickBtn(self):
        con = cx_Oracle.connect(oracleCon)
        cursor = con.cursor()
        outVal = cursor.var(str)
        cursor.callproc('ex_7', [self.textEdit.toPlainText(),self.textEdit_2.toPlainText(),self.textEdit_3.toPlainText(),outVal])
        itemArr = (outVal.getvalue()).split('\n')
        for i in itemArr:
            item = QListWidgetItem(i)
            self.listWidget.addItem(item) 
        con.commit()
        cursor.close()
class Task8(QtWidgets.QMainWindow, task8Design.Ui_MainWindow):
    def __init__(self):
        super().__init__()
        self.setupUi(self)
        self.pushButton.clicked.connect(self.onClickBtn)
    def onClickBtn(self):
        con = cx_Oracle.connect(oracleCon)
        cursor = con.cursor()
        outVal = cursor.var(str)
        cursor.callproc('ex_8', [self.textEdit.toPlainText(),self.textEdit_2.toPlainText(),self.textEdit_3.toPlainText(),outVal])
        itemArr = (outVal.getvalue()).split('\n')
        for i in itemArr:
            item = QListWidgetItem(i)
            self.listWidget.addItem(item) 
        con.commit()
        cursor.close()
class Task9(QtWidgets.QMainWindow, task9Design.Ui_MainWindow):
    def __init__(self):
        super().__init__()
        self.setupUi(self)
        self.pushButton.clicked.connect(self.onClickBtn)
        self.pushButton_2.clicked.connect(self.onClickBtn_2)
    def onClickBtn(self):
        con = cx_Oracle.connect(oracleCon)
        cursor = con.cursor()
        result = cursor.callfunc(name="ex9_subjects",returnType=str,parameters =[self.textEdit_2.toPlainText(),self.textEdit_3.toPlainText(),self.textEdit.toPlainText()])
        self.textEdit_4.setText(result)
        con.commit()
        cursor.close()
    def onClickBtn_2(self):
        con = cx_Oracle.connect(oracleCon)
        cursor = con.cursor()
        result = cursor.callfunc(name="ex9_credits",returnType=str,parameters =[self.textEdit_2.toPlainText(),self.textEdit_3.toPlainText(),self.textEdit.toPlainText()])
        self.textEdit_5.setText(result)
        con.commit()
        cursor.close()
class Task10(QtWidgets.QMainWindow, task10Design.Ui_MainWindow):
    def __init__(self):
        super().__init__()
        self.setupUi(self)
        self.pushButton.clicked.connect(self.onClickBtn)
    def onClickBtn(self):
        con = cx_Oracle.connect(oracleCon)
        cursor = con.cursor()
        result = cursor.callfunc(name="ex10",returnType=str,parameters =[self.textEdit_2.toPlainText(),self.textEdit_3.toPlainText()])
        self.textEdit.setText(result)
        con.commit()
        cursor.close()
class Task11(QtWidgets.QMainWindow, task11Design.Ui_MainWindow):
    def __init__(self):
        super().__init__()
        self.setupUi(self)
        self.pushButton.clicked.connect(self.onClickBtn)
    def onClickBtn(self):
        con = cx_Oracle.connect(oracleCon)
        cursor = con.cursor()
        text = ""
        cursor.execute('select * from table(teachers_rating_pkg.ex11(\'{}\',\'{}\'))'.format(self.textEdit_2.toPlainText(),self.textEdit_3.toPlainText()))
        row = cursor.fetchall()
        for i in range(cursor.rowcount):
            item_str = str(i+1)+" " + row[i][0] + " " + row[i][1][:10]
            text+= item_str+"\n"
        self.label_5.setText(text)
        con.commit()
        cursor.close()
class Task12(QtWidgets.QMainWindow, task12Design.Ui_MainWindow):
    def __init__(self):
        super().__init__()
        self.setupUi(self)
        self.pushButton.clicked.connect(self.onClickBtn)
    def onClickBtn(self):
        con = cx_Oracle.connect(oracleCon)
        cursor = con.cursor()
        text = ""
        cursor.execute('select * from table(subject_rating_pkg.ex12({},{}))'.format(self.textEdit_2.toPlainText(),self.textEdit_3.toPlainText()))
        row = cursor.fetchall()
        for i in range(cursor.rowcount):
            item_str = str(i+1)+" " + row[i][0] + " " + row[i][1][:10]
            text+= item_str+"\n"
        self.label_5.setText(text)
        con.commit()
        cursor.close()
class Task13(QtWidgets.QMainWindow, task13Design.Ui_MainWindow):
    def __init__(self):
        super().__init__()
        self.setupUi(self)
        self.pushButton.clicked.connect(self.onClickBtn)
    def onClickBtn(self):
        con = cx_Oracle.connect(oracleCon)
        cursor = con.cursor()
        result = cursor.callfunc(name="ex13_profit",returnType=str)
        self.textEdit.setText(result)
        con.commit()
        cursor.close()
def main():
    app = QtWidgets.QApplication(sys.argv) 
    window = MainWindow() 
    window.show() 
    app.exec_() 

if __name__ == '__main__': 
    main() 
