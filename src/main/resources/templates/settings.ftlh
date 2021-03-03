<#import "parts/common.ftlh" as c >
<@c.page>
<form method="post" enctype='multipart/form-data' >
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
</@c.page>