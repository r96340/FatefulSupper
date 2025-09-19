<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%
    String placesResponse = (String) session.getAttribute("placesResponse");
%>
<html>
<body>
    <%= placesResponse != null ? placesResponse : "No results found." %>
</body>
</html>