<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%
    // Verificamos si el usuario está logueado y tiene el rol de administrador
    if (session.getAttribute("usuario") == null || !"docente".equals(session.getAttribute("rol"))) {
         response.sendRedirect("../index.jsp");
        return;
    }

    String usuario = (String) session.getAttribute("usuario");
    String rol = (String) session.getAttribute("rol");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Perfil del Docente</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <style>
            body {
                background-color: #001f3f; /* Fondo azul oscuro */
                color: #ffffff; /* Texto blanco */
                font-family: 'Montserrat', sans-serif;
            }
            .profile-container {
                max-width: 600px;
                margin: 50px auto;
                padding: 20px;
                border-radius: 10px;
                background-color: #ffffff; /* Fondo blanco */
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .profile-container h1 {
                text-align: center;
                margin-bottom: 30px;
            }
            .profile-details {
                margin-bottom: 20px;
            }
            .profile-details p {
                font-size: 1.2em;
                margin-bottom: 10px;
            }
            .btn-back {
                display: block;
                width: 100%;
                text-align: center;
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container mt-5 profile-container">
            <h1 style="color: black">Perfil del Administrador</h1>
            <div class="profile-details">
                <p style="color: black"><strong style="color: black">Usuario:</strong> <%= usuario%></p>
                <p style="color: black"><strong style="color: black">Rol:</strong> <%= rol%></p>
                <!-- Agrega más detalles del perfil aquí -->
            </div>
            <a href="indexdocente.jsp" class="btn btn-primary btn-back" >Volver</a>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>
