*** Settings ***
Resource    ../resources/test.resource
Library    RequestsLibrary
Library    JSONLibrary
Library    OperatingSystem
Library    String

Resource    ../resources/base.resource

*** Test Cases ***

Create a board 
    Create Session    alias=trello    url=https://api.trello.com
    ${responseCB}    POST On Session    alias=trello    url=/1/boards/?name=myBoard1&key=${AUTH.KEY}&token=${AUTH.TOKEN}    expected_status=200     
    ${board_id}    Set Variable    ${responseCB.json()['id']}
    Log To Console    ${board_id}       
    Create File    api/fixtures/testdata.json	{"board_id":"${board_id}"} 

    Delete a board

Get a board 
    Create a board

    ${data}    Load Json From File    api/fixtures/testdata.json
    ${board_id_ob}    Get Value From Json    ${data}    $.board_id
    ${board_id_str}    Convert JSON To String	${board_id_ob}
    ${board_id}    Remove String    ${board_id_str}    [    ]    '    "      
    Create Session    alias=trello    url=https://api.trello.com
    ${responseGB}    GET On Session    alias=trello    url=/1/boards/${board_id}?key=${AUTH.KEY}&token=${AUTH.TOKEN}   expected_status=200     
    ${board_id}    Set Variable    ${responseGB.json()['id']}
    Log To Console    ${board_id}    

    Delete a board

Update a board - name
    Create a board

    ${data}    Load Json From File    api/fixtures/testdata.json
    ${board_id_ob}    Get Value From Json    ${data}    $.board_id
    ${board_id_str}    Convert JSON To String	${board_id_ob}
    ${board_id}    Remove String    ${board_id_str}    [    ]    '    "      
    Create Session    alias=trello    url=https://api.trello.com
    ${responseUB}    PUT On Session    alias=trello    url=/1/boards/${board_id}?key=${AUTH.KEY}&token=${AUTH.TOKEN}    data={name: "myBoard2"}   expected_status=200     
    ${board_name}    Set Variable    ${responseUB.json()['name']}
    Log To Console    ${board_name}    

    Delete a board

Delete a board 
    Create a board    

    ${data}    Load Json From File    api/fixtures/testdata.json
    ${board_id_ob}    Get Value From Json    ${data}    $.board_id
    ${board_id_str}    Convert JSON To String	${board_id_ob}
    ${board_id}    Remove String    ${board_id_str}    [    ]    '    "       
    Delete On Session    alias=trello    url=/1/boards/${board_id}?key=${AUTH.KEY}&token=${AUTH.TOKEN}     expected_status=200      
    #I had som commit problems regarding tracking os files that weren't supposed to be tracked. 
    # So I only accomplished commiting those files by getting rid of the repo and commiting in a new one. 
    # Because of that I lost commiting history.
    # But commits followed same steps as my other projects (make work, fixtures, custom commands, hooks, env variables and final).