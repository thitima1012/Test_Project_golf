*** Settings ***
Documentation     ทดสอบการเพิ่มพนักงานโดยไม่ใส่ยืนยันรหัสผ่าน

Resource          Tc9007.robot

*** Test Cases ***
Tc9007
    Open Browser And Admin
    Employee