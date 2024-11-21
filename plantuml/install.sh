TMPFILE=$ARG

if [ -z "$TMPFILE" ]; then
  echo "No tar file to install"
  exit 1
fi

mv "$TMPFILE" /usr/local/bin/plantuml.jar

cat <<EOF >> /usr/local/bin/plantuml
#!/bin/bash
java -jar /usr/local/bin/plantuml.jar \$@
EOF
chmod a+x /usr/local/bin/plantuml
