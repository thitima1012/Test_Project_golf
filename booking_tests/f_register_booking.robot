*** Settings ***
Documentation     A test suite with a single test for valid booking.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          register_booking.robot

*** Test Cases ***
Booking
    Open Browser And Register
    Register New User
    Verify Registration Failure (User Exists)
    Return To Homepage