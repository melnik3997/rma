<#import "parts/common.ftlh" as c >
<@c.page>
<h5 class=" mb-3 ">Добавление пользователя</h5>

<form method="post" enctype='multipart/form-data' >
  <#if errorCreate??>
    <div class="alert alert-danger" role="alert">
      ${errorCreate}
    </div>
  </#if>
  <div class="form-group">
      <input class="form-control" type="hidden" name="_csrf" value="${_csrf.token}"/>
  </div>
  <div class="form-group">
      <input class="form-control ${(userNameError??)?string('is-invalid','')}" type="text" name="userName" placeholder="Имя пользователя" value="${userName!}">
      <#if userNameError??>
      <div class="invalid-feedback">${userNameError}</div>
      </#if>
  </div>
  <div class="form-group">
      <input class="form-control  ${(emailError??)?string('is-invalid','')}" type="email" name="email" placeholder="Email" value="${email!}">
      <#if emailError??>
      <div class="invalid-feedback">${emailError}</div>
      </#if>
  </div>
  <button class="btn btn-primary" type="submit">Добавить</button>
</form>
</@c.page>