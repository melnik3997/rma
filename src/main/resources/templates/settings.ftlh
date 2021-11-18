<#import "parts/common.ftlh" as c >
<@c.page>
<a class="btn btn-primary mb-3" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
    Добавить настройку
</a>
<div class="collapse <#if error??>show</#if>" id="collapseExample">
    <div class="form-group">
        <form method="post" enctype='multipart/form-data'>

            <div>${error!}</div>

            <div class="form-group">
                <input class="form-control" type="hidden" name="_csrf" value="${_csrf.token}"/>
            </div>
            <div class="form-group">
                <input class="form-control " type="text" name="sysName" placeholder="Наименование">

            </div>
            <div class="form-group">
                <input class="form-control  " type="text" name="type" placeholder="Тип данных">

            </div>
            <div class="form-group">
                <input class="form-control" type="text" name="value" placeholder="Значение">

            </div>
            <button class="btn btn-primary" type="submit">Добавить</button>
        </form>
    </div>
</div>

<table class="table table-hover mb-3">
    <thead>
    <tr>
        <th scope="col">Системное имя</th>
        <th scope="col">Тип данных</th>
        <th scope="col">Значение</th>
        <th scope="col"></th>
    </tr>
    </thead>
    <tbody>
    <#list settingsList as settings>
    <tr>
        <td>${settings.sysName}</td>
        <td>${settings.type}</td>
        <td>${settings.val}</td>
        <td>
            <div class="dropdown show">
                <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Опции
                </a>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                    <a class="dropdown-item" href="settings/edit/${settings.sId?c}">Редактировать</a>
                    <a class="dropdown-item" href="settings/delete/${settings.sId?c}">Удалить</a>
                </div>
            </div>
        </td>
    </tr>

    </#list>
    </tbody>
</table>
</@c.page>