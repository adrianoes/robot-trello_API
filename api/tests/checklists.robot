*** Settings ***
Resource    ../resources/test.resource
Library    RequestsLibrary
Library    JSONLibrary
Library    OperatingSystem
Library    String

Resource    ../resources/base.resource

Test Setup    Create board, list and card
Test Teardown    Delete card and board

*** Test Cases ***

Create a checklist
    ${data}    Load Json From File    api/fixtures/testdata.json
    ${board_id_ob}    Get Value From Json    ${data}    $.board_id
    ${list_id_ob}    Get Value From Json    ${data}    $.list_id
    ${card_id_ob}    Get Value From Json    ${data}    $.card_id
    ${board_id_str}    Convert JSON To String	${board_id_ob}
    ${list_id_str}    Convert JSON To String	${list_id_ob}
    ${card_id_str}    Convert JSON To String	${card_id_ob}
    ${board_id}    Remove String    ${board_id_str}    [    ]    '    " 
    ${list_id}    Remove String    ${list_id_str}    [    ]    '    " 
    ${card_id}    Remove String    ${card_id_str}    [    ]    '    " 
    Create Session    alias=trello    url=https://api.trello.com
    ${responseCCH}    POST On Session    alias=trello    url=/1/checklists?idCard=${card_id}&key=${KEY}&token=${TOKEN}    data={name: "myChecklist123"}    expected_status=200     
    ${checklist_id}    Set Variable    ${responseCCH.json()['id']}
    Log To Console    ${checklist_id}       
    Create File    api/fixtures/testdata.json	{"board_id":"${board_id}","list_id":"${list_id}","card_id":"${card_id}","checklist_id":"${checklist_id}"} 

    Delete a checklist   

Get a checklist 
    Create a checklist

    ${data}    Load Json From File    api/fixtures/testdata.json
    ${checklist_id_ob}    Get Value From Json    ${data}    $.checklist_id
    ${checklist_id_str}    Convert JSON To String	${checklist_id_ob}
    ${checklist_id}    Remove String    ${checklist_id_str}    [    ]    '    "     
    Create Session    alias=trello    url=https://api.trello.com
    ${responseGCH}    GET On Session    alias=trello    url=/1/checklists/${checklist_id}?key=${KEY}&token=${TOKEN}   expected_status=200     
    ${checklist_id}    Set Variable    ${responseGCH.json()['id']}
    Log To Console    ${checklist_id}     

    Delete a checklist     

Update a checklist - name
    Create a checklist

    ${data}    Load Json From File    api/fixtures/testdata.json
    ${checklist_id_ob}    Get Value From Json    ${data}    $.checklist_id
    ${checklist_id_str}    Convert JSON To String	${checklist_id_ob}
    ${checklist_id}    Remove String    ${checklist_id_str}    [    ]    '    "     
    Create Session    alias=trello    url=https://api.trello.com
    ${responseUCH}    PUT On Session    alias=trello    url=/1/checklists/${checklist_id}?key=${KEY}&token=${TOKEN}    data={name: "myChecklist2"}   expected_status=200     
    ${checklist_name}    Set Variable    ${responseUCH.json()['name']}
    Log To Console    ${checklist_name} 

    Delete a checklist   

Delete a checklist
    Create a checklist

    ${data}    Load Json From File    api/fixtures/testdata.json
    ${checklist_id_ob}    Get Value From Json    ${data}    $.checklist_id
    ${checklist_id_str}    Convert JSON To String	${checklist_id_ob}
    ${checklist_id}    Remove String    ${checklist_id_str}    [    ]    '    "     
    Delete On Session    alias=trello    url=/1/checklists/${checklist_id}?key=${KEY}&token=${TOKEN}     expected_status=200