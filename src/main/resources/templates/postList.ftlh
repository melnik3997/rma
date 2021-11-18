<#import "parts/common.ftlh" as c >
<@c.page>
<h5 class=" mb-3 ">Должности</h5>

<a  type="button" class="btn btn-primary mb-3" href="/post/add">Добавить должность</a >
<table class="table table-hover mb-3">
    <thead>
    <tr>
        <th scope="col">Наименование</th>
        <th scope="col">Тип</th>
        <th scope="col">Уровень</th>
        <th scope="col"></th>
    </tr>
    </thead>
    <tbody>
    <#list postList as post>
    <tr>
        <td>${post.name}</td>
        <td>${post.getPostTypeName()}</td>
        <td>${post.getPostLevelName()}</td>
        <td>
            <div class="dropdown show">
                <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Опции
                </a>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                    <a class="dropdown-item" href="/post/${post.id?c}">Редактировать</a>
                </div>
            </div>
        </td>
    </tr>

    </#list>
    </tbody>
</table>
</@c.page>