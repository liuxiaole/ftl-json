cd "`pwd`/test/java/"
javac -Xlint:deprecation -classpath "./freemarker2.3.23.jar:." "Test.java" && echo build OK
java -classpath "./freemarker2.3.23.jar:." Test > temp.html
open temp.html

