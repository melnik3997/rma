<#import "parts/common.ftlh" as c >
<@c.page>
<h5 class=" mb-3 ">Список подразделений</h5>

<a  type="button" class="btn btn-primary mb-3" href="/subdivisionEnterprise/add/${enterprise.id}">Добавить подразделение</a >
<table class="table table-hover mb-3">
    <thead>
    <tr>
        <th scope="col">Наименование</th>
        <th scope="col">Сокращение</th>
        <th scope="col">Вышестоящее подразделение</th>
        <th scope="col"></th>
    </tr>
    </thead>
    <tbody>
<#list subdivisionList as subdivision>
    <tr>
        <td>${subdivision.name}</td>
        <td>${subdivision.brief}</td>
        <td>${subdivision.getParentName()}</td>
        <td>
            <div class="dropdown show">
                <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Опции
                </a>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                    <a class="dropdown-item" href="/subdivisionEnterprise/${enterprise.id}/edit/${subdivision.id}">Редактировать</a>
                </div>
            </div>
        </td>
    </tr>

</#list>
    </tbody>
</table>
</@c.page>