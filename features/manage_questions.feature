Feature: Manage questions

  Scenario: Post new question
    Given a valid user
    When I put his login and correct password into the form
    Then I should be on the questions page
    Then I should see "Ask a question"
    When I follow "new_question"
    Then I should see "New question"
    Then I fill in "What took you so long using cucumber in SmartR?" for "question_name"
    Then I fill in "Microsoft pulls the plug on Kin  —  Microsoft has decided not to move forward with the Kin, a phone aimed at avid social-networking users.  —  Amid slow sales, Microsoft has decided to halt work on its Kin phone, focusing instead on its Windows Phone 7 effort, CNET has learned. Discussion: Digital Daily, Yahoo! News, ZDNet, BetaNews, VentureBeat, blogs.ft.com, The Register, Guardian, Macworld, Phone Arena, TechSpot, Gadgetell, DailyFinance, 9 to 5 Mac, Electronista, Tech Trader Daily, MobileBurn.com, The Huffington Post, Velocity, Black Web 2.0, Silicon Alley Insider and Microsoft News Tracker" for "wmd-input"
    Then I fill in "test, cucumber" for "question_tag_list"
    Then I press "question_submit"
    Then I should see "What took you so long using cucumber in SmartR"
#  # Rails generates Delete links that use Javascript to pop up a confirmation
#  # dialog and then do a HTTP POST request (emulated DELETE request).
#  #
#  # Capybara must use Culerity/Celerity or Selenium2 (webdriver) when pages rely
#  # on Javascript events. Only Culerity/Celerity supports clicking on confirmation
#  # dialogs.
#  #
#  # Since Culerity/Celerity and Selenium2 has some overhead, Cucumber-Rails will
#  # detect the presence of Javascript behind Delete links and issue a DELETE request 
#  # instead of a GET request.
#  #
#  # You can turn this emulation off by tagging your scenario with @no-js-emulation.
#  # Turning on browser testing with @selenium, @culerity, @celerity or @javascript
#  # will also turn off the emulation. (See the Capybara documentation for 
#  # details about those tags). If any of the browser tags are present, Cucumber-Rails
#  # will also turn off transactions and clean the database with DatabaseCleaner 
#  # after the scenario has finished. This is to prevent data from leaking into 
#  # the next scenario.
#  #
#  # Another way to avoid Cucumber-Rails' javascript emulation without using any
#  # of the tags above is to modify your views to use <button> instead. You can
#  # see how in http://github.com/jnicklas/capybara/issues#issue/12
#  #
#  Scenario: Delete question
#    Given the following questions:
#      ||
#      ||
#      ||
#      ||
#      ||
#    When I delete the 3rd question
#    Then I should see the following questions:
#      ||
#      ||
#      ||
#      ||
#