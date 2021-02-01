<#import "parts/common.ftlh" as c >
<@c.page>
<h5 class=" mb-3 ">Добавление предприятия</h5>

<form method="post" enctype='multipart/form-data' action="/editEnterprise" >
  <div class="form-group">
      <input class="form-control" type="hidden" name="_csrf" value="${_csrf.token}"/>
      <input type="hidden" name="enterpriseId" value="${enterprise.id}"/>
  </div>
  <div class="form-group">
      <input class="form-control ${(nameError??)?string('is-invalid','')}" type="text" name="name" value="${enterprise.name}" placeholder="Наименование">
      <#if nameError??>
      <div class="invalid-feedback">${nameError}</div>
      </#if>
  </div>
  <div class="form-group">
      <input class="form-control ${(briefError??)?string('is-invalid','')}" type="text" name="brief"  value="${enterprise.brief}" placeholder="Сокращение">
      <#if briefError??>
      <div class="invalid-feedback">${briefError}</div>
      </#if>
  </div>
  <button class="btn btn-primary" type="submit">Сохранить</button>
</form>

<form method="post" enctype='multipart/form-data' action="/deleteEnterprise" >
  <input class="form-control" type="hidden" name="_csrf" value="${_csrf.token}"/>
  <input type="hidden" name="enterpriseId" value="${enterprise.id}"/>
  <button class="btn btn-secondary" type="submit">Удалить</button>
</form>
</@c.page>