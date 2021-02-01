<#import "parts/common.ftlh" as c >
<@c.page>
<div class="form-row">
    <div class="col-md-4 mb-3 ">
        <form class="form-inline" method="get" action="/main" enctype='multipart/form-data'>
            <input type="text" name="filter" class="form-control mr-3"  value="${filter!}">
            <button type="submit" class="btn btn-primary">Найти</button>
        </form>
    </div>
</div>
<a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
  Добавить сообщение
</a>
<div class="collapse <#if message??>show</#if>" id="collapseExample">
    <div class="form-group">
        <form method="post" enctype='multipart/form-data' >
            <div class="form-group">
                <input class="form-control" type="hidden" name="_csrf" value="${_csrf.token}"/>
            </div>
            <div class="form-group">
                <input class="form-control ${(textError??)?string('is-invalid','')}" type="text" name="text" placeholder="Введите сообщение">
                <#if textError??>
                  <div class="invalid-feedback">${textError}</div>
                </#if>
            </div>
            <div class="form-group">
                <input class="form-control" type="text" name="tag" placeholder="tag">
            </div>
            <div class="form-group">
                <div class="custom-file">
                    <input class="custom-file-input" type="file" name="file" id="customFile" >
                    <label class="custom-file-label" for="customFile">Добавить изображение</label>
                </div>
            </div>
            <button class="btn btn-primary" type="submit">Добавить</button>
        </form>
    </div>
</div>
<div class="card-columns">
<#list messages as message>
    <div class="card my-3">
        <#if message.fileName??>
            <img class="card-img-top" src="/img/${message.fileName}">
        </#if>
        <div class="m-2">
            <h5 class="card-title">${message.tag}</h5>
            <p class="card-text">${message.text}</p>
        </div>

        <div class="card-footer text-muted">
            ${message.authorName}</strong>
        </div>
    </div>
<#else>
    Нет сообщений
</#list>
</div>
</@c.page>