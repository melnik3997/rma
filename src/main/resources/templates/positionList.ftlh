<#import "parts/common.ftlh" as c >
<@c.page>

<div class="row align-items-start">
    <div class="col-8">
        <h5 class="mb-3 ">Должности <#if institution??> ${institution.getFullName()}</#if> </h5>
    </div>
    <div class="col-4">
        <a type="button" class="btn btn-primary mb-3 float-right" href="/positionUser/${userId}/add">Добавить должность</a>
    </div>
</div>

<div class="row align-items-center">
<table class="table table-hover mb-3">
    <thead>
    <tr>
        <th scope="col">Название должности</th>
        <th scope="col">Подразделение</th>
        <th scope="col">Основная</th>
        <th scope="col">Дата начала</th>
        <th scope="col">Дата окончания</th>
        <th scope="col"></th>
    </tr>
    </thead>
    <tbody>
    <#list positionList as position>
    <tr>
        <td>${position.getPostName()}</td>
        <td>${position.getSubdivisionName()}</td>
        <td><#if position.general> Да <#else> Нет </#if> </td>
        <td>${position.getDateStartString()}</td>
        <td>${position.getDateEndString()}</td>
        <td>
            <div class="dropdown show">
                <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Опции
                </a>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                    <a class="dropdown-item" href="/positionUser/${userId}/deletePosition/${position.id}">Снять должность</a>
                </div>
            </div>
        </td>
    </tr>
    </#list>
    </tbody>
</table>
</div>
<hr>
<div class="row align-items-end">
    <div class="col">
        <h5 class=" mb-3 ">Снятые должности </h5>
        <table class="table table-hover mb-3">
            <thead>
            <tr>
                <th scope="col">Название должности</th>
                <th scope="col">Подразделение</th>
                <th scope="col">Основная</th>
                <th scope="col">Дата начала</th>
                <th scope="col">Дата окончания</th>
            </tr>
            </thead>
            <tbody>
            <#list positionListDis as position>
            <tr>
                <td>${position.getPostName()}</td>
                <td>${position.getSubdivisionName()}</td>
                <td><#if position.general> Да <#else> Нет </#if> </td>
                <td>${position.getDateStartString()}</td>
                <td>${position.getDateEndString()}</td>
            </tr>
            </#list>
        </table>
    </div>
</div>
</@c.page>