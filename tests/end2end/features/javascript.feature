Feature: Javascript stuff

    Integration with javascript.

    Scenario: Using console.log
        When I set general -> log-javascript-console to debug
        And I open data/javascript/consolelog.html
        Then the javascript message "console.log works!" should be logged

    # https://github.com/The-Compiler/qutebrowser/issues/906

    @qtwebengine_skip
    Scenario: Closing a JS window twice (issue 906) - qtwebkit
        When I open about:blank
        And I open data/javascript/issue906.html in a new tab
        And I run :click-element id open-button
        And I wait for "Changing title for idx 2 to 'about:blank'" in the log
        And I run :tab-focus 2
        And I run :click-element id close-button
        Then "Requested to close * which does not exist!" should be logged

    @qtwebkit_skip
    @qtwebengine_createWindow
    Scenario: Closing a JS window twice (issue 906) - qtwebengine
        When I open about:blank
        And I open data/javascript/issue906.html in a new tab
        And I run :click-element id open-button
        And I wait for "WebDialog requested, but we don't support that!" in the log
        And I wait for "Changing title for idx 2 to 'about:blank'" in the log
        And I run :tab-focus 2
        And I run :click-element id close-button
        And I wait for "Focus object changed: *" in the log
        Then no crash should happen
