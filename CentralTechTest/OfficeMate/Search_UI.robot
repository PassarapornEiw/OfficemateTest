*** Settings ***
Library    Selenium2Library
Library  OperatingSystem
Library  BuiltIn

Suite Setup   Set ChromeDriver path
Suite Teardown    Close All Browsers

*** Keywords ***
Set ChromeDriver path
    [Documentation]    To set chromedriver path
    Set Suite Variable    ${Driver_Path}    ${EXECDIR}/Driver/chromedriver
    ${options}=    Evaluate  sys.modules['selenium.webdriver.chrome.options'].Options()    sys
    Call Method     ${options}    add_argument    --disable-notifications
    ${dict}    BuiltIn.Create Dictionary    executable_path=${Driver_Path}
    Create Webdriver    Chrome    kwargs=${dict}   options=${options}

Close promotion image popup at Homepage
    sleep  10
    ${popup}   run keyword and return status    ELEMENT SHOULD BE VISIBLE    //iframe[@class='sp-fancybox-iframe sp-fancybox-skin sp-fancybox-iframe-10882 adaptive-resolution']
    run keyword if   ${popup}   select frame  //iframe[@class='sp-fancybox-iframe sp-fancybox-skin sp-fancybox-iframe-10882 adaptive-resolution']
    #wait until element is visible  //*[@id="close-button-1454703945249"]
    run keyword if   ${popup}  click element  //*[@id="close-button-1454703945249"]

Close promotion image popup at Product page
    sleep    5
    ${productpopup}   run keyword and return status    ELEMENT SHOULD BE VISIBLE    //*[@class="ins-close-button"]
    run keyword if   ${productpopup}   click element      //*[@class="ins-close-button"]


*** Test Cases ***
UI03 Validate when input keyword, all similar products should appeared with total result
    [Documentation]   Validate when user input keyword and click search button, all similar products should appeared with total result.
    Go to   https://www.officemate.co.th/en
    Close promotion image popup at Homepage
    Input text    //*[@id="app"]/div[2]/div[1]/div/div[1]/div[1]/div[1]/input   chair
    wait until element is visible    //*[@data-suggestion-productid="OFMA013815"]
    click element      //*[@data-suggestion-productid="OFMA013815"]
    wait until element is visible     //*[@id="product-page"]/div[2]/div/div[1]/div[1]/div[3]
    Close promotion image popup at Product page
    page should contain     พนักพิงขึ้นโครงพลาสติก หุ้มด้วยตาข่าย (Mesh) อย่างดี
    capture page screenshot

UI04 Validate search not found when input special charaters
    [Documentation]   Validate search not found when input special charaters eg.#$%^.
    Go to   https://www.officemate.co.th/en
    Close promotion image popup at Homepage
    Input text    //*[@id="app"]/div[2]/div[1]/div/div[1]/div[1]/div[1]/input   \#$%
    click element      //*[@id="btn-searchResultPage"]
    wait until element is visible     //*[@id="pnl-listPageNotFound"]
    page should contain   ขออภัย! ไม่พบสินค้าที่ตรงกับ
    capture page screenshot

UI05 Validate search result has pagination
    [Documentation]   Validate search result has pagination
    Go to   https://www.officemate.co.th/en
    Close promotion image popup at Homepage
    Input text    //*[@id="app"]/div[2]/div[1]/div/div[1]/div[1]/div[1]/input   water
    click element      //*[@id="btn-searchResultPage"]
    wait until element is not visible     //div[text()="loading"]
    sleep    5
    run keyword and ignore error     scroll element into view      //*[@id="app"]/div/div[4]/div/div[3]/div/div/div/div[2]/div[3]/div
    element should be visible     //*[@id="app"]/div/div[4]/div/div[3]/div/div/div/div[2]/div[3]/div
    capture page screenshot

