*** Settings ***
Documentation     ทดสอบการเพิ่มพนักงานโดยไม่ใส่รหัสผ่าน

Resource          Tc9006.robot

*** Test Cases ***
Tc9006
    Open Browser And Admin
    Employee