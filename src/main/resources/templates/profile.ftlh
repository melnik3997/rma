<#import "parts/common.ftlh" as c >

<@c.page>
<h5>${username!}</h5>
${message!}

<form  method="post" >

    <div class="form-group row">
        <label  class="col-sm-2 col-form-label">Пароль:</label>
        <div class="col-sm-6">
            <input type="password" name="password"  class="form-control"/>
        </div>
    </div>

     <div class="form-group row">
         <label  class="col-sm-2 col-form-label">E-mail:</label>
         <div class="col-sm-6">
             <input type="email" name="email"  class="form-control" value = "${email!''}"/>
         </div>
     </div>

    <input type="hidden" name="_csrf" value="${_csrf.token}"/>

    <div class="form-group row">
        <div class="col-sm-10">
          <button type="submit" class="btn btn-primary">Сохранить</button>
        </div>
    </div>

</form>

</@c.page>