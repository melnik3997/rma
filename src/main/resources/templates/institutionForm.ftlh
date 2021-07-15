<#import "parts/common.ftlh" as c >
<@c.page>
<h5 class=" mb-3 ">Основная информация о пользователе</h5>

<form method="post" enctype='multipart/form-data' >
  <div class="form-group">
      <input class="form-control" type="hidden" name="_csrf" value="${_csrf.token}"/>
      <input type="hidden" name="userId" value="${userId}"/>
      <input class="form-control" type="hidden" name="institutionId"  <#if institution??> value="${institution.id}" </#if>>
  </div>
    <div class="form-group row">
      <label class="col-sm-2 col-form-label">Фамилия</label>
      <div class="col-sm-8">
        <input class="form-control ${(lastNameError??)?string('is-invalid','')}" id = "lastName" type="text" name="lastName" placeholder="Фамилия" <#if institution??> value="${institution.lastName}"<#else> <#if lastName??> value="${lastName}" </#if> </#if>>
        <#if lastNameError??>
          <div class="invalid-feedback">${lastNameError}</div>
        </#if>
      </div>
    </div>
    <div class="form-group row">
      <label class="col-sm-2 col-form-label">Имя</label>
      <div class="col-sm-8">
        <input class="form-control ${(firstNameError??)?string('is-invalid','')}" id = "firstName" type="text" name="firstName" placeholder="Имя" <#if institution??> value="${institution.firstName}" <#else> <#if firstName??> value="${firstName}" </#if> </#if>>
         <#if firstNameError??>
           <div class="invalid-feedback">${firstNameError}</div>
         </#if>
      </div>
    </div>
    <div class="form-group row">
      <label class="col-sm-2 col-form-label">Отчество</label>
      <div class="col-sm-8">
        <input class="form-control ${(secondNameError??)?string('is-invalid','')}" type="text" name="secondName" placeholder="Отчество" <#if institution??> value="${institution.secondName}" <#else> <#if secondName??> value="${secondName}" </#if> </#if>>
        <#if secondNameError??>
          <div class="invalid-feedback">${secondNameError}</div>
        </#if>
      </div>
    </div>
    <div class="form-group row">
      <label class="col-sm-2 col-form-label">Дата рождения</label>
      <div class="col-sm-8">
        <input class="form-control ${(dateOfBirthError??)?string('is-invalid','')}" type="text" name="dateOfBirthS" placeholder="Дата рождения"  id="exampleDateOfBirth" >
      </div>
      <#if dateOfBirthError??>
        <div class="invalid-feedback">${dateOfBirthError}</div>
      </#if>
      <script type="text/javascript">
               jQuery.datetimepicker.setLocale('ru');
               $('#exampleDateOfBirth').datetimepicker({
                   timepicker: false,
                   datepicker: true,
                   format: 'd.m.Y'
                   <#if institution??>,value: '${institution.dateOfBirth?datetime}' <#else> <#if dateOfBirth??> ,value:"${dateOfBirth?datetime}" </#if> </#if>
                   ,mask: true
               });
      </script>
    </div>
    <div class="form-group row">
      <label class="col-sm-2 col-form-label">Номер телефона</label>
      <div class="col-sm-8">
        <input class="form-control ${(firstPhoneNumber??)?string('is-invalid','')}" id = "phoneNumber" type="text" name="phoneNumber" placeholder="Номер телефона" <#if institution??> <#if institution.phoneNumber??> value="${institution.phoneNumber}" </#if> <#else> <#if phoneNumber??> value="${phoneNumber}" </#if> </#if>>
         <#if firstPhoneNumber??>
           <div class="invalid-feedback">${firstPhoneNumber}</div>
         </#if>
      </div>
    </div>
    <div class="form-group row">
      <label class="col-sm-2 col-form-label">Skype</label>
      <div class="col-sm-8">
        <input class="form-control ${(firstSkypeName??)?string('is-invalid','')}" id = "skypeName" type="text" name="skypeName" placeholder="Skype" <#if institution??> <#if institution.skypeName??> value="${institution.skypeName}" </#if> <#else> <#if skypeName??> value="${skypeName}" </#if> </#if>>
         <#if firstSkypeName??>
           <div class="invalid-feedback">${firstSkypeName}</div>
         </#if>
      </div>
    </div>
    <div class="form-group row">
      <label class="col-sm-2 col-form-label">Организация</label>
      <div class="col-sm-8">
        <select class="custom-select"  name="enterpriseId" required>
          <option value="">Организация</option>
            <#if enterpriseList??>
              <#list enterpriseList as enterprise>
                <option <#if institution??> <#if enterprise.id == institution.enterpriseID> selected </#if> </#if> value="${enterprise.id} ">${enterprise.name}</option>
              </#list>
            </#if>
        </select>

        <#if enterpriseIdError??>
          <div class="invalid-feedback">${enterpriseIdError}</div>
        </#if>
      </div>
    </div>
<div class="form-group  row">
  <label class="col-sm-2 col-form-label">Фото</label>
  <div class="col-sm-8">
  <div class="custom-file">
    <input class="custom-file-input" type="file" name="file" id="customFile">
    <label class="custom-file-label" for="customFile">Добавить изображение</label>
  </div>
  </div>
</div>
  <button class="btn btn-primary" type="submit">Сохранить</button>
</form>
</@c.page>