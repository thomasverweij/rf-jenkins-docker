*** Settings ***
Library  Browser


*** Test Cases ***
Test 1
    Open Browser  url=https://example.com   headless=True  
    Take Screenshot