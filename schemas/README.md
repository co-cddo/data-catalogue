# Data Catalogue Model Implementation

This directory captures the implementation of the [Government Data Catalogue model](https://docs.google.com/document/d/13KqG1Zom0YqCehPHagCnV6ADOwj8k6qcv7Us4UDWnNg/).

The implementation is as JSON Schema files to capture the expected form of the JSON files. There is the option to convert into linked data by using linking in the [context file](cddo-context.json).

## Organisation

We maintain a collection of the organisations that have supplied data in [`organisations.json`](examples/organisations.json). The organisations are identified using a `slug` which is also used in the [Collections API](https://docs.publishing.service.gov.uk/repos/collections/api.html). A JSON record for an organisation can be retrieved by prepending the `slug` with `https://www.gov.uk/api/organisations/`, while a human readable page can be accessed with `https://www.gov.uk/government/organisations/`.

> __Note:__ In the future it may be desirable to develop a script of harvest the data associated with an organisation from the Collections API. Such a script could use the titles of `superseded_organisations` to populate the `alternativeTitle` field.

For the JSON Schema validation, a list of valid `slugs` is enumerated in [`available-organisations.json`](available-organisations.json). This list needs to be manually maintained with organisations added manually.

> __Note:__ In the future, a script could be used to populate the enumeration with the values from the organisations file.