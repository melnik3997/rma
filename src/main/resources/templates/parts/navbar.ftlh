<#import "login.ftlh" as l >
<#include "sec.ftlh">
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="/">RMA</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="/main">Сообщения</a>
            </li>
            <#if isAdmin>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-toggle="dropdown"
                   aria-haspopup="true" aria-expanded="false">
                    Пользователи
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="/user">Список пользователей</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="/userCreate">Добавление пользователя</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/enterprise">Предприятия</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/settings">Настройки</a>
            </li>
        </#if>
        </ul>
        <form action='/findUserByLastName' class="form-inline my-2 my-lg-0" method="get" enctype='multipart/form-data'>
            <input class="form-control mr-sm-2" type="search" placeholder="Поиск" aria-label="Search" name="userName">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Поиск</button>
        </form>

        <#if isAut>
        <div class=" mr-2 float-right">
            <ul class="navbar-nav mr-auto float-right">
                <li class="nav-item dropdown ml-10">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-toggle="dropdown"
                       aria-haspopup="true" aria-expanded="false">
                        ${name}
                    </a>
                    <div class="dropdown-menu  dropdown-menu-right" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item" href="/user/profile">Профиль</a>
                        <div class="dropdown-divider"></div>
                        <div><@l.logout /></div>
                    </div>
                </li>
            </ul>
        </div>

        <#else>
        <div class="float-right">
            <a class="nav-link-primary ml-2 float-right" href="/login">Авторизация</a>
        </div>
    </#if>


    </div>
</nav>