*** Settings ***
Documentation     ทดสอบการแก้ไขข้อมูลพนักงาน

Resource          Tc9002_Edit.robot

*** Test Cases ***
Tc9002
    Open Browser And Admin
    Edit Employee