<#import "parts/common.ftlh" as c >
<@c.page>
<div class="card-columns">
    <#list institutions as institution>
    <div class="card my-3">
        <#if institution.fileName??>
        <img class="card-img-top" src="/img/${institution.fileName}">
    </#if>
    <div class="m-2">
        <h5 class="card-title">${institution.getFullName()} </h5>
        <#if institution.getPositionName() != "">
            <a class="card-title" href="/institutionChain/${institution.id?c}" >Должность: ${institution.getPositionName()}</a>
            <br>
        </#if>
        <#if institution.getSubdivisionName() != "">
            <h7 class="card-title">Подразделение: ${institution.getSubdivisionName()}</h7>
        </#if>
        <p class="card-text">Тел.  ${institution.phoneNumber} <br>
        Skype  ${institution.skypeName}</p>
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