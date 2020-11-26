<#import "parts/common.ftlh" as c >
<#import "parts/login.ftlh" as l >
<@c.page>
<@l.logout />
<span><a href="/user">Список пользователей</a></span>
    <div>
        <form method="post" enctype='multipart/form-data'>
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <input type="text" name="text" placeholder="Введите сообщение">
            <input type="text" name="tag" placeholder="tag">
            <input type="file" name="file" >
            <button type="submit">Добавить</button>
        </form>
    </div>
    <div>Список сообщений</div>
    <form method="get" action="/main" enctype='multipart/form-data'>
        <input type="text" name="filter" value="${filter!}">
        <button type="submit">Найти</button>
    </form>
    <#list messages as message>
        <div>
          <b>${message.id}</b>
          <span>${message.text}</span>
           <i>${message.tag}</i>
           <strong>${message.authorName}</strong>
           <div>
                <#if message.fileName??>
                    <img src="/img/${message.fileName}">
                </#if>
           </div>
        </div>
    <#else>
        Нет сообщений
    </#list>
</@c.page>