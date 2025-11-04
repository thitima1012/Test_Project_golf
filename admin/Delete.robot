*** Settings ***
Documentation     ทดสอบการยกเลิกการจอง
Resource          Tc8002_Delete.robot

*** Test Cases ***
Tc8002
    Open Browser And Admin
    Delete