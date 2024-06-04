<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%
    // Verificamos si el usuario está logueado y tiene el rol de docente
    if (session.getAttribute("rol") == null || !session.getAttribute("rol").equals("docente")) {
         response.sendRedirect("../index.jsp");
        return;
    }

    String usuario = (String) session.getAttribute("usuario");
%>
<!doctype html>
<html lang="en">
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
            <div class="container-fluid">
                <a class="navbar-brand" href="indexdocente.jsp">Docente Panel</a>
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

        <div class="container mt-5">
            <div class="student-list text-center">
                <h2>Estudiantes Inscritos</h2>
                <ul class="list-group">
                    <%-- Aquí se supone que debes iterar sobre la lista de estudiantes inscritos. Supongamos que tienes una lista en la sesión o puedes consultarla desde la base de datos --%>
                    <%
                        // Ejemplo de lista de estudiantes (esto debería venir de la base de datos)
                        List<String> estudiantes = Arrays.asList("Estudiante 1", "Estudiante 2", "Estudiante 3");
                        for (String estudiante : estudiantes) {
                    %>
                    <li class="list-group-item"><%= estudiante%></li>
                        <%
                            }
                        %>
                </ul>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>
