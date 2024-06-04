<%-- 
    Document   : logout
    Created on : 19/05/2024, 11:06:02 p. m.
    Author     : SMS
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%
    session.invalidate(); // Invalidamos la sesión
    response.sendRedirect("../index.jsp"); // Redirigimos al usuario a la página de login
%>
