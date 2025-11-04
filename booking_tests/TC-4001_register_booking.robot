*** Settings ***
Documentation   A resource file with reusable keywords and variables.
...
...     
Library      SeleniumLibrary

*** Variables ***
${SERVER}           localhost:5173
${BROWSER}          Chrome
${DELAY}            0
${GROUP_NAME}       Tiger 
${VALID_USER}       thiti033@gmail.com 
${VALID_PASS}       Thiti0033 
${USER_NAME}        Thiti Ma
${USER_PHONE}       0812345678
${BOOKING_TIME}    07:15


*** Keywords ***
Open Browser And Register
    # 1. เปิดเบราว์เซอร์และตั้งค่า
    Open Browser                      http://${SERVER}    ${BROWSER}
    Set Selenium Speed                ${DELAY}
    Maximize Browser Window
    
    # 2. คลิกปุ่ม 'Book Now' เพื่อเริ่มกระบวนการจอง
    Wait Until Element Is Visible      xpath://a[text()='Join Us']
    Click Element                      xpath://a[text()='Join Us']
    
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

    # 8. รอการเปลี่ยนหน้า/การแจ้งเตือน (สมมติว่าสำเร็จแล้วจะเปลี่ยนไปยังหน้า Login หรือหน้าหลัก)
    Wait Until Page Contains     เข้าสู่ระบบผู้ใช้ทั่วไป     timeout=10s 

Perform Login
    [Documentation]  เข้าสู่ระบบด้วยบัญชีที่ลงทะเบียนไว้

    # 1. รอจนกว่าฟอร์ม Login ปรากฏและกรอกข้อมูล
    Wait Until Element Is Enabled   id:email    timeout=10s  
    Input Text              id:email            ${VALID_USER} 
    Input Text              id:password         ${VALID_PASS}

    Click Button        xpath://button[contains(text(),'เข้าสู่ระบบ')]

    # 4. รอจนกว่าจะกลับมาที่หน้าหลัก (Book Now) หรือหน้านั้นโหลดแล้ว
    Wait Until Page Contains Element     xpath://button[text()='Book Now']

Start Booking Flow
    # คีย์เวิร์ดนี้ทำหน้าที่คลิก 'Book Now' หลัง Login สำเร็จ
    # 1. คลิกปุ่ม 'Book Now'
    Click Button                    xpath://button[text()='Book Now']

Select Date And Holes
    # 2. เลือกวันที่: ใช้ชื่อ (name) 'date' เพื่อป้อนค่า
    Wait Until Element Is Visible    xpath://input[@name='date']    10s
    Input Text                       xpath://input[@name='date']    04-11-2025

    #Click Button                     xpath:(//button[normalize-space(text())='จองต่อ'])
     
    # 3. เลือก 18 หลุม: ใช้ XPath อ้างอิงจากข้อความ
    #Click Button                    xpath://button[text()='9 หลุม']

