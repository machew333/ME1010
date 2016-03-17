from selenium import webdriver


browser = webdriver.Firefox()

f = open('answers.txt','w')


#Just making it easier to find elements by their displayed text
def find_elements_by_text(browser, text):
    textToFind = "//*[contains(text(), '%s')]" % (text)
    browser.find_elements_by_xpath(textToFind)
def find_element_by_text(browser, text):
    textToFind = "//*[contains(text(), '%s')]" % (text)
    browser.find_elements_by_xpath(textToFind)


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


def waitForLoading():
    #wait for webpage to be ready
    print "Loading webpage...."
    doneWaiting = False
    while (not doneWaiting):
        doneWaiting = find_element_by_text(browser, 'Participation Activity')
        pass
    print "done loading"


def doChapter(chapter):
    url = getUrl(chapter,1)
    browser.get(url)
    login()

    sectionNum = 3
    while (not done()):
        url = getUrl(chapter,sectionNum)
        browser.get(url)

        waitForLoading()

        showAndGet()
        justClickRun()
        trueAndFalse()
        

        sectionNum+=1
        print sectionNum


def login():
    email = 'u0499184@utah.edu'
    password = 'Mbw992994'
    try:
        loginInfo = '{0}\t{1}'.format(email,password)
        browser.find_element_by_id('ember922').first.fill(loginInfo)
        browser.find_element_by_link_text('Sign in').click()

        #browser.find_by_id
    except:
        pass
    try:
        loginInfo = '{0}\t{1}'.format(email,password)
        first = browser.find_element_by_id('ember923')[0]
        first.send_keys(loginInfo)
        browser.find_element_by_link_text('Sign in').click()

        #browser.find_by_id
    except:
        pass

def removeRepeats(listWithRepeats):
    #Not really sure if this works
    withoutRepeats = -1

    for element in listWithRepeats:
        if element.value == browser.find_element_by_xpath('//table/tbody/*/td[2]/div[2]').first.value:
            listWithRepeats.remove(element)


    withoutRepeats = listWithRepeats
    return withoutRepeats

def findTextEdits():
    #Some slots randomly have different xpaths,
    #so this gets both possible ones that I know of.
    slots = browser.find_elements_by_xpath('//table/tbody/*/td[3]/div[2]')
    slotsExtra = browser.find_elements_by_xpath('//table/tbody/*/td[3]/div[1]')
    slots.extend(slotsExtra)


    print "slot LEN = ",len(slots)

    textEdits = []
    for slot in slots:
        edits = (slot.find_elements_by_tag('textarea'))


        if (isinstance(edits,list)):
            for edit in edits:
                textEdits.append(edit)
        else:
            print "probs not"
            textEdits.append(edits)

    print "textEdits length = ",len(textEdits)
    return textEdits


def clickButtons():

    print "Searching for show answer....."
    showButtons = browser.find_elements_by_text('Show answer')
    print "found"

    print "showButtons length = ",len(showButtons)

    print "Clicking show answers...."
    for button in showButtons:
        button.click()
        button.click()


#Filling out wedpage functions

def showAndGet():
    clickButtons()
    
    #find answers from clicking show answer
    

    posAnswers = browser.elements_by_xpath('//td[2]/div/table/tbody/tr[1]/td[2]')
    answers = []

    for pos in posAnswers:
        checkPresent = pos.find_elements_by_text('Check')
        print checkPresent
        if checkPresent:
            answers.append(pos)

    print "answers  =",len(answers)
    #answers = removeRepeats(answers)
    

    #html location with textarea s
    textEdits = findTextEdits()

    #put answers to webpage and save them locally for debugging
    for i in range(len(answers)):
        print answers[i].value
        f.write(str(answers[i].value)+"\n")
        textEdits[i].fill(str(answers[i].text))

    checks = find_elements_by_text(browser,'Check')
    for check in checks:
        check.click()


def justClickRun():
    runButtons = find_elements_by_text(browser,'Run')
    for button in runButtons:
        if (button.is_displayed()):
            button.click()

    runCodeButtons = find_elements_by_text(browser,'Run code')
    for button in runCodeButtons:
        if (button.is_displayed()):
            button.click()

    startButtons = find_elements_by_text(browser,'Start')
    for button in startButtons:
        if (button.is_displayed()):
            button.click()


def trueAndFalse():
    falseButtons = find_elements_by_text(browser, 'False')
    for button in falseButtons:
        button.click()

    trueButtons = find_elements_by_text(browser,'True')
    for button in trueButtons:
        button.click()

    whileButtons = find_elements_by_text(browser,'while')
    for button in whileButtons:
        button.click()


    forButtons = find_elements_by_text(browser,'for')
    for button in forButtons:
        button.click()





#Running Section


doChapter(17)



f.close()
raw_input("End boy:");
browser.quit()






















