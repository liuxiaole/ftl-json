<#include "../index.ftl">

<#assign time = .now />

<#assign b = {
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
                "xxx": "<a href=\"http://www.163.com.com\" >163</a>" 
            }
        }
    ]
} /> 

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
</head>
<body>
    <h1>Press F12  to see the Console and Source Code</h1>
    <div data-options="${JSON.stringify(a)?html}" id="test"></div>
    <div data-options="${JSON.stringify(b)?html}" id="test2"></div>

    <script>
    var a = ${JSON.stringify(a)};
    var str_a = "${JSON.stringify(a)?js_string}";

    console.assert(a.g[5],Number.MAX_VALUE); // max value of double 
    console.assert(JSON.stringify(a) , JSON.stringify(JSON.parse(document.querySelector('#test').getAttribute('data-options'))) ); //html tag attribute
    console.assert(Date.parse(a.g[0].birthday) , 1459251593605); // java.util.date
    console.assert(a.g[0].age === undefined); // java public field not exposed , only remains getter and setter data fields
    console.assert(a.g[0].speak === undefined); // java public method not exposed

    ///////////////////////////////////////////
    // ftl assigned data test
    //////////////////////////////////////////

    var b = ${JSON.stringify(b)};
    var str_b = "${JSON.stringify(b)?js_string}";

    console.assert(b["\"'\\"][1].c.xxx, "${b["\"\'\\"][1].c.xxx?js_string}");   //"
    console.assert(b["b\nc"]);
    console.assert(Date.parse(b["c.d"]) , ${time?long?c});
    console.assert(JSON.stringify(b), JSON.stringify(JSON.parse(str_b)));
    console.assert(JSON.stringify(b) , JSON.stringify(JSON.parse(document.querySelector('#test2').getAttribute('data-options'))) );
    console.assert("${JSON.stringify()?js_string}" , "null");  
    </script>
</body>
</html>

