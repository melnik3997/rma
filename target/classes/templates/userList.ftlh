<#import "parts/common.ftlh" as c >
<@c.page>
Список пользователей

<table class="table table-hover mb-3">
    <thead>
    <tr>
        <th scope="col">Name</th>
        <th scope="col">Role</th>
        <th scope="col"></th>
    </tr>
    </thead>
    <tbody>
<#list userList as user>
    <tr>
        <td>${user.username}</td>
        <td><#list user.role as role> ${role}<#sep>, </#list> </td>
        <td>
          <div class="dropdown show">
           <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
             Опции
           </a>
           <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
             <a class="dropdown-item" href="/user/${user.id}">Редактировать</a>
             <a class="dropdown-item" href="/institution/${user.id}">Основная информация</a>
             <a class="dropdown-item" href="#">Something else here</a>
           </div>
          </div>
        </td>
    </tr>

</#list>
    </tbody>
</table>
</@c.page>