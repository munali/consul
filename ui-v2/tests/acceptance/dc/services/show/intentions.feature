@setupApplicationTest
Feature: dc / services / show / intentions: Intentions per service
  Background:
    Given 1 datacenter model with the value "dc1"
    And 1 node models
    And 1 service model from yaml
    ---
    - Service:
        Kind: ~
        Name: service-0
        ID: service-0-with-id
    ---
    And 3 intention models from yaml
    ---
    - ID: 755b72bd-f5ab-4c92-90cc-bed0e7d8e9f0
      Action: allow
      Meta: ~
      SourceNS: default
      SourceName: name
      DestinationNS: default
      DestinationName: destination

    - ID: 755b72bd-f5ab-4c92-90cc-bed0e7d8e9f1
      Action: deny
      Meta: ~
    - ID: 0755b72bd-f5ab-4c92-90cc-bed0e7d8e9f2
      Action: deny
      Meta: ~
    ---
    When I visit the service page for yaml
    ---
      dc: dc1
      service: service-0
    ---
    And the title should be "service-0 - Consul"
    And I see intentions on the tabs
    When I click intentions on the tabs
    And I see intentionsIsSelected on the tabs
  Scenario: I can see intentions
    And I see 3 intention models
  Scenario: I can delete intentions
    And I click actions on the intentions
    And I click delete on the intentions
    And I click confirmDelete on the intentions
    Then a DELETE request was made to "/v1/connect/intentions/exact?source=default%2Fname&destination=default%2Fdestination&dc=dc1"
    And "[data-notification]" has the "notification-delete" class
    And "[data-notification]" has the "success" class
