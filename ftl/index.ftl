<#function stringify object={} maxDepth=20>
    <#return _encode(object, 0, maxDepth).jsonStr />
</#function>

<#function _encode object depth maxDepth>
    <#if maxDepth gt 0 && depth gt maxDepth>
        <#local object = '[[refering path depth exceeded]]' />
    </#if>

    <#local jsonStr = '' />
    <#local jsonType = 'object' />

    <#-- string -->
    <#if object?is_string>
        <#local jsonStr = jsonStr + '"${object?json_string}"' />
        <#local jsonType = 'string' />

    <#-- number -->
    <#elseif object?is_number>
        <#local jsonStr = jsonStr + "${object?c}" />
        <#local jsonType = 'number' />

    <#-- boolean -->
    <#elseif object?is_boolean>
        <#local jsonStr = jsonStr + object?string('true','false') />
        <#local jsonType = 'boolean' />
    
    <#-- date -->
    <#elseif object?is_date>
        <#local jsonStr = jsonStr + '"${object?iso_utc_ms}"' />
        <#local jsonType = 'date' />

    <#-- macro -->
    <#elseif object?is_macro>
        <#local jsonStr = '"[[MACRO]]"' />
        <#local jsonType = 'unknown' />
    
    <#-- function -->
    <#elseif object?is_method>
        <#local jsonStr = '"[[METHOD]]"' />
        <#local jsonType = 'unknown' />

    <#-- function -->
    <#elseif object?is_directive>
        <#local jsonStr = '"[[DIRECTIVE]]"' />
        <#local jsonType = 'unknown' />

    <#-- hash -->
    <#elseif object?is_hash || object?is_hash_ex>
        <#local jsonStr = jsonStr + '{' />
        <#list object?keys as key>
            <#if !object[key]??>
                <#local jsonStr = jsonStr + '"${key?json_string}":' + 'null' + key_has_next?string(',','') />
            <#else>
                <#local subObj = _encode(object[key], depth+1, maxDepth) />
                <#if subObj.jsonType != 'unknown'>
                    <#local jsonStr = jsonStr + '"${key?json_string}":' + subObj.jsonStr + key_has_next?string(',','') />
                </#if>
            </#if>
        </#list>
        <#local jsonStr = jsonStr + '}' />
        <#local jsonType = 'object' />
    
    <#-- sequence -->
    <#elseif object?is_sequence || object?is_collection || object?is_enumerable>
        <#local jsonStr = jsonStr + '[' />
        <#list object as item>
            <#if !item??>
                <#local jsonStr = jsonStr + 'null' + item_has_next?string(',','') />
            <#else>
                <#local subObj = _encode(item!{}, depth+1, maxDepth) />
                <#if subObj.jsonType != 'unknown'>
                    <#local jsonStr = jsonStr + subObj.jsonStr + item_has_next?string(',','') />
                </#if>
            </#if>
        </#list>
        <#local jsonStr = jsonStr + ']' />
        <#local jsonType = 'array' />
    
    <#-- unknown -->
    <#else>
        <#local jsonStr = '"[[UNKNOWN]]"' />
        <#local jsonType = 'unknown' />

    </#if> 

    <#return {"jsonStr":jsonStr,"jsonType":jsonType} />
</#function>

