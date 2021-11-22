<#import "parts/common.ftlh" as c >
<@c.page>
<h5 class="mb-3">Список пользователей</h5>


<table class="table table-hover mb-3">
    <thead>
    <tr>
        <th scope="col">Логин</th>
        <th scope="col">Роль</th>
        <th scope="col">ФИО</th>
        <th scope="col">Организация</th>
        <th scope="col">Подразделение</th>
        <th scope="col">Должность</th>
        <th scope="col"></th>
    </tr>
    </thead>
    <tbody>
<#list userList as user>
    <tr>
        <td>${user.username}</td>
        <td><#list user.role as role> ${role}<#sep>, </#list> </td>
        <td>${user.getFullName()}</td>
        <td>${user.getEnterpriseBrief()}</td>
        <td>${user.getSubdivisionName()}</td>
        <td>${user.getPositionName()}</td>
        <td>
          <div class="dropdown show">
           <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
             Опции
           </a>
           <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
             <a class="dropdown-item" href="/user/${user.id?c}">Редактировать</a>
             <a class="dropdown-item" href="/institution/${user.id?c}">Основная информация</a>
             <a class="dropdown-item" href="/positionUser/${user.id?c}">Должности</a>
             <#if user.getInstitutionID() != 0>  <a class="dropdown-item" href="/workSchedule/list/${user.getInstitutionID()?c}">График работы</a> </#if>
           </div>
          </div>
        </td>
    </tr>

</#list>
    </tbody>
</table>
</@c.page>