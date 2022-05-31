*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Keywords ***


*** Test Cases ***
API01 Validate response code 200 and found similar product
    [Documentation]  Found numbers of similar product
    create session     dummy    https://www.officemate.co.th/
    &{header}    create dictionary       Content-Type=application/json    x-store-code=en
    ${params}   create dictionary
    ...  searchQuery=water
    ...  limit=45
    ...  page=1
    ...  store_id=3
    ...  x_subject_id=xxxx
    ...  price_range=1
    ...  visibility=1
    ${resp}   get request    dummy     api/search/products    headers=&{header}   params=${params}
    status should be    200   ${resp}
    should not be equal as integers    ${resp.json()}[products][total_count]    0

API02 Validate param searchQuery can be empty
    [Documentation]  Test param searchQuery can be empty
    create session     dummy    https://www.officemate.co.th/
    &{header}    create dictionary       Content-Type=application/json    x-store-code=en
    ${params}   create dictionary
    ...  searchQuery=""
    ...  limit=45
    ...  page=1
    ...  store_id=3
    ...  x_subject_id=xxxx
    ...  price_range=1
    ...  visibility=1
    ${resp}   get request    dummy     api/search/products    headers=&{header}   params=${params}
    status should be    200   ${resp}
    should be equal as integers    ${resp.json()}[products][total_count]    0

API03 Validate response code 404 limit param can not be empty
    [Documentation]    Test limit param can not be empty
    create session     dummy    https://www.officemate.co.th/
    &{header}    create dictionary       Content-Type=application/json    x-store-code=en
    ${params}   create dictionary
    ...  searchQuery=water
    ...  limit=""
    ...  page=1
    ...  store_id=3
    ...  x_subject_id=xxxx
    ...  price_range=1
    ...  visibility=1
    ${resp}   get request    dummy     api/search/products    headers=&{header}   params=${params}
    status should be    404   ${resp}

API04 Validate response code 404 page param can not be empty
    [Documentation]  Test page param can not be empty
    create session     dummy    https://www.officemate.co.th/
    &{header}    create dictionary       Content-Type=application/json    x-store-code=en
    ${params}   create dictionary
    ...  searchQuery=xxxx
    ...  limit=45
    ...  page=""
    ...  store_id=3
    ...  x_subject_id=xxxx
    ...  price_range=1
    ...  visibility=1
    ${resp}   get request    dummy     api/search/products    headers=&{header}   params=${params}
    status should be    404   ${resp}

API05 Validate store_id,x_subject_id,price_range params are not required parameter
    [Documentation]  Test store_id,x_subject_id,price_range params are not required parameter
    create session     dummy    https://www.officemate.co.th/
    &{header}    create dictionary       Content-Type=application/json    x-store-code=en
    ${params}   create dictionary
    ...  searchQuery=xxxx
    ...  limit=45
    ...  page=1
    ...  visibility=1
    ${resp}   get request    dummy     api/search/products    headers=&{header}   params=${params}
    status should be    200   ${resp}

API06 Validate response code 404 visibility param can not be empty
    [Documentation]  Test visibility param can not be empty
    create session     dummy    https://www.officemate.co.th/
    &{header}    create dictionary       Content-Type=application/json    x-store-code=en
    ${params}   create dictionary
    ...  searchQuery=xxxx
    ...  limit=45
    ...  page=""
    ...  store_id=3
    ...  x_subject_id=xxxx
    ...  price_range=1
    ...  visibility=""
    ${resp}   get request    dummy     api/search/products    headers=&{header}   params=${params}
    status should be    404   ${resp}

API07 Validate response code 404 searchQuery param is required
    [Documentation]  Test searchQuery param is required
    create session     dummy    https://www.officemate.co.th/
    &{header}    create dictionary       Content-Type=application/json    x-store-code=en
    ${params}   create dictionary
#    ...  searchQuery=xxxx
    ...  limit=45
    ...  page=""
    ...  store_id=3
    ...  x_subject_id=xxxx
    ...  price_range=1
    ...  visibility=""
    ${resp}   get request    dummy     api/search/products    headers=&{header}   params=${params}
    status should be    404   ${resp}
