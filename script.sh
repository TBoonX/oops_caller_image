#!/bin/sh

#output=/dev/null

# Prepare files
touch $1.xml
touch $1_correct.xml
touch $1_short.xml
touch result.xml

# Create an XML
rapper -q -i turtle -o rdfxml $1.ttl > $1.xml #transform to RDF
tr '\n' ' ' < $1.xml > $1_short.xml #make one line
echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?><OOPSRequest>      <OntologyUrl></OntologyUrl>      <OntologyContent><![CDATA[" > $1_correct.xml #Add OOPS header
cat $1_short.xml >> $1_correct.xml #Add content
echo "]]></OntologyContent>      <Pitfalls></Pitfalls>      <OutputFormat>RDF/XML</OutputFormat></OOPSRequest>" >> $1_correct.xml #Add OOPS Footer
#cat $1_correct.xml

# Send it to OOPS
#curl -X POST -H "Content-Type: text/xml" http://oops-ws.oeg-upm.net/rest --data @$1_correct.xml
curl -s -X POST -H "Content-Type: text/xml" http://oops.linkeddata.es/rest --data @$1_correct.xml > result.xml

cat result.xml
