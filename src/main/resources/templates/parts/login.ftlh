<#macro login path isRegForm>
<form action="${path}" method="post" >
    <div class="form-group row">
        <label  class="col-sm-2 col-form-label">Имя пользователя:</label>
        <div class="col-sm-6">
            <input type="text" name="username"  class="form-control"/>
        </div>
    </div>

    <div class="form-group row">
        <label  class="col-sm-2 col-form-label">Пароль:</label>
        <div class="col-sm-6">
            <input type="password" name="password"  class="form-control"/>
        </div>
    </div>
    <#if isRegForm>
        <div class="form-group row">
            <label  class="col-sm-2 col-form-label">E-mail:</label>
            <div class="col-sm-6">
                <input type="email" name="email" class="form-control" />
            </div>
        </div>
    </#if>

    <input type="hidden" name="_csrf" value="${_csrf.token}"/>

    <div class="form-group row">
        <div class="col-sm-10">
          <button type="submit" class="btn btn-primary"><#if isRegForm> Зарегистрироваться <#else> Войти </#if></button>
        </div>
    </div>
    <#if !isRegForm>
        <a href = "/registration">Добавить нового пользователя</a>
    </#if>
</form>
</#macro>

<#macro logout>
<form action="/logout" method="post">
    <button type="submit"  class="btn btn-primary">Выйти</button>
    <!--<input type="submit" class="nav-item" value="Выйти"/>-->
    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
</form>
</#macro>