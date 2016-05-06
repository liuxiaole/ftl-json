@echo off
cd %~dp0%/java
echo cleaning...
@del *.class
echo javac...
javac -Xlint:deprecation -classpath ./freemarker2.3.23.jar;. ./Test.java && echo build OK

java -classpath ./freemarker2.3.23.jar;. Test > temp.html && start temp.html