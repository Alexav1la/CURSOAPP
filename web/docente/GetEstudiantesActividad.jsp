<%@ page import="java.sql.*" %>
<%@ page import="conexion.ConexionBD" %>
<%@ page session="true" %>
<%
    if (session.getAttribute("rol") == null || !session.getAttribute("rol").equals("docente")) {
        response.sendRedirect("login.jsp");
        return;
    }

    int idActividad = Integer.parseInt(request.getParameter("idActividad"));
    Connection con = ConexionBD.Conexion();

    String sqlEstudiantes = "SELECT ae.id_estudiante, u.nombre, ae.respuesta, ae.calificacion "
            + "FROM actividad_estudiante ae "
            + "JOIN usuario u ON ae.id_estudiante = u.id "
            + "WHERE ae.id_actividad = ?";
    PreparedStatement psEstudiantes = con.prepareStatement(sqlEstudiantes);
    psEstudiantes.setInt(1, idActividad);
    ResultSet rsEstudiantes = psEstudiantes.executeQuery();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calificaciones de Estudiantes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
     
        .container {
            max-width: 600px; /* Ancho máximo del contenido */
            margin: 50px auto; /* Centrar vertical y horizontalmente */
        }
        .list-group-item h5 {
            color: #000000; 
        }
        .list-group-item p {
            margin-bottom: 0; /* Eliminar margen inferior */
        }
        form {
            margin-top: 10px; /* Espacio superior para el formulario */
        }
        input[type="text"] {
            width: 80px; /* Ancho del campo de calificación */
        }
          .navbar {
                background-color: rgba(255, 255, 255, 0.8) !important;
        }


    </style>
</head>
<body>

    <div class="container">
        <h1 style="color: white" class="text-center">Calificaciones de Estudiantes</h1>
        <ul class="list-group">
            <% while (rsEstudiantes.next()) {
                    int calificacion = rsEstudiantes.getInt("calificacion");
                    String calificacionStr = (rsEstudiantes.wasNull()) ? "0" : String.valueOf(calificacion);
            %>
            <li class="list-group-item">
                <h5 ><%= rsEstudiantes.getString("nombre")%></h5>
                <p>Respuesta: <%= rsEstudiantes.getString("respuesta")%></p>
                <form action="../CalificarActividad" method="post">
                    <input type="hidden" name="idEstudiante" value="<%= rsEstudiantes.getInt("id_estudiante")%>">
                    <input type="hidden" name="idActividad" value="<%= idActividad%>">
                    <input type="text" name="calificacion" value="<%= calificacionStr%>" required class="form-control mb-2">
                    <button type="submit" class="btn btn-success">Calificar</button>
                </form>
            </li>
            <% } %>
        </ul>
    </div>
</body>
</html>
<%
    rsEstudiantes.close();
    psEstudiantes.close();
    con.close();
%>

