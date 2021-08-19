<#import "parts/common.ftlh" as c >
<@c.page>

<#if ChainLeaderByInstitutionList ??>
<h5 class="mb-3 ">Вышестоящие руководители</h5>
<#list ChainLeaderByInstitutionList as institution>
<div class="card my-3 w-75 mx-auto">
    <div class="container m-0 p-0">
        <div class="row mx-0">
            <div class="col align-self-center m-0 p-0">
                <div class="m-2">
                    <h5 class="card-title">${institution.getFullName()} </h5>
                    <#if institution.getPositionName() != "">
                    <a class="card-title" href="/institutionChain/${institution.id}" >Должность: ${institution.getPositionName()}</a>
                    <br>
                </#if>
                <#if institution.getSubdivisionName() != "">
                <h7 class="card-title">Подразделение: ${institution.getSubdivisionName()}</h7>
            </#if>
            <p class="card-text">Тел.  ${institution.phoneNumber} <br>
                Skype  ${institution.skypeName}</p>
        </div>
    </div>
    <div class="col m-0 p-0">
        <#if institution.fileName??>
        <img class="rounded mx-auto d-block" src="/img/${institution.fileName}">
    </#if>
</div>
</div>
</div>
<div class="card-footer text-muted">
    ${institution.enterpriseBrief}</strong>
</div>
</div>
</#list>
</#if>

<#if leaderInstitution??>
<hr>
<h5 class="mb-3 ">Руководитель</h5>
<div class="card my-3 w-75 mx-auto">
    <div class="container m-0 p-0">
        <div class="row mx-0">
            <div class="col align-self-center m-0 p-0">
                <div class="m-2">
                    <h5 class="card-title">${leaderInstitution.getFullName()} </h5>
                    <#if leaderInstitution.getPositionName() != "">
                    <a class="card-title" href="/institutionChain/${leaderInstitution.id}" >Должность: ${leaderInstitution.getPositionName()}</a>
                    <br>
                </#if>
                <#if leaderInstitution.getSubdivisionName() != "">
                <h7 class="card-title">Подразделение: ${leaderInstitution.getSubdivisionName()}</h7>
            </#if>
            <p class="card-text">Тел.  ${leaderInstitution.phoneNumber} <br>
                Skype  ${leaderInstitution.skypeName}</p>
        </div>
    </div>
    <div class="col m-0 p-0">
        <#if leaderInstitution.fileName??>
        <img class="rounded mx-auto d-block" src="/img/${leaderInstitution.fileName}">
    </#if>
</div>
</div>
</div>
<div class="card-footer text-muted">
    ${leaderInstitution.enterpriseBrief}</strong>
</div>
</div>
</#if>

<#if institution??>
<hr>
<h5 class="mb-3 ">Сотрудник</h5>
<div class="card my-3 w-75 mx-auto">
    <div class="container m-0 p-0">
        <div class="row mx-0">
            <div class="col align-self-center m-0 p-0">
                <div class="m-2">
                    <h5 class="card-title">${institution.getFullName()} </h5>
                    <#if institution.getPositionName() != "">
                        <a class="card-title" href="/institutionChain/${institution.id}" >Должность: ${institution.getPositionName()}</a>
                        <br>
                    </#if>
                    <#if institution.getSubdivisionName() != "">
                        <h7 class="card-title">Подразделение: ${institution.getSubdivisionName()}</h7>
                    </#if>
                    <p class="card-text">Тел.  ${institution.phoneNumber} <br>
                        Skype  ${institution.skypeName}</p>
                </div>
            </div>
            <div class="col m-0 p-0">
                <#if institution.fileName??>
                    <img class="rounded mx-auto d-block" src="/img/${institution.fileName}">
                </#if>
            </div>
        </div>
    </div>
    <div class="card-footer text-muted">
        ${institution.enterpriseBrief}</strong>
    </div>
</div>
</#if>


<#if colleaguesInstitution ??>
<hr>
<h5 class="mb-3 ">Коллеги</h5>
<#list colleaguesInstitution as institution>
<div class="card my-3 w-75 mx-auto">
    <div class="container m-0 p-0">
        <div class="row mx-0">
            <div class="col align-self-center m-0 p-0">
                <div class="m-2">
                    <h5 class="card-title">${institution.getFullName()} </h5>
                    <#if institution.getPositionName() != "">
                    <a class="card-title" href="/institutionChain/${institution.id}" >Должность: ${institution.getPositionName()}</a>
                    <br>
                </#if>
                <#if institution.getSubdivisionName() != "">
                <h7 class="card-title">Подразделение: ${institution.getSubdivisionName()}</h7>
            </#if>
            <p class="card-text">Тел.  ${institution.phoneNumber} <br>
                Skype  ${institution.skypeName}</p>
        </div>
    </div>
    <div class="col m-0 p-0">
        <#if institution.fileName??>
        <img class="rounded mx-auto d-block" src="/img/${institution.fileName}">
    </#if>
</div>
</div>
</div>
<div class="card-footer text-muted">
    ${institution.enterpriseBrief}</strong>
</div>
</div>
</#list>
</#if>

<#if subordinatesInstitution ??>
<hr>
<h5 class="mb-3 ">Подчиненные</h5>
<#list subordinatesInstitution as institution>
<div class="card my-3 w-75 mx-auto">
    <div class="container m-0 p-0">
        <div class="row mx-0">
            <div class="col align-self-center m-0 p-0">
                <div class="m-2">
                    <h5 class="card-title">${institution.getFullName()} </h5>
                    <#if institution.getPositionName() != "">
                    <a class="card-title" href="/institutionChain/${institution.id}" >Должность: ${institution.getPositionName()}</a>
                    <br>
                </#if>
                <#if institution.getSubdivisionName() != "">
                <h7 class="card-title">Подразделение: ${institution.getSubdivisionName()}</h7>
            </#if>
            <p class="card-text">Тел.  ${institution.phoneNumber} <br>
                Skype  ${institution.skypeName}</p>
        </div>
    </div>
    <div class="col m-0 p-0">
        <#if institution.fileName??>
        <img class="rounded mx-auto d-block" src="/img/${institution.fileName}">
    </#if>
</div>
</div>
</div>
<div class="card-footer text-muted">
    ${institution.enterpriseBrief}</strong>
</div>
</div>
</#list>
</#if>

</@c.page>