<%-- 
    Document   : indexadmin
    Created on : 19/05/2024, 11:06:02 p. m.
    Author     : SMS
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%
    // Verificamos si el usuario está logueado y tiene el rol de administrador
    if (session.getAttribute("rol") == null || !session.getAttribute("rol").equals("admin")) {
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
        <title>Admin Panel</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <style>
            body {
                background-color: #001f3f; /* Fondo azul oscuro */
                color: white;
                font-family: 'Montserrat', sans-serif;
            }
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
            .form-container {
                max-width: 500px;
                margin: 50px auto;
                padding: 20px;
                border-radius: 8px;
                background-color: white;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                color: #001f3f; /* Texto azul oscuro */
            }
            .form-container:hover {
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            }
            .form-container input, .form-container select {
                margin-bottom: 10px;
            }
            .btn-primary {
                background-color: #007bff;
                border-color: #007bff;
            }
            .btn-primary:hover {
                background-color: #0056b3;
                border-color: #0056b3;
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
        <main class="container">
            <div class="form-container">
                <h2 class="text-center">Registrar Nuevo Usuario</h2>
                <form id="registerUserForm" action="../CrearUsuario" method="post">
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre:</label>
                        <input type="text" id="nombre" name="nombre" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="correo" class="form-label">Correo:</label>
                        <input type="email" id="correo" name="correo" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="contrasena" class="form-label">Contraseña:</label>
                        <input type="password" id="contrasena" name="contrasena" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="rol" class="form-label">Rol:</label>
                        <select id="rol" name="rol" class="form-select" required>
                            <option value="docente">Docente</option>
                            <option value="estudiante">Estudiante</option>
                            <option value="admin">Admin</option>
                        </select>
                    </div>
                    <div class="d-grid gap-2">
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#confirmModal">Registrar</button>
                    </div>
                </form>
                <% if (request.getParameter("success") != null) { %>
                <div class="alert alert-success mt-3" role="alert">
                    Usuario registrado exitosamente!
                </div>
                <% } %>
                <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-danger mt-3" role="alert">
                    Error al registrar usuario. Por favor, intenta de nuevo.
                </div>
                <% }%>
            </div>

            <!-- Modal de confirmación -->
            <div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" style="color: black" id="confirmModalLabel">Confirmar Registro</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">

                            <span style="color: black">¿Está seguro que desea registrar este usuario?</span>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="button" class="btn btn-primary" id="confirmButton">Confirmar</button>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script>
            document.getElementById('confirmButton').addEventListener('click', function () {
                document.getElementById('registerUserForm').submit();
            });
        </script>
    </body>
</html>
