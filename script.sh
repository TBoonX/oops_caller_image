pwd
ls -hal

# Prepare files
touch /builds/root/test/$1.xml
touch /builds/root/test/$1_correct.xml
touch /builds/root/test/$1_short.xml

# Create an XML
rapper -i turtle -o rdfxml /builds/root/test/$1.ttl > /builds/root/test/$1.xml #transform to RDF
tr '\n' ' ' < /builds/root/test/$1.xml > /builds/root/test/$1_short.xml #make one line
echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?><OOPSRequest>      <OntologyUrl></OntologyUrl>      <OntologyContent><![CDATA[" > /builds/root/test/$1_correct.xml #Add OOPS header
cat /builds/root/test/$1_short.xml >> /builds/root/test/$1_correct.xml #Add content
echo "]]></OntologyContent>      <Pitfalls></Pitfalls>      <OutputFormat>RDF/XML</OutputFormat></OOPSRequest>" >> /builds/root/test/$1_correct.xml #Add OOPS Footer
cat /builds/root/test/$1_correct.xml

# Send it to OOPS
#curl -X POST -H "Content-Type: text/xml" http://oops-ws.oeg-upm.net/rest --data @/builds/root/test/$1_correct.xml
curl -X POST -H "Content-Type: text/xml" http://oops.linkeddata.es/rest --data @/builds/root/test/$1_correct.xml

