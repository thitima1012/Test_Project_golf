*** Settings ***
Documentation     ทดสอบการเพิ่มพนักงาน

Resource          Tc9001_Employee.robot

*** Test Cases ***
Tc9001
    Open Browser And Admin
    Employee