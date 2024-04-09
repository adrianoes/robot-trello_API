*** Settings ***
Resource    ../resources/test.resource
Library    RequestsLibrary
Library    JSONLibrary
Library    OperatingSystem
Library    String

Resource    ../resources/base.resource

Test Setup    Create board and list 
Test Teardown    Delete a board

*** Test Cases ***

Create a card
    ${data}    Load Json From File    api/fixtures/testdata.json
    ${board_id_ob}    Get Value From Json    ${data}    $.board_id
    ${list_id_ob}    Get Value From Json    ${data}    $.list_id
    ${board_id_str}    Convert JSON To String	${board_id_ob}
    ${list_id_str}    Convert JSON To String	${list_id_ob}
    ${board_id}    Remove String    ${board_id_str}    [    ]    '    " 
    ${list_id}    Remove String    ${list_id_str}    [    ]    '    " 
    Create Session    alias=trello    url=https://api.trello.com
    ${responseCC}    POST On Session    alias=trello    url=/1/cards?idList=${list_id}&key=${KEY}&token=${TOKEN}    data={name: "myCard123"}    expected_status=200     
    ${card_id}    Set Variable    ${responseCC.json()['id']}
    Log To Console    ${card_id}       
    Create File    api/fixtures/testdata.json	{"board_id":"${board_id}","list_id":"${list_id}","card_id":"${card_id}"} 

    Delete a card   

Get a card 
    Create a card

    ${data}    Load Json From File    api/fixtures/testdata.json
    ${card_id_ob}    Get Value From Json    ${data}    $.card_id
    ${card_id_str}    Convert JSON To String	${card_id_ob}
    ${card_id}    Remove String    ${card_id_str}    [    ]    '    "     
    Create Session    alias=trello    url=https://api.trello.com
    ${responseGC}    GET On Session    alias=trello    url=/1/cards/${card_id}?key=${KEY}&token=${TOKEN}   expected_status=200     
    ${card_id}    Set Variable    ${responseGC.json()['id']}
    Log To Console    ${card_id}     

    Delete a card      

Update a card - name
    Create a card

    ${data}    Load Json From File    api/fixtures/testdata.json
    ${card_id_ob}    Get Value From Json    ${data}    $.card_id
    ${card_id_str}    Convert JSON To String	${card_id_ob}
    ${card_id}    Remove String    ${card_id_str}    [    ]    '    "     
    Create Session    alias=trello    url=https://api.trello.com
    ${responseUC}    PUT On Session    alias=trello    url=/1/cards/${card_id}?key=${KEY}&token=${TOKEN}    data={name: "myCard2"}   expected_status=200     
    ${card_name}    Set Variable    ${responseUC.json()['name']}
    Log To Console    ${card_name}  

    Delete a card    

Delete a card
    Create a card 

    ${data}    Load Json From File    api/fixtures/testdata.json
    ${card_id_ob}    Get Value From Json    ${data}    $.card_id
    ${card_id_str}    Convert JSON To String	${card_id_ob}
    ${card_id}    Remove String    ${card_id_str}    [    ]    '    "     
    Delete On Session    alias=trello    url=/1/cards/${card_id}?key=${KEY}&token=${TOKEN}     expected_status=200