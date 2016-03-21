JSON Stringify in FreeMarker
==========

# Intro

JSON.stringify 的 freemarker 版本实现, 支持 `hash(hash_ex)` `sequence(collection、enumerable, indexable)` `string` `number` `date` `boolean` 类型的值转化为 JSON 字符串格式。

# How-to-use

```freemarker
<script>
var obj = ${JSON.stringify(data)}; //直接当作js语句
var jsonString = "${JSON.stringify(data)?js_string}"; //输出到js字符串
</script>

<div data-options="${JSON.stringify(data)?html}"></div> <!-- 输出到节点属性上 -->

<#escape x as x?html>
    <p>${JSON.stringify(data)}</p> <!-- escape 内 -->
    <input type="text" value="${JSON.stringify(data)}" />
    <script type="text/javascript">
    <!-- script内 noescape  -->
        <#noescape> 
            window.data = ${JSON.stringify(data)};
        </#noescape>
    </script>
</#escape>

```

# Notice


由于在 freemarker 中无法正常处理 `null` 值，因此传递不存在的值将得到一个空对象，即 `{}`。而 map 或 list 中不存在的 value 或 item 会处理为 `null`。
```freemarker
${(JSON.stringify() == '{}') ? string('true', 'false')}  <#-- true -->
```

**由于在 freemarker 中无法比较两个对象是否是相同的引用，因此无法检查数据中是否出现循环引用。目前使用限制数据引用深度的方式防止出现死循环，默认深度为20，可通过第二个参数来覆盖默认的深度，传递 0 则表示不限制数据深度。**

```freemarker
${JSON.stringify(data, 30)}
${JSON.stringify(data, 0)}
```

即使在限制引用深度为20的情况下，如果出现恶劣的循环引用的数据结构，仍会导致数据溢出。

**请严格保证传递的数据不出现循环引用。**

**请严格保证传递的数据不出现循环引用。**

**请严格保证传递的数据不出现循环引用。**

该模块仅供 ftl 中转化简单的数据对象，例如将简单的配置数据传递到 js 中。如果遇到数据量大的场景，请直接让后台童鞋传递 json 字符串。没有做过benchmark，但 ftl 中的对象都是包装过的 java 对象（wrapped object），理论上这个 ftl 版的实现必然要比 java 中直接实现效率低。

