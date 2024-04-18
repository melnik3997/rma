<#import "login.ftlh" as l >
<#include "sec.ftlh">
<style type="text/css">
.dropdown-submenu {
position: relative;
}

.dropdown-submenu a::after {
transform: rotate(-90deg);
position: absolute;
right: 6px;
top: .8em;
}

.dropdown-submenu .dropdown-menu {
top: 0;
left: 100%;
margin-left: .1rem;
margin-right: .1rem;
}
</style>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="/">RMA</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
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
            </#if>
            <#if isAdmin>
                <li class="nav-item">
                    <a class="nav-link" href="/enterprise">Предприятия</a>
                </li>
            </#if>
            <#if isAdmin>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-toggle="dropdown"
                       aria-haspopup="true" aria-expanded="false">
                        Настройки
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                        <li><a class="dropdown-item" href="/settings">Системные настройки</a></li>
                        <li class="dropdown-divider"></li>
                        <li class="dropdown-submenu">
                            <a class="dropdown-item dropdown-toggle" href="#">Системные справочники</a>
                            <ul class="dropdown-menu">
                                <li> <a class="dropdown-item" href="/post">Должности</a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
            </#if>
            <#if isAdmin>
                <li class="nav-item">
                    <a class="nav-link" href="/calendar">Календарь</a>
                </li>
            </#if>
            <li class="nav-item">
                <a class="nav-link" href="/bid">Заявки</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/schedule">График работы</a>
            </li>
            <#if isLieder>
                <li class="nav-item">
                    <a class="nav-link" href="/leaderPanel">Панель руководителя</a>
                </li>
            </#if>
            <#if isManager>
                <li class="nav-item">
                    <a class="nav-link" href="/managerPanel">Управление организацией</a>
                </li>
            </#if>
        </ul>
        <form action='/findUserByLastName' class="form-inline my-2 my-lg-0" method="get" enctype='multipart/form-data'>
            <input class="form-control mr-sm-2" type="search" placeholder="Поиск" aria-label="Search" name="userName" <#if findValue??>value="${findValue}" </#if> >
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

<script>
$('.dropdown-menu a.dropdown-toggle').on('click', function(e) {
  if (!$(this).next().hasClass('show')) {
    $(this).parents('.dropdown-menu').first().find('.show').removeClass("show");
  }
  var $subMenu = $(this).next(".dropdown-menu");
  $subMenu.toggleClass('show');


  $(this).parents('li.nav-item.dropdown.show').on('hidden.bs.dropdown', function(e) {
    $('.dropdown-submenu .show').removeClass("show");
  });


  return false;
});
</script>