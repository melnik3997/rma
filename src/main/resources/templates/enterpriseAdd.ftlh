<#import "parts/common.ftlh" as c >
<@c.page>
<h5 class=" mb-3 ">Добавление предприятия</h5>

<form method="post" enctype='multipart/form-data' >
  <div class="form-group">
      <input class="form-control" type="hidden" name="_csrf" value="${_csrf.token}"/>
  </div>
  <div class="form-group">
      <input class="form-control ${(nameError??)?string('is-invalid','')}" type="text" name="name" placeholder="Наименование">
      <#if nameError??>
      <div class="invalid-feedback">${nameError}</div>
      </#if>
  </div>
  <div class="form-group">
      <input class="form-control  ${(briefError??)?string('is-invalid','')}" type="text" name="brief" placeholder="Сокращение">
      <#if briefError??>
      <div class="invalid-feedback">${briefError}</div>
      </#if>
  </div>
  <button class="btn btn-primary" type="submit">Добавить</button>
</form>

</@c.page>