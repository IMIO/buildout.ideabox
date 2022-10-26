CHANGELOG
=========

5.2.8-quick-1 (2022-10-26)
--------------------------

- Update waitress to 2.1.2 to try to remove 100% CPU consumption.
  [bsuttor]


5.2.3-10 (2022-10-25)
---------------------

- Update rundeck job ids.
  [bsuttor]

- Use ubuntu as Docker base image instead of Alpine.
  [bsuttor]

- Add py-spy to debug python process.
  [bsuttor]


5.2.3-9 (2022-10-19)
--------------------

- ideabox.policy 3.4.14

  - Fix project, explorer faceted and tests
    [boulch]


5.2.3-8 (2022-10-11)
--------------------

- ideabox.policy 3.4.13

  - SUP-24435: Fix random sort
    [mpeeters]

- Update Plone from 5.2.5 to 5.2.8
  [boulch]

- ideabox.policy 3.4.12

  - Fix image display in projects template
    [boulch]

  - Add ts_project_submission_path field on campaign to specify an off site project form by campaign
    [boulch]


5.2.3-7 (2022-06-14)
--------------------

- ideabox.policy 3.4.11
  
  - Add missing interface to geolocating projects
    [boulch]

- ideabox.policy 3.4.10

  - if ts_project_submission_path is not None, we redirect to this form instead of ideabox citizen default form.
    [boulch]

  - Add new field in control panel : ts_project_submission_path. This is a path to an external e-guichet project form.
    [boulch]

  - Update translations (faceted view name)
    [boulch]

  - Change faceted view name (from "Explorer" to "Projects with a map")
    [boulch]

  - Fix "us" separator (come from taxonomies) that was displaying in district and theme endpoints.
    [boulch]

- plone.formwidget.geolocation 2.2.4

  - Add French translations
    [laulaz]

  - Add plone.restapi deserializer (if plone.restapi is installed).
    [laulaz]

  - Allow to set default geolocation on new contents (via bool field in config).
    If not checked, the defaut geolocation is only used to center map.
    Also, the geolocation map will not show on an object if no geolocation was defined.
    [laulaz]

- ideabox.policy 3.4.9

  - Add endpoints to get projects themes and projects districts
    [boulch]

  - Refactor default_image project and take project leadimage in consideration
    [boulch]

  - Add map and coordinates in project template
    [boulch]

- ideabox.policy 3.4.8

  - Add new geolocated faceted view
    [boulch]

  - Add geolocation field to project content type
    [boulch]

  - Move project_image (leadimage) to project content type
    [boulch]

- Adapt code to sort priority action progress by latest to oldest elements
  [mpeeters]

- ideabox.policy 3.4.7

  - Fix js error : Uncaught ReferenceError: ploneFormTabbing is not defined
    [boulch]

  - Avoid a double translation for localized month
    [mpeeters]

  - auto-install imio.gdpr , collective.excelexport
    [boulch]


5.2.3-6 (2022-03-16)
--------------------

- ideabox.policy 3.4.6

  - Fix bad include instruction
    [boulch]

- ideabox.policy 3.4.5

  - Add collective.big.bang dependency
    [boulch]

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
