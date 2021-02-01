<#import "parts/common.ftlh" as c >
<@c.page>
<h5 class=" mb-3 ">Основная информация о пользователе</h5>

<form method="post" enctype='multipart/form-data' >
  <div class="form-group">
      <input class="form-control" type="hidden" name="_csrf" value="${_csrf.token}"/>
      <input type="hidden" name="userId" value="${userId}"/>
      <#if institution??>
        <input type="hidden" name="institutionId" value="${institution.id}"/>
      <#else>
        <input type="hidden" name="institutionId" value="-1"/>
      </#if>
  </div>
  <#if institution??>
    <div class="form-group">
          <input class="form-control ${(firstNameError??)?string('is-invalid','')}" type="text" name="firstName" placeholder="Имя" value="${institution.firstName}">
        <#if firstNameError??>
          <div class="invalid-feedback">${firstNameError}</div>
        </#if>
    </div>
    <div class="form-group">
          <input class="form-control ${(lastNameError??)?string('is-invalid','')}" type="text" name="lastName" placeholder="Фамилия" value="${institution.lastName}">
        <#if lastNameError??>
          <div class="invalid-feedback">${lastNameError}</div>
        </#if>
    </div>
  <#else>
    <div class="form-group">
          <input class="form-control ${(firstNameError??)?string('is-invalid','')}" type="text" name="firstName" placeholder="Имя"  value="${firstName!}">
        <#if firstNameError??>
          <div class="invalid-feedback">${firstNameError}</div>
        </#if>
    </div>
    <div class="form-group">
          <input class="form-control ${(lastNameError??)?string('is-invalid','')}" type="text" name="lastName" placeholder="Фамилия">
        <#if lastNameError??>
          <div class="invalid-feedback">${lastNameError}</div>
        </#if>
    </div>
    <div class="form-group">
          <input class="form-control ${(secondNameError??)?string('is-invalid','')}" type="text" name="secondName" placeholder="Отчество">
        <#if secondNameError??>
          <div class="invalid-feedback">${secondNameError}</div>
        </#if>
    </div>
    <div class="form-group">
          <label for="exampleDateOfBirth">Дата рождения</label>
          <input class="form-control ${(dateOfBirthError??)?string('is-invalid','')}" type="date" name="dateOfBirth" placeholder="Дата рождения" id="exampleDateOfBirth">
        <#if dateOfBirthError??>
          <div class="invalid-feedback">${dateOfBirthError}</div>
        </#if>
    </div>

    <div class="form-group">
      <select class="custom-select"  name="enterpriseId" required>
        <option value="">Организация</option>
          <#if enterpriseList??>
            <#list enterpriseList as enterprise>
              <option value="${enterprise.id}">${enterprise.name}</option>
            </#list>
          </#if>
      </select>
      <#if enterpriseIdError??>
        <div class="invalid-feedback">${enterpriseIdError}</div>
      </#if>
    </div>
  </#if>
  <button class="btn btn-primary" type="submit">Сохранить</button>
</form>
</@c.page>