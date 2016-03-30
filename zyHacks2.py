from selenium import webdriver


browser = webdriver.Firefox()

f = open('answers.txt','w')


#Just making it easier to find elements by their displayed text
def find_elements_by_text(piece, text):
    textToFind = "//*[contains(text(), '%s')]" % (text)
    elements = piece.find_elements_by_xpath(textToFind)
    elements = filterVisibles(elements)
    return elements
def find_element_by_text(piece, text):
    textToFind = "//*[contains(text(), '%s')]" % (text)
    element = piece.find_element_by_xpath(textToFind)
    elements = filterVisibles(elements)
    return element


#If we've reached a 404 page, then we're done
def done():
    if ('40.4 Page not found' in browser.page_source):
        browser.get('https://zybooks.zyante.com/#/zybook/UtahMEEN1010Spring2016/dashboard')
        return True
    else:
        return False

def getUrl(chapter,sectionNum):
    url = 'https://zybooks.zyante.com/#/zybook/UtahMEEN1010Spring2016/chapter/%d/section/%d/' % (chapter,sectionNum)
    return url


def waitForLoading(loggedIn):
    #wait for webpage to be ready
    print "Loading webpage...."
    doneWaiting = False
    counter = 0
    if (loggedIn):
        while (not doneWaiting):
            counter +=1
            try:
                doneWaiting = browser.find_element_by_css_selector('div.activity-banner')
            except:
                pass
    print "done loading"

def login():
    #Save your sensitive information in a seperate folder
    #First line:<username> 
    #Second line:<password> 
    #That's it.
    f = open('credentials.txt','r')
    creds = f.readlines()
    email = creds[0][0:-1] #whole line except newline character
    password = creds[1]
    f.close()
    
    try:
        print "Trying"
        loginInfo = '{0}\t{1}'.format(email,password)
        browser.find_element_by_id('ember921').send_keys(loginInfo)
        signIn = browser.find_element_by_id('ember937')
        signIn.click()
        return True
        #browser.find_by_id
    except:
        print "Login 3 failed"
        pass
    return False



def removeRepeats(listWithRepeats):
    #Not really sure if this works
    withoutRepeats = -1

    for element in listWithRepeats:
        if element.text == browser.find_element_by_xpath('//table/tbody/*/td[2]/div[2]').first.text:
            listWithRepeats.remove(element)


    withoutRepeats = listWithRepeats
    return withoutRepeats

def filterVisibles(fullList):
    visibleList = []
    for elem in fullList:
        if elem.is_displayed():
            visibleList.append(elem)

    return visibleList

def findTextEdits():

    textEdits = browser.find_elements_by_tag_name('textarea')
    textEdits = filterVisibles(textEdits)
  
    print "textEdits length = ",len(textEdits)
    return textEdits


def clickButtons():

    print "Searching for show answer....."
    showButtons = find_elements_by_text(browser,'Show answer')
    print "found"

    print "showButtons length = ",len(showButtons)

    print "Clicking show answers...."
    for button in showButtons:
        button.click()
        button.click()

def findAnswers():
    answers = browser.find_elements_by_css_selector('div.question-answer')
    answers = filterVisibles(answers)
    return answers





#Filling out webpage
def showAndGet():
    clickButtons()
    
    #find answers from clicking show answer
    

    posAnswers = browser.find_elements_by_xpath('//td[2]/div/table/tbody/tr[1]/td[2]')
    answers = findAnswers()
    print "len answers = ", len(answers)

    #html location with textarea s
    textEdits = findTextEdits()

    #put answers to webpage and save them locally for debugging
    for i in range(len(textEdits)):
        print answers[i].text
        f.write(str(answers[i].text)+"\n")
        answer = str(answers[i].text)

        textEdits[i].send_keys(answer)

    checks = find_elements_by_text(browser,'Check')
    checks = filterVisibles(checks)
    for check in checks:
        check.click()


def justClickRun():
    #fixme these are coming up empty
    runButtons = find_elements_by_text(browser,'Run')
    # print "len run buttons = ",len(runButtons)
    for button in runButtons:
        if (button.is_displayed()):
            button.click()

    runCodeButtons = find_elements_by_text(browser,'Run code')
    # print "len runcode buttons = ",len(runCodeButtons)
    for button in runCodeButtons:
        if (button.is_displayed()):
            button.click()

    startButtons = find_elements_by_text(browser,'Start')
    # print "len start buttons = ",len(startButtons)
    for button in startButtons:
        if (button.is_displayed()):
            button.click()

    #TODO make it handle the pointer arrow activities like in this one

    # https://zybooks.zyante.com/#/zybook/UtahMEEN1010Spring2016/chapter/17/section/3/resource/3650468
            # <div id="playButton_3650568" class="playButton" 
            # style="opacity: 1; display: block; z-index: 29; transform: rotate(180deg); 
            # margin-left: 8px;"></div>


def optionalChoice():

    stateButtons = browser.find_elements_by_css_selector('div.ember-view.question-choice.button-unselected')
    stateButtons = filterVisibles(stateButtons)

    for button in stateButtons:
        button.click()


    optionButtons = browser.find_elements_by_css_selector('div.ember-view.detect-answer-choice-button.button-unselected')
    optionButtons = filterVisibles(optionButtons)
    
    for button in optionButtons:
        button.click()





def doChapter(chapter):
    url = getUrl(chapter,1)
    browser.get(url)

    loggedIn = login()
    if (not loggedIn):
        print "Log in falied"
        return False

    sectionNum = 1
    #Roll through sections until you reach a bad page
    while (not done()):
        url = getUrl(chapter,sectionNum)
        browser.get(url)

        waitForLoading(loggedIn)

        showAndGet()
        justClickRun()
        optionalChoice()
        #TODO add a drag and drop
        #TODO add a pointer arrow one

        sectionNum+=1
        print sectionNum





#Running Section

chapNum = input("What chapter? ")
doChapter(chapNum)






f.close()
raw_input("End: ");
browser.quit()






















