<#import "parts/common.ftlh" as c >
<@c.page>
<h5 class=" mb-3 ">График работы пользователя <#if institution??> ${institution.getFullName()}</#if>  </h5>
<#if errorCreate??>
<div class="alert alert-danger" role="alert">
    ${errorCreate}
</div>
</#if>
<form method="post" enctype='multipart/form-data' >
    <div class="form-group">
        <input class="form-control" type="hidden" name="_csrf" value="${_csrf.token}"/>
        <input type="hidden" name="institution" value="<#if institution??> ${institution.id}</#if> "/>
    </div>

<div class="form-group row">
    <label class="col-sm-2 col-form-label">Время работы</label>
    <div class="col-sm-8">
        <input class="form-control ${(workTimeError??)?string('is-invalid','')}"  required type="number" step="0.1" min="1"  max ="12"  name="workTime"  placeholder="Время работы" <#if workSchedule??> value="${workSchedule.workTime}" <#else> <#if workTime??> value="${workTime}" </#if> </#if>>
        <#if workTimeError??>
            <div class="invalid-feedback">${workTimeError}</div>
        </#if>
    </div>
</div>

<div class="form-group row">
    <label class="col-sm-2 col-form-label">Обеденное время</label>
    <div class="col-sm-8">
        <input class="form-control ${(lunchBreakError??)?string('is-invalid','')}" required type="number" step="0.1" min="0.2" max ="1" name="lunchBreak" placeholder="Обеденное время" <#if workSchedule??> value="${workSchedule.lunchBreak}" <#else> <#if lunchBreak??> value="${lunchBreak}" </#if> </#if>>
<#if lunchBreakError??>
<div class="invalid-feedback">${lunchBreakError}</div>
</#if>
</div>
</div>

<div class="form-group">
    <div class="form-check">
        <input class="form-check-input" type="checkbox" id="lunchBreakIn" name="lunchBreakIn"
        <#if workSchedule??> ${(workSchedule.lunchBreakIn)?string('checked','')}  <#else> <#if lunchBreakIn??> ${(lunchBreakIn)?string('checked','')} </#if> </#if> />
        <label class="form-check-label" for="lunchBreakIn">
            Время обеда входит в рабочее время
        </label>
    </div>
</div>

<div class="form-group row">
    <label class="col-sm-2 col-form-label">Время начала</label>
    <div class="col-sm-8">
        <input class="form-control ${(timeBeginError??)?string('is-invalid','')}" required type="text"  name="timeBeginS" placeholder="Время начала"  id="exampleTimeBegin" >
        <#if timeBeginError??>
          <div class="invalid-feedback">${timeBeginError}</div>
        </#if>
    </div>

</div>

<div class="form-group row">
    <label class="col-sm-2 col-form-label">Время окончания</label>
    <div class="col-sm-8">
        <input class="form-control ${(timeFinishError??)?string('is-invalid','')}" required type="text" name="timeFinishS" placeholder="Время окончания"  id="exampleTimeFinish" >

    <#if timeFinishError??>
    <div class="invalid-feedback">${timeFinishError}</div>
</#if>
</div>
</div>

<div class="form-group">
    <div class="form-check">
        <input class="form-check-input" type="checkbox" id="active" name="active"
        <#if workSchedule??> ${(workSchedule.active)?string('checked','')}  <#else> <#if active??> ${(active)?string('checked','')} </#if> </#if> />
        <label class="form-check-label" for="active">
            Активный
        </label>
    </div>
</div>


<button class="btn btn-primary" type="submit">Сохранить</button>
</form>

<script type="text/javascript">
               jQuery.datetimepicker.setLocale('ru');
               $('#exampleTimeBegin').datetimepicker({
                   datepicker:false,
                   format:'H:i',
                   defaultTime:'10:00'
                   <#if workSchedule??>,value: '${workSchedule.timeBegin}' <#else> <#if timeBeginS??> ,value:"${timeBeginS}" </#if> </#if>
                   ,mask: true
               });


               jQuery.datetimepicker.setLocale('ru');
               $('#exampleTimeFinish').datetimepicker({
                   datepicker:false,
                   format:'H:i',
                   defaultTime:'17:00'
                   <#if workSchedule??>,value: '${workSchedule.timeFinish}' <#else> <#if timeFinishS??> ,value:"${timeFinishS}" </#if> </#if>
                   ,mask: true
               });

</script>


</@c.page>