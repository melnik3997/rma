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
        <td>
            <div class="dropdown show">
                <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Опции
                </a>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                    <a class="dropdown-item" href="/enterprise/${enterprise.id?c}">Редактировать</a>
                    <a class="dropdown-item" href="/subdivisionTree/${enterprise.id?c}">Подразделения</a>
                    <a class="dropdown-item" href="/calendarListEnterprise/${enterprise.id?c}">Календари</a>
                    <a class="dropdown-item" href="/enterprise/${enterprise.id?c}/bidRuleList">Правила заявок</a>
                </div>
            </div>
        </td>
    </tr>

</#list>
    </tbody>
</table>
</@c.page>