<#import "parts/common.ftlh" as c >
<@c.page>
<h5 class=" mb-3 ">Список предприятий</h5>

<a  type="button" class="btn btn-primary mb-3" href="/enterpriseAdd">Добавить предприятие</a >
<table class="table table-hover mb-3">
    <thead>
    <tr>
        <th scope="col">Наименование</th>
        <th scope="col">Сокращение</th>
        <th scope="col"></th>
    </tr>
    </thead>
    <tbody>
<#list enterpriseList as enterprise>
    <tr>
        <td>${enterprise.name}</td>
        <td>${enterprise.brief}</td>
        <td><a href="/enterprise/${enterprise.id}"> Редактировать </a></td>
    </tr>

</#list>
    </tbody>
</table>
</@c.page>