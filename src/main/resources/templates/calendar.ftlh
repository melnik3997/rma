<#import "parts/common.ftlh" as c >
<@c.page>
<h5 class=" mb-3 ">${calendarType} календарь предприятия <#if year??> за ${year?c} год</#if> </h5>

<div id="CalendarYear">
</div>

<script> var tocken = '${_csrf.token}'
         <#if calendarEnterprise??>
            var paramCalendar = new Map;
            paramCalendar.set("calendarEnterpriseId",'${calendarEnterprise.id?c}');
         </#if>

</script>
<script src="/js/calendarYear.js"> </script>

</@c.page>