Select Time And Continue
    
    Click Button                     xpath://button[normalize-space(text())='07:45']
    
    # 5. กดปุ่ม 'จองต่อ' ปุ่มแรก 
    Click Button                     xpath:(//button[normalize-space(text())='จองต่อ'])    

# ----------------- Main Flow: ขั้นตอนที่ 2 (จำนวน, กลุ่ม, บริการเสริม) ----------------- 
Specify Golfers And GroupName 
    
    #6. ตั้งชื่อกลุ่ม (name='groupName') 
    Input Text     name:groupName     ${GROUP_NAME} 
    
    # 7. กดปุ่ม 'จองต่อ'   
    Click Button         xpath:(//button[normalize-space(text())='จองต่อ'])

Continue To Caddy Selection
    # 8. กดปุ่ม 'จองต่อ' ปุ่มที่สอง (จากหน้า Add-ons)
    Wait Until Page Contains          ต้องการเลือกแคดดี้
    Click Element    id:caddy-selection-toggle

# ----------------- Main Flow: ขั้นตอนที่ 3 (เลือกแคดดี้) -----------------
Select Caddies
    # 1. คลิกที่ Checkbox โดยใช้ JavaScript 
    Wait Until Element Is Enabled    id:caddy-selection-toggle
    Sleep                            1s 
    
    # 2. รอจนกว่า Caddy4 จะคลิกได้ โดยใช้ XPath  
    Wait Until Element Is Enabled        xpath://p[contains(text(), 'C20')]  10s
    ${CADDY_LOCATOR}=    Set Variable    xpath://p[contains(text(), 'C20')]
    Click Element        ${CADDY_LOCATOR}

Verify Details And Confirm
    [Documentation]     ยืนยันรายละเอียดการจองและกดปุ่มยืนยัน

    # 1. รอจนกว่าปุ่ม 'ยืนยันการจอง' จะพร้อมใช้งาน
    Wait Until Element Is Enabled    xpath://button[normalize-space(text())='ยืนยันการจอง']
 
    # 2. กดปุ่ม 'ยืนยันการจอง'
    Click Button                     xpath://button[normalize-space(text())='ยืนยันการจอง']

    #Wait Until Page Contains     สรุปและตรวจสอบ     timeout=10s
    Click Button                     xpath://button[normalize-space(text())='ดำเนินการชำระเงิน']
    
    Wait Until Location Contains       checkout.stripe.com        30s

# ----------------- Main Flow: ขั้นตอนที่ 4 (การชำระเงิน) -----------------
Proceed To Card Payment
    [Documentation]     จัดการกับหน้า Stripe Checkout: คลิก Header เพื่อเปิดฟอร์ม, Select Frame และรอ Element
    Input Text                       xpath://input[@name='email']        ${VALID_USER}
 
    # 2. รอจนกว่า Input Field แรกจะโหลดภายใน iFrame
    Wait Until Element Is Visible   id:cardNumber

Complete Stripe Payment
    [Documentation]    กรอกข้อมูลบัตรทดสอบ Stripe และข้อมูลที่จำเป็นอื่นๆ แล้วกด Pay
 
    # *** 1. กรอกข้อมูลบัตรหลัก (ทั้งหมดอยู่นอก iFrame) ***
     
    # กรอกหมายเลขบัตร (Card Number)
    Wait Until Element Is Visible    id:cardNumber
    Input Text                       id:cardNumber  4242 4242 4242 4242
 
    # กรอกวันหมดอายุ (Expiration)
    Wait Until Element Is Visible    id:cardExpiry
    Input Text                       id:cardExpiry  12 / 29
 
    # กรอกรหัส CVC
    Wait Until Element Is Visible    id:cardCvc
    Input Text                       id:cardCvc     123

    # *** 2. กรอกข้อมูลการเรียกเก็บเงิน (Billing Info) ที่พบใหม่ ***

    # Cardholder name
    Wait Until Element Is Visible    id:billingName
    Input Text                       id:billingName      TEST USER

    # *** 3. กดปุ่ม 'Pay' ***

    # ใช้ XPath ที่หา span[text()='Pay'] แล้วย้อนไปหาปุ่ม <button> หรือองค์ประกอบที่คล้ายกัน
    ${PAY_BUTTON_LOCATOR}=      Set Variable    xpath://span[text()='Pay']/ancestor::button

    Wait Until Element Is Enabled       ${PAY_BUTTON_LOCATOR}
    Click Element                       ${PAY_BUTTON_LOCATOR}

    # 5. ยืนยันว่าหน้านี้คือหน้าสำเร็จ (คุณอาจต้องแก้ไขข้อความนี้ให้ตรงกับหน้าเว็บจองของคุณ)
    Wait Until Page Contains        ชำระเงินสำเร็จ    20s 

    Close Browser

#Return To Homepage
    #[Documentation]    คลิกปุ่ม 'กลับหน้าหลัก' เพื่อสิ้นสุดกระบวนการจอง

    # 1. รอจนกว่าปุ่ม 'กลับหน้าหลัก' จะคลิกได้
    #Wait Until Element Is Enabled       xpath://button[text()='กลับหน้าหลัก']

    # 2. กดปุ่ม 'กลับหน้าหลัก'
    #Click Element                       xpath://button[text()='กลับหน้าหลัก']

    # 3. ให้เวลาเบราว์เซอร์นำทางกลับไปหน้าหลัก 
    #Sleep                   3s  # ให้เวลาระบบประมวลผลการนำทาง

    # 4. ยืนยันว่าหน้าหลักโหลดแล้ว (ตัวอย่าง: ตรวจสอบข้อความ "Welcome" หรือ "Book Now")
    #Wait Until Page Contains         Welcome, Thiti Ma       timeout=10s

    # 5. ปิดเบราว์เซอร์
    #Close Browser