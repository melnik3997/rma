<#import "parts/common.ftlh" as c >
<@c.page>
<h5 class=" mb-3 ">Добавление календаря <#if enterpriseName??> ${enterpriseName}</#if></h5>
<#if errorCreate??>
<div class="alert alert-danger" role="alert">
    ${errorCreate}
</div>
</#if>
<form method="post" enctype='multipart/form-data' >
  <div class="form-group">
      <input class="form-control" type="hidden" name="_csrf" value="${_csrf.token}"/>
  </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Год</label>
        <div class="col-sm-8">
            <input class="form-control ${(yearError??)?string('is-invalid','')}" required id = "year" type="text" name="year" placeholder="Год"  <#if year??> value="${year}" </#if> >
            <#if yearError??>
            <div class="invalid-feedback">${yearError}</div>
            </#if>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Тип календаря</label>
        <div class="col-sm-8">
            <select class="custom-select"  name="calendarType" required>
                <option value="">Тип календаря</option>
                <#if calendarTypeList??>
                    <#list calendarTypeList as calendarType>
                        <option <#if calendarTypeStr??> <#if calendarType == calendarTypeStr> selected </#if> </#if> value="${calendarType}">${calendarType.getName()}</option>
                    </#list>
                </#if>
            </select>
            <#if enterpriseIdError??>
                <div class="invalid-feedback">${calendarTypeError}</div>
            </#if>
        </div>
    </div>
  <button class="btn btn-primary" type="submit">Добавить</button>
</form>

</@c.page>