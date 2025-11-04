*** Settings ***
# ไลบรารีหลักสำหรับการทำงานกับเว็บเบราว์เซอร์
Library         SeleniumLibrary


*** Variables ***
# ตัวแปรสำหรับ URL และข้อมูล
${BASE_SERVER_URL}  http://localhost:5173  
${ADMIN_URL}      ${BASE_SERVER_URL}/admin  
${BROWSER}        Chrome
${DELAY}          0
${VALID_USER}     thiti@gmail.com
${VALID_PASS}     Thiti003
${New_Email}    day.tiffy@test.com
${Email_Input_Locator}    tiffy@test.com


*** Keywords ***
Open Browser And Admin
    [Documentation]  ทดสอบการแก้ไขข้อมูลพนักงาน
    
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

    Wait Until Element Is Enabled    xpath://a[contains(text(),'เข้าสู่ระบบที่นี่')]
    Click Element                    xpath://a[contains(text(),'เข้าสู่ระบบที่นี่')] 

    # 3. รอการเปลี่ยนหน้า (ยืนยันว่าคลิกสำเร็จ)
    Wait Until Page Contains        เข้าสู่ระบบพนักงาน/ผู้ดูแล         timeout=10s

    # กรอกข้อมูล Login
    Wait Until Element Is Enabled   id:email    timeout=10s  
    Input Text              id:email            ${VALID_USER} 
    Input Text              id:password         ${VALID_PASS}
    
    # 4. กดปุ่ม 'เข้าสู่ระบบ' (ใช้ contains() เพื่อความเสถียร)
    Click Button        xpath://button[contains(text(),'เข้าสู่ระบบ')]

Edit Employee
    [Documentation]

    # 1. คลิกที่การ์ดของผู้ใช้
    ${User_Card_Locator}     Set Variable  xpath://span[text()='ทิฟฟี่']
    Wait Until Element Is Visible    ${User_Card_Locator}    timeout=10s
    Click Element    ${User_Card_Locator}

    # 2. คลิกปุ่ม "แก้ไขข้อมูล" เพื่อเปิดโหมดการแก้ไข
    Wait Until Element Is Visible    xpath://button[text()='แก้ไขข้อมูล']    timeout=10s
    Click Element    xpath://button[text()='แก้ไขข้อมูล']
    
   # 3. แก้ไขช่อง Input ชื่อ (แก้ไขส่วนนี้)
    # กำหนด Locator ของช่อง Input โดยอ้างอิงจากค่าเดิม
    ${Email_Input_Locator}=    Set Variable    xpath://input[@value='tiffy@test.com']
    
    # แนะนำ: ล้างข้อความเดิมออกก่อน
    Clear Element Text    xpath://input[@value='tiffy@test.com']
    
    # กรอกชื่อใหม่เข้าไป
    Input Text    ${Email_Input_Locator}    ${New_Email}
    
    # 4. คลิกปุ่ม "บันทึกการเปลี่ยนแปลง"
    Click Button    xpath://button[text()='บันทึกการเปลี่ยนแปลง']
    
    # 5. จัดการ JavaScript Alert (ทางเลือก)
    Alert Should Be Present    บันทึกข้อมูลสำเร็จ ✅    timeout=10s