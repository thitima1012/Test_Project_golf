*** Settings ***
# ไลบรารีหลักสำหรับการทำงานกับเว็บเบราว์เซอร์
Library         SeleniumLibrary


*** Variables ***
# ตัวแปรสำหรับ URL และข้อมูล
${BASE_SERVER_URL}  http://localhost:5173 
#${ADMIN_URL}      ${BASE_SERVER_URL}/admin
${BROWSER}        Chrome
${DELAY}          0
${VALID_USER}     thiti@gmail.com
${VALID_PASS}     Thiti003


*** Keywords ***
Open Browser And Admin
    [Documentation]  ทดสอบการยกเลิกการจอง
    
    # 1. เปิดเบราว์เซอร์และตั้งค่า
    Open Browser    ${BASE_SERVER_URL}    ${BROWSER}
    Set Selenium Speed          ${DELAY}
    Maximize Browser Window

    # คลิก 'Join Us'
    Wait Until Element Is Visible      xpath://a[text()='Join Us']
    Click Element                      xpath://a[text()='Join Us']

    # คลิก 'เข้าสู่ระบบ'
    Wait Until Element Is Visible      xpath://a[text()='เข้าสู่ระบบ']
    Click Element                      xpath://a[text()='เข้าสู่ระบบ']

    # กรอกข้อมูล Login
    Wait Until Element Is Enabled    xpath://a[contains(text(),'เข้าสู่ระบบที่นี่')]
    Click Element                    xpath://a[contains(text(),'เข้าสู่ระบบที่นี่')] 

    # 3. รอการเปลี่ยนหน้า (ยืนยันว่าคลิกสำเร็จ)
    Wait Until Page Contains        เข้าสู่ระบบพนักงาน/ผู้ดูแล         timeout=10s

    # กรอกข้อมูล Login
    Wait Until Element Is Enabled   id:email    timeout=10s  
    Input Text              id:email            ${VALID_USER} 
    Input Text              id:password         ${VALID_PASS}

    Click Button        xpath://button[contains(text(),'เข้าสู่ระบบ')]

Delete
    [Documentation]    คลิกปุ่ม 'ข้อมูลการจอง' และกรอกข้อมูลในฟอร์มที่ปรากฏ
    
    # 1. คลิกปุ่ม 'ข้อมูลการจอง' เพื่อเปิดฟอร์ม/Modal
    Wait Until Element Is Visible      xpath://button[text()='ข้อมูลการจอง']
    Click Button                       xpath://button[text()='ข้อมูลการจอง']

    # 1. เริ่มต้นขั้นตอนการเลื่อนเวลา
    ${Reschedule_Tiger_Locator}=    Set Variable    //tr[.//td[text()='Tiger']]//button[text()='ยกเลิก']
    Wait Until Element Is Visible    ${Reschedule_Tiger_Locator}    timeout=10s
    Click Element    ${Reschedule_Tiger_Locator}
    
    # 3. ยืนยันการเลื่อนเวลา
    Click Element    xpath://button[text()='ยืนยันการยกเลิก']
    
    # 4. ตรวจสอบข้อความยืนยันผลลัพธ์
    Wait Until Page Contains    ลบการจองสำเร็จ!
