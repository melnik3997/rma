<#import "parts/common.ftlh" as c >
<@c.page>
<h5 class=" mb-3 ">Добавление заявки <#if bidRule??> ${bidRule.name}</#if>  </h5>
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
        <label class="col-sm-2 col-form-label">Дата</label>
        <div class="col-sm-8">
            <input class="form-control ${(dateError??)?string('is-invalid','')}" type="text" name="date" placeholder="Дата"  id="exampleDate" >
            <#if dateError??>
                <div class="invalid-feedback">${dateError}</div>
            </#if>
        </div>
    </div>   

<div class="form-group row">
    <label class="col-sm-2 col-form-label">Время ухода</label>
    <div class="col-sm-8">
        <input class="form-control ${(timeLeaveError??)?string('is-invalid','')}" required type="text"  name="timeLeave" placeholder="Время ухода"  id="exampleTimeLeave" >
        <#if timeLeaveError??>
            <div class="invalid-feedback">${timeLeaveError}</div>
        </#if>
</div>

</div>
    

    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Комментарий</label>
        <div class="col-sm-8">
            <textarea class="form-control ${(commentError??)?string('is-invalid','')}" type="text" name="comment"   rows="3"><#if comment??>${comment}</#if></textarea>
            <#if commentError??>
                <div class="invalid-feedback">${commentError}</div>
            </#if>
        </div>
    </div>


<button class="btn btn-primary" type="submit">Сохранить</button>
</form>

<script type="text/javascript">
               jQuery.datetimepicker.setLocale('ru');
               $('#exampleTimeLeave').datetimepicker({
                   datepicker:false,
                   format:'H:i',
                   defaultTime:'10:00'
                    <#if timeLeave??> ,value:"${timeLeave}" </#if>
                   ,mask: true
               });
               
                   
               jQuery.datetimepicker.setLocale('ru');
               $('#exampleDate').datetimepicker({
                   timepicker: false,
                   datepicker: true,
                   format: 'd.m.Y'
                   <#if dateS??> ,value:"${dateS}" </#if>
                   ,mask: true
               });
     

</script>


</@c.page>