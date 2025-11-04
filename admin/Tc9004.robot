*** Settings ***
# ไลบรารีหลักสำหรับการทำงานกับเว็บเบราว์เซอร์
Library         SeleniumLibrary


*** Variables ***
# ตัวแปรสำหรับ URL และข้อมูล
${BASE_SERVER_URL}  http://localhost:5173  # เปลี่ยนชื่อตัวแปรและเพิ่ม 'http://'
${BROWSER}        Chrome
${DELAY}          0
${VALID_USER}     thiti@gmail.com
${VALID_PASS}     Thiti003
${NEW_EMP_NAME}     somchai
${NEW_EMP_EMAIL}    somchai.jaidee@test.com        #kna@test.com
${NEW_EMP_TEL}      0812345678
${NEW_EMP_PASS}     Test1234
${NEW_EMP_CONFIRM}  Test1234
${NEW_EMP_ROLE}   Starter                              #Admin


*** Keywords ***
Open Browser And Admin
    [Documentation]  ทดสอบการเพิ่มพนักงานโดยไม่ใส่อีเมล
    
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
    
Employee
    [Documentation]    คลิกปุ่ม 'เพิ่มพนักงาน' และกรอกข้อมูลในฟอร์มที่ปรากฏ
    
    # 1. คลิกปุ่ม 'เพิ่มพนักงาน' เพื่อเปิดฟอร์ม/Modal
    Wait Until Element Is Visible      xpath://button[text()='เพิ่มพนักงาน']
    Click Button                       xpath://button[text()='เพิ่มพนักงาน']

    # กรอกชื่อ
    Wait Until Element Is Visible 	xpath://input[@placeholder='กรุณากรอกชื่อ - นามสกุล']
    Input Text 						xpath://input[@placeholder='กรุณากรอกชื่อ - นามสกุล'] 		${NEW_EMP_NAME}

    # กรอกเบอร์โทรศัพท์
    Wait Until Element Is Visible 	xpath://input[@placeholder='กรุณากรอกเบอร์โทรศัพท์']
    Input Text 						xpath://input[@placeholder='กรุณากรอกเบอร์โทรศัพท์'] 		${NEW_EMP_TEL}

    # *** 3. กรอกข้อมูลรหัสผ่าน (Credentials) ***
    
    # กรอกรหัสผ่าน
    Wait Until Element Is Visible 	xpath://input[@placeholder='กรุณากรอกรหัสผ่าน']
    Input Text 						xpath://input[@placeholder='กรุณากรอกรหัสผ่าน'] 			${NEW_EMP_PASS}

    # ยืนยันรหัสผ่าน
    Wait Until Element Is Visible 	xpath://input[@placeholder='กรุณายืนยันรหัสผ่าน']
    Input Text 						xpath://input[@placeholder='กรุณายืนยันรหัสผ่าน'] 		${NEW_EMP_CONFIRM} 

    # 4. เลือกตำแหน่งงาน
    # เลือกจาก Dropdown โดยใช้ Value
    Wait Until Element Is Visible 	xpath://select[@required]  
    Select From List By Value 		xpath://select[@required] 		${NEW_EMP_ROLE}
 
    # 5. กดปุ่มบันทึกข้อมูล 
    Click Button 					xpath://button[text()='บันทึกข้อมูล']

    Sleep                            1s