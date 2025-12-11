*** Settings ***
Documentation     A test suite with a single test for valid booking.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          TC-4001_register_booking.robot

*** Test Cases ***
Tc4001
    Open Browser And Register
    Register New User
    Perform Login
    Start Booking Flow
    Select Date And Holes
    Select Time And Continue
    Specify Golfers And GroupName
    Continue To Caddy Selection
    Select Caddies
    Verify Details And Confirm
    Proceed To Card Payment
    Complete Stripe Payment