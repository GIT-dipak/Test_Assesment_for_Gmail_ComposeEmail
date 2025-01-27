 
Feature: Gmail Compose and Email Validation

  As a Gmail user

  I want to compose and send emails seamlessly

  So that I can ensure correct functionality across web and mobile platforms

   

  # Email Composition Scenarios

   

  @web @mobile

  Scenario Outline: Compose and send an email with valid inputs

    Given I am logged into Gmail on "<platform>"

    When I click the "Compose" button

    And I enter "<to>" as the recipient

    And I enter "<subject>" in the subject field

    And I enter "<body>" in the body field

    And I click "Send"

    Then the email should be sent successfully

    And it should appear in the "Sent" folder

    Examples:

      | platform | to                   | subject   | body                        |

      | web      | test1@example.com    | Incubyte  | QA test for Incubyte        |

      | mobile   | test2@example.com    | Testing   | This is a sample email body |

  @web

  Scenario: Compose and send an email without a subject

    Given I am logged into Gmail on a web browser

    When I click the "Compose" button

    And I enter "test@example.com" as the recipient

    And I leave the subject field empty

    And I enter "QA test for Incubyte" in the body field

    And I click "Send"

    Then Gmail should display a warning about sending an email without a subject

    And the email should be sent successfully after confirmation

   

  # Email Validation Scenarios

   

  @web @mobile

  Scenario: Validate that sent email appears in the Sent folder

    Given I have sent an email successfully

    When I navigate to the "Sent" folder

    Then I should see the sent email with the correct recipient, subject, and body

  @web @mobile

  Scenario Outline: Validate that an unsent email is saved in the Draft folder

    Given I am composing an email on "<platform>"

    When I close the compose window without clicking "Send"

    Then the email should be saved in the "Drafts" folder

    And I should be able to resume editing the draft

    Examples:

      | platform |

      | web      |

      | mobile   |

   

  # Email Sending Edge Cases

   

  @web @mobile

  Scenario Outline: Validate behavior when sending fails due to connectivity

    Given I am composing an email on "<platform>"

    When the network disconnects while sending the email

    Then the email should not appear in the "Sent" folder

    And the email should be saved in the "Outbox"

    And Gmail should attempt to resend the email when the network reconnects

    Examples:

      | platform |

      | web      |

      | mobile   |

  @web @mobile

  Scenario: Verify email appears in Outbox if the recipient domain is invalid

    Given I am composing an email on "<platform>"

    And I enter "user@invalid-domain" as the recipient

    When I click "Send"

    Then the email should move to the "Outbox" folder

    And Gmail should notify me about the delivery failure

   

  # Multi-Recipient Scenarios

   

  @web @mobile

  Scenario Outline: Send an email with multiple recipients

    Given I am logged into Gmail on "<platform>"

    When I click the "Compose" button

    And I enter "<to>" as recipients in the "To" field

    And I add "<cc>" in the "CC" field

    And I add "<bcc>" in the "BCC" field

    And I enter "<subject>" in the subject field

    And I enter "<body>" in the body field

    And I click "Send"

    Then the email should be sent successfully to all recipients

    Examples:

      | platform | to                               | cc           | bcc         | subject       | body                        |

      | web      | test1@example.com,test2@xyz.com | cc1@mail.com | bcc1@mail.com | Incubyte Test | Testing email functionality |

      | mobile   | user1@abc.com,user2@xyz.com     | cc2@mail.com | bcc2@mail.com | Mobile Test   | Compose feature on mobile   |



  # Attachment Scenarios



  @web @mobile

  Scenario Outline: Attach a file within the size limit

    Given I am composing an email on "<platform>"

    When I attach a file of size "<fileSize>"

    Then the file should be successfully attached to the email

    Examples:

      | platform | fileSize |

      | web      | 10MB     |

      | mobile   | 15MB     |

  @web @mobile

  Scenario Outline: Attach a file larger than 25MB

    Given I am composing an email on "<platform>"

    When I attach a file larger than 25MB

    And I click "Send"

    Then Gmail should prompt me to use Google Drive for the attachment

    And the file should be shared as a Drive link in the email

    Examples:

      | platform |

      | web      |

      | mobile   |



  # Mobile-Specific Scenarios


  @mobile

  Scenario: Resume a draft after app crash

    Given I am composing an email in the Gmail mobile app

    When the app crashes unexpectedly

    And I reopen the Gmail app

    Then the email draft should be saved

    And I should be able to resume composing the email

  @mobile

  Scenario: Attach multiple files up to the maximum limit

    Given I am composing an email in the Gmail mobile app

    When I attach the maximum number of files allowed (25 files)

    Then the email should allow all files within the size limit

    And the email should be sent successfully

  @mobile

  Scenario Outline: Switch accounts while composing an email

    Given I am composing an email in the Gmail mobile app

    When I switch to a different account

    And I continue editing the email

    And I tap "Send"

    Then the email should be sent successfully from the selected account

    Examples:

      | accountSwitch |

      | account1       |

      | account2       |

   

  # Miscellaneous Scenarios

   

  @web @mobile

  Scenario Outline: Validate timestamp of a sent email

    Given I have sent an email successfully on "<platform>"

    When I navigate to the "Sent" folder

    Then the email should display the correct timestamp of when it was sent

    Examples:

      | platform |

      | web      |

      | mobile   |

  @web @mobile

  Scenario Outline: Send an email with voice-to-text input in the body

    Given I am composing an email on "<platform>"

    When I use the voice-to-text feature to input the email body

    Then the text should be recognized and entered correctly

    And the email should be sent successfully

    Examples:

      | platform |

      | mobile   | 