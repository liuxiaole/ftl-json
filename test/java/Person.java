import java.util.*;

public class Person {
    private String name;

    public int age = 20;

    private Date birthday = new Date(1459251593605L);

    Person(String name){this.name = name;}

    public String getName(){ return name;}

    public void setName(String _name){ name = _name;}

    public Object getXxx(){ return null;}

    public Date getBirthday(){return birthday;}

    public String speak(){
        return "Hello, this is " + name;
    }

}