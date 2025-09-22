<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<nobr>
<%
    String sqlOutput = (String) session.getAttribute("sqlOutput");
    if (sqlOutput != null) {
        out.print(sqlOutput);
    } else {
        out.print("<p>Error</p>");
    }
%>
</nobr>