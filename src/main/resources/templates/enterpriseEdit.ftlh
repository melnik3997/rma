<#import "parts/common.ftlh" as c >
<@c.page>
<h5 class=" mb-3 ">Добавление предприятия</h5>
<#if deleteError??>
    <div class="alert alert-danger" role="alert">
        ${deleteError}
    </div>
</#if>
<form method="post" enctype='multipart/form-data' action="/editEnterprise" >
  <div class="form-group">
      <input class="form-control" type="hidden" name="_csrf" value="${_csrf.token}"/>
      <input type="hidden" name="enterpriseId" value="${enterprise.id?c}"/>
  </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Сокращение</label>
        <div class="col-sm-8">
            <input class="form-control ${(briefError??)?string('is-invalid','')}" type="text" name="brief"
                   value="${enterprise.brief}" placeholder="Сокращение">
            <#if briefError??>
            <div class="invalid-feedback">${briefError}</div>
        </#if>
    </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Наименование</label>
        <div class="col-sm-8">
            <input class="form-control ${(nameError??)?string('is-invalid','')}" type="text" name="name"
                   value="${enterprise.name}" placeholder="Наименование">
            <#if nameError??>
            <div class="invalid-feedback">${nameError}</div>
            </#if>
        </div>
    </div>
    <div class="form-group row">
        <button class="btn btn-primary" type="submit">Сохранить</button>
    </div>
</form>

<form method="post" enctype='multipart/form-data' action="/deleteEnterprise">
    <input class="form-control" type="hidden" name="_csrf" value="${_csrf.token}"/>
    <input type="hidden" name="enterpriseId" value="${enterprise.id?c}"/>
    <div class="form-group row">
    <button class="btn btn-secondary " type="submit">Удалить    </button>
    </div>
</form>


</@c.page>