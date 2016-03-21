<#assign time = .now />

<#assign a = {
    "a": 1,
    "b\nc": true,
    "c.d": time,
    "\"'\\": [
        {
            "a": 1,
            "b": 2
        },
        {
            "c": {
                "xxx": "<a href=\"http://www.baidu.com\" >baidu</a>" 
            }
        }
    ]
} /> 

<#assign b = [a,a,a] /> 



<#include "../index.ftl">

<html>
<head>
    <title>测试</title>
</head>
<body>
    <div data-options="${JSON.stringify(a)?html}" id="test"></div>

    请查看F12控制台

    <script> 
        var a = ${JSON.stringify(a)};
        var b = ${JSON.stringify(b)};
        var c = ${JSON.stringify(c)};
        var d = ${JSON.stringify(d)};
        var str_a = "${JSON.stringify(a)?js_string}";

        console.assert(a["\"'\\"][1].c.xxx, "${a["\"\'\\"][1].c.xxx?js_string}");   //"   
        console.assert(a["b\nc"]);
        console.assert(Date.parse(a["c.d"]) , ${time?long?c});
        console.assert(b.length , 3);
        console.assert(JSON.stringify(a), JSON.stringify(JSON.parse(str_a)));
        console.assert("${JSON.stringify()?js_string}" , "{}");  
        console.assert(JSON.stringify(a) , JSON.stringify(JSON.parse(document.querySelector('#test').getAttribute('data-options'))) );
    </script>
</body>
</html>