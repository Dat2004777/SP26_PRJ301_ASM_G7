<%-- 
    Document   : list-site
    Created on : 23 Feb 2026, 22:41:56
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}${sessionScope.rolePrefix}"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    
    <body>
        <a href="${ctx}/site/add">
            Thêm
        </a>
        
        
    </body>
</html>
