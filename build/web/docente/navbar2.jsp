<%-- 
    Document   : navbar2
    Created on : 22/05/2024, 12:20:12 p. m.
    Author     : Leonel Alvarez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Docente Panel</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <style>
            body {
                background-image: url('../imagenes/choosing-bg.jpg'); /* Ruta de la imagen de fondo */
                background-size: cover;
                background-repeat: no-repeat;
                background-attachment: fixed;
            }
            .student-list {
                background-color: rgba(255, 255, 255, 0.8); /* Fondo blanco semitransparente */
                border-radius: 10px;
                padding: 20px;
                max-width: 600px;
                margin: 0 auto;
            }
            .navbar {
                background-color: rgba(255, 255, 255, 0.8) !important;
            }
        </style>
    </head>
    <body>
        
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            
            <a style="padding-left: 12px" class="navbar-brand" href="indexdocente.jsp">Docente Panel</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNavDropdown">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="cursos.jsp">Asignar actividades</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="calificar.jsp">Calificar Actividades</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <%= usuario %>
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                                <li><a class="dropdown-item" href="perfil.jsp">Ver Perfil</a></li>
                                <li><a class="dropdown-item" href="logout.jsp">Cerrar Sesión</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
           
        </nav>
    </body>
</html>
