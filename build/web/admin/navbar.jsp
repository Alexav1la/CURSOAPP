<%-- 
    Document   : navbar
    Created on : 22/05/2024, 7:45:46 p. m.
    Author     : SMS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@ page session="true" %>
<%
    // Verificar si el usuario tiene rol de admin
    if (session.getAttribute("rol") == null || !session.getAttribute("rol").equals("admin")) {
        response.sendRedirect("../index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
                        .main-header {
                background-color: #343a40;
                color: white;
            }
            .navbar-brand, .nav-link, .navbar-toggler-icon {
                color: white;
            }
            .navbar-brand:hover, .nav-link:hover, .dropdown-item:hover {
                color: #ffdd57;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark main-header">
            <div class="container-fluid">
                <a class="navbar-brand" href="indexadmin.jsp">Admin Panel</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNavDropdown">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="inscribirestudiantes.jsp">Inscribir Estudiantes</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="cursos.jsp">Cursos y Asignaturas</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="listadoMatriculados.jsp">Listado de Matriculados</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <%= usuario%>
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                                <li><a class="dropdown-item" href="perfil.jsp">Ver Perfil</a></li>
                                <li><a class="dropdown-item" href="logout.jsp">Cerrar Sesión</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </body>
</html>
