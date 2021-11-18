<#import "parts/common.ftlh" as c >
<@c.page>
<h5 class=" mb-3 ">Редактирование настройки</h5>

<form method="post" enctype='multipart/form-data'  >
    <div>${error!}</div>
    <div class="form-group">
        <input class="form-control" type="hidden" name="_csrf" value="${_csrf.token}"/>
        <input type="hidden" name="sId" value="${settings.sId?c}"/>
    </div>
    <div class="form-group">
        <input class="form-control ${(nameError??)?string('is-invalid','')}" type="text" name="sysName" value="${settings.sysName}" placeholder="Наименование">
        <#if nameError??>
        <div class="invalid-feedback">${nameError}</div>
    </#if>
    </div>
    <div class="form-group">
        <input class="form-control ${(briefError??)?string('is-invalid','')}" type="text" name="type"  value="${settings.type}" placeholder="Тип">
        <#if briefError??>
        <div class="invalid-feedback">${briefError}</div>
    </#if>
    </div>
    <div class="form-group">
        <input class="form-control ${(briefError??)?string('is-invalid','')}" type="text" name="value"  value="${settings.val}" placeholder="Значение">
        <#if briefError??>
        <div class="invalid-feedback">${briefError}</div>
    </#if>
    </div>
    <button class="btn btn-primary" type="submit">Изменить</button>
</form>
</@c.page>