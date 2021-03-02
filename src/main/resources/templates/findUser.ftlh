<#import "parts/common.ftlh" as c >
<@c.page>
<div class="card-columns">
    <#list institutions as institution>
    <div class="card my-3">
        <#if institution.fileName??>
        <img class="card-img-top" src="/img/${message.fileName}">
    </#if>
    <div class="m-2">
        <h5 class="card-title">${institution.lastName} ${institution.firstName} <#if institution.secondName??> ${institution.secondName} </#if> </h5>
        <p class="card-text">${institution.phoneNumber}</p>
    </div>

    <div class="card-footer text-muted">
        ${institution.enterpriseBrief}</strong>
    </div>
</div>
<#else>
Данные не найдены
</#list>
</div>
</@c.page>