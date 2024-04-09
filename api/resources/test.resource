*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    OperatingSystem
Library    String

Resource    ../resources/base.resource

*** Keywords ***
Create a board
    Create Session    alias=trello    url=https://api.trello.com
    ${responseCB}    POST On Session    alias=trello    url=/1/boards/?name=myBoard1&key=${KEY}&token=${TOKEN}     expected_status=200     
    ${board_id}    Set Variable    ${responseCB.json()['id']}
    Create File    api/fixtures/testdata.json	{"board_id":"${board_id}"} 

Delete a board
    ${data}    Load Json From File    api/fixtures/testdata.json
    ${board_id_ob}    Get Value From Json    ${data}    $.board_id
    ${board_id_str}    Convert JSON To String	${board_id_ob}
    ${board_id}    Remove String    ${board_id_str}    [    ]    '    "       
    Delete On Session    alias=trello    url=/1/boards/${board_id}?key=${KEY}&token=${TOKEN}     expected_status=200  

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

Create board and list
    Create a board
    Create a list 
    # test setup and test tear down can carry only one key work, só we create a keywork that can carry multiple keywords for that
      
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
    ${data}    Load Json From File    api/fixtures/testdata.json
    ${card_id_ob}    Get Value From Json    ${data}    $.card_id
    ${card_id_str}    Convert JSON To String	${card_id_ob}
    ${card_id}    Remove String    ${card_id_str}    [    ]    '    "  
    Delete On Session    alias=trello    url=/1/cards/${card_id}?key=${KEY}&token=${TOKEN}     expected_status=200

Create board, list and card
    Create a board
    Create a list
    Create a card

Delete card and board
    Delete a card
    Delete a board

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
    ${responseCCH}    POST On Session    alias=trello    url=/1/checklists?idCard=${card_id}&key=${KEY}&token=${TOKEN}    data={name: "myChecklist"}    expected_status=200     
    ${checklist_id}    Set Variable    ${responseCCH.json()['id']}
    Log To Console    ${checklist_id}       
    Create File    api/fixtures/testdata.json	{"board_id":"${board_id}","list_id":"${list_id}","card_id":"${card_id}","checklist_id":"${checklist_id}"} 

Delete a checklist
    ${data}    Load Json From File    api/fixtures/testdata.json
    ${checklist_id_ob}    Get Value From Json    ${data}    $.checklist_id
    ${checklist_id_str}    Convert JSON To String	${checklist_id_ob}
    ${checklist_id}    Remove String    ${checklist_id_str}    [    ]    '    "     
    Delete On Session    alias=trello    url=/1/checklists/${checklist_id}?key=${KEY}&token=${TOKEN}     expected_status=200