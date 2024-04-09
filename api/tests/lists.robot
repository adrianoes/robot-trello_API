*** Settings ***
Resource    ../resources/test.resource
Library    RequestsLibrary
Library    JSONLibrary
Library    OperatingSystem
Library    String

Resource    ../resources/base.resource

Test Setup    Create a board
Test Teardown    Delete a board

*** Test Cases ***

Create a list
    ${data}    Load Json From File    api/fixtures/testdata.json
    ${board_id_ob}    Get Value From Json    ${data}    $.board_id
    ${board_id_str}    Convert JSON To String	${board_id_ob}
    ${board_id}    Remove String    ${board_id_str}    [    ]    '    " 
    Create Session    alias=trello    url=https://api.trello.com
    ${responseCL}    POST On Session    alias=trello    url=/1/boards/${board_id}/lists?name=myList123&key=${KEY}&token=${TOKEN}    expected_status=200     
    ${list_id}    Set Variable    ${responseCL.json()['id']}
    Log To Console    ${list_id}       
    Create File    api/fixtures/testdata.json	{"board_id":"${board_id}","list_id":"${list_id}"} 

Get a list 
    Create a list

    ${data}    Load Json From File    api/fixtures/testdata.json
    ${list_id_ob}    Get Value From Json    ${data}    $.list_id
    ${list_id_str}    Convert JSON To String	${list_id_ob}
    ${list_id}    Remove String    ${list_id_str}    [    ]    '    "     
    Create Session    alias=trello    url=https://api.trello.com
    ${responseGL}    GET On Session    alias=trello    url=/1/lists/${list_id}?key=${KEY}&token=${TOKEN}   expected_status=200     
    ${list_id}    Set Variable    ${responseGL.json()['id']}
    Log To Console    ${list_id}        

Update a list - name
    Create a list

    ${data}    Load Json From File    api/fixtures/testdata.json
    ${list_id_ob}    Get Value From Json    ${data}    $.list_id
    ${list_id_str}    Convert JSON To String	${list_id_ob}
    ${list_id}    Remove String    ${list_id_str}    [    ]    '    "     
    Create Session    alias=trello    url=https://api.trello.com
    ${responseUL}    PUT On Session    alias=trello    url=/1/lists/${list_id}?key=${KEY}&token=${TOKEN}    data={name: "myList2"}   expected_status=200     
    ${list_name}    Set Variable    ${responseUL.json()['name']}
    Log To Console    ${list_name} 
    

