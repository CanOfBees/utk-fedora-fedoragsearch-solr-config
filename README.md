## Fedora, Fedora GSearch, and Solr Configurations ##

This repository intends to be a holistic settings and configuration repository for our deployments of Fedora, Fedora GSearch, and Solr. XSL transforms specifically geared for converting Fedora's FOXML and Fedora datastreams to Solr-friendly XML are available in `fedoragsearch-transforms`.

### Configurations ###

#### fedora-conf ####
```
fedora-conf/
└── fedora.fcfg
```

#### fedoragsearch-conf ####
```
fedoragsearch-conf
├── fedoragsearch.properties
├── fgsconfig-basic-configForIslandora.properties
└── updater
    ├── FgsUpdater1
    │   └── updater.properties
    ├── FgsUpdater2
    │   └── updater.properties
    ├── FgsUpdater3
    │   └── updater.properties
    ├── FgsUpdater4
    │   └── updater.properties
    └── FgsUpdaters
        └── updater.properties
```

#### fedoragsearch-transforms ####
```
fedoragsearch-transforms/
├── foxmlToSolr.xslt
├── index.properties
└── islandora_transforms
    ├── datastream_info_to_solr.xslt
    ├── DC_to_solr.xslt
    ├── EACCPF_to_solr.xslt
    ├── FOXML_properties_to_solr.xslt
    ├── hierarchy.xslt
    ├── library
    │   ├── traverse-graph.xslt
    │   └── xslt-date-template.xslt
    ├── MADS_to_solr.xslt
    ├── manuscript_finding_aid.xslt
    ├── MODS_to_solr.xslt
    ├── RELS-EXT_to_solr.xslt
    ├── RELS-INT_to_solr.xslt
    ├── slurp_all_chemicalML_to_solr.xslt
    ├── slurp_all_ead_to_solr.xslt
    ├── slurp_all_MODS_to_solr.xslt
    ├── TEI_to_solr.xslt
    ├── text_to_solr.xslt
    ├── WORKFLOW_to_solr.xslt
    ├── XML_text_nodes_to_solr.xslt
    └── XML_to_one_solr_field.xslt

```

#### solr-conf ####
```
solr-conf/
├── data-config.xml
├── data-import-config.xml.erb
├── schema.xml
├── solrconfig.xml
└── stopwords.txt
```
