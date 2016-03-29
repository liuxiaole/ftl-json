import java.util.*;
import java.io.*;

import freemarker.template.*;

public class Test{ 
    private Configuration cfg;


    public static void main(String[] args){
        new Test();
    }

    private void initConfig() throws Exception{
        cfg = new Configuration(Configuration.VERSION_2_3_22);
        cfg.setDirectoryForTemplateLoading(new File("../../"));
        cfg.setDefaultEncoding("UTF-8");
        cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);

        DefaultObjectWrapperBuilder builder = new DefaultObjectWrapperBuilder(new Version("2.3.22"));
        DefaultObjectWrapper wrapper = builder.build();

        cfg.setObjectWrapper(wrapper);
    }


    public Test(){
        try{
            initConfig();
            runTest();
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    public void runTest() throws Exception{
       
        SimpleHash scopeRoot = new SimpleHash(cfg.getObjectWrapper());

        scopeRoot.put("a", new BeanA());

        try{
            render("test/index.ftl", scopeRoot);
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    public void render(String tpl, Object data) throws Exception{
        Template temp = cfg.getTemplate(tpl);
        Writer out = new OutputStreamWriter(System.out);
        temp.process(data, out);
        out.flush();
    }

}