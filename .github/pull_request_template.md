**Jira Issue**: [Ticket-Number](https://jirautk.atlassian.net/browse/TICKET-NUMBER)

* Other Relevant Links (OAI Feeds, DPLA Records, Metadata Mappings, DLTN Documentation, Etc.)

## What does this Pull Request do?

A brief description of what the intended result of the PR will be and / or what problem it solves.

## What's new?

An in-depth description of the intended changes made by this PR. Technical details and possible side effects.

* Modified template-X to do Y
* Removed content model from index
* Added X as a stop word

## How should this be tested?

A description of what steps someone could take to:

1. Add an object to islandora vagrant
2. Look at its Solr document:  [http://localhost:8080/solr/collection1/select?q=PID%3A%22test:1%22&fl=*&wt=json&indent=true](http://localhost:8080/solr/collection1/select?q=PID%3A%22test:1%22&fl=*&wt=json&indent=true)
3. If overwriting a transform, replace your transform at this path: /var/lib/tomcat7/webapps/fedoragsearch/WEB-INF/classes/fgsconfigFinal/index/FgsIndex/islandora_transforms/
4. Restart tomcat or solr: http://localhost:8080/manager/
5. Update gsearch for your object with curl or python or GUI:

```python

import requests

my_pid = 'test:1'
requests.post(f'http://localhost:8080/fedorafedoragsearch/rest?operation=updateIndex&action=fromPid&value={my_pid}', auth=('fedoraAdmin', 'fedoraAdmin'))

```


## Additional Notes:

Any additional information that you think would be helpful when reviewing this PR.

## Interested parties

Tag (@ mention) interested parties or, if unsure, @ any people in the organization.1