<#assign
    know = Session.SPRING_SECURITY_CONTEXT??
>

<#if know>
    <#assign
        user = Session.SPRING_SECURITY_CONTEXT.authentication.principal
        name = user.getUsername()
        isAdmin = user.isAdmin()
        isLieder = user.isLieder()
        isAut = true
    >

<#else>
    <#assign
        name = "unknown"
        isAdmin = false
        isLieder = false
        isAut = false
    >
</#if>