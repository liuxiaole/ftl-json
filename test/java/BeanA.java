import java.util.*;

public class BeanA{

    private String[] d;
    private HashMap<String, Object> e;

    private ArrayList<Object> g;

    BeanA(){

        d = new String[3];
        d[0] = null;
        d[1] = "xxx";
        d[2] = "";

        e = new HashMap<String, Object>();
        e.put("prop", null);
        e.put("\t\0\n\r\'\"b", d);

        g = new ArrayList<Object>();

        g.add(new Person("Hanmeimei"));
        g.add(new Person("Lilei"));
        g.add(new Boolean("false"));
        g.add(new Integer(-1));
        g.add(new Double(12.003));
        g.add(Double.MAX_VALUE);
        g.add(Double.NaN);
        g.add(new Character('A'));
        g.add(null);
        g.add(d);
        g.add(new Error("whatever, you're wrong!"));
    } 

    public String[] getD(){
        return d;
    }

    public void setD(String[] _d){
        d = _d;
    }

    public HashMap<String, Object> getE(){
        return e;
    }

    public void setE(HashMap<String, Object> _e){
        e = _e;
    }

    public Object getF(){
        return null;
    }

    public ArrayList<Object> getG(){
        return g;
    }

    public void setG(ArrayList<Object> _g){
        g = _g;
    }
}