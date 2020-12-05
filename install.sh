#!/bin/bash
mvn -f ./ExecDashboard/pom.xml clean install package
mvn -f ./hygieia-cmdb-company-collector/pom.xml clean install package