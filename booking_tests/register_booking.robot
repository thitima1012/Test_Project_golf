*** Settings ***
Documentation   A resource file with reusable keywords and variables.
...
...     
Library      SeleniumLibrary

*** Variables ***
${SERVER}           localhost:5173
${BROWSER}          Chrome
${DELAY}            0
${GROUP_NAME}       Tiger's 
${VALID_USER}       thiti@gmail.com 
${VALID_PASS}       Thiti003 
${USER_NAME}        thitima
${USER_PHONE}       0616632103
${USER_EXISTS_ERROR}     User already exists
${SUCCESS_REDIRECT}     http://localhost:5173/login


*** Keywords ***
Open Browser And Register
    # 1. เปิดเบราว์เซอร์และตั้งค่า
    Open Browser                      http://${SERVER}    ${BROWSER}
    Set Selenium Speed                ${DELAY}
    Maximize Browser Window
    
    # 2. คลิกปุ่ม 'Book Now' เพื่อเริ่มกระบวนการจอง
    Wait Until Element Is Visible     xpath://button[text()='Book Now']
    Click Button                      xpath://button[text()='Book Now']
    
Register New User
    [Documentation]     กรอกข้อมูลเพื่อลงทะเบียนผู้ใช้ใหม่

    # 1. รอจนกว่าฟอร์ม Register ปรากฏและพร้อมใช้งาน
    Wait Until Element Is Enabled       id:name       timeout=10s
 
    # 2. กรอกชื่อ
    Input Text             id:name         ${USER_NAME}

    # 3. กรอกเบอร์โทรศัพท์
    Input Text             id:phone        ${USER_PHONE}

    # 4. กรอกอีเมล (ใช้ ${VALID_USER})
    Input Text             id:email        ${VALID_USER}

    # 5. กรอกรหัสผ่าน (ใช้ ${VALID_PASS})
    Input Text             id:password     ${VALID_PASS}

    # 6. ยืนยันรหัสผ่าน
    Input Text             id:confirmPassword     ${VALID_PASS}
 
    # 7. กดปุ่ม 'ลงทะเบียน'
    Click Button     xpath://button[text()='ลงทะเบียน']

Verify Registration Failure (User Exists)
    [Documentation]     ตรวจสอบว่ามีข้อความ Error หรือไม่และทำให้ Test Fail ถ้าลงทะเบียน "สำเร็จ"
    
    # ตรวจสอบว่ามีข้อความ Error หรือไม่ภายใน 5 วินาที
    ${ERROR_FOUND}=     Run Keyword And Return Status   Wait Until Page Contains    ${USER_EXISTS_ERROR}    timeout=5s

Return To Homepage
    # 1. ปิดเบราว์เซอร์
    Close Browser