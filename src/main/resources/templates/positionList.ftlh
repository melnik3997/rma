<#import "parts/common.ftlh" as c >
<@c.page>
<h5 class=" mb-3 ">Должности <#if institution??> ${institution.getFullName()}</#if> </h5>

<a  type="button" class="btn btn-primary mb-3" href="/positionUser/${userId}/add">Добавить должность</a >
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
    <#list positionList as position>
    <tr>
        <td>${position.getPostName()}</td>
        <td>${position.getSubdivisionName()}</td>
        <td><#if position.general> Да <#else> Нет </#if> </td>
        <td>${position.dateStart}</td>
        <td>${position.dateEnd}</td>
    </tr>

    </#list>
    </tbody>
</table>
</@c.page>