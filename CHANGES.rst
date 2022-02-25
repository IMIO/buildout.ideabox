CHANGELOG
=========

5.2.3-6 (unreleased)
--------------------

- ideabox.policy 3.4.4

  - Add package : collective.anonymouseditpatterns. 
    Fix some widgets In our case, fix datetime picker in @@register form (in anonymous mode)
    [boulch]


5.2.3-5 (2021-09-03)
--------------------

- ideabox.theme 1.0.1

  - Add diazo rules to remove dashboard and preferences out of membertools menu
    [boulch]

  - Simplify config for TTW LESS edition
    [laulaz]


5.2.3-4 (2021-06-28)
--------------------

- ideabox.policy 3.4.3

  - Update faceted xml configuration. Add a workflow "draft" filter on projects. (Don't keep projects in draft state)
    [boulch]
  - Add a project_directly_submitted checkbox field in ideabox controlpanel to choice is project can be directly submitted
    [boulch]
  - Add campaign_emails field on campaign type to send mails only on to these campaign managers
    [boulch]

- Add new product : collective.easyform (3.0.5) in buildout.
  [boulch]


5.2.3-3 (2021-06-10)
--------------------

- imio.gdpr 1.1.1

  - Fix unicode error in Plone52 
    [boulch]

- ideabox.policy 3.4.2
  
  - Change "zip_code" field label to "zip code / locality" in user registration form. 
    [boulch]
  - Create legal_information_text field in control panel
    [boulch]



5.2.3-2 (2021-02-16)
--------------------

- ideabox.restapi 1.0b3

    - Update french translations
      [mpeeters]


5.2.3-1 (2021-02-04)
--------------------

- ideabox.policy 3.4.0

    - Add REST API specific viewlets on prioity action template
      [mpeeters]
    - Change two taxonomies title (locality, district)
      [boulch]
    - undo description for "birthdate" field in registration form (calendar widget up again)
      [boulch]
    - Fix typo in js compilation filename
      [mpeeters]
    - Add description for "birthdate" field in registration form
    - [SUP-14825] Add description for "birthdate" field in registration form
      [boulch]
    - Add some translations
      [boulch]
