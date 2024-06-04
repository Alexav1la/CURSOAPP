<%-- 
    Document   : listadoMatriculados
    Created on : 20/05/2024, 3:24:25 p. m.
    Author     : SMS
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="conexion.ConexionBD" %>
<%@ page session="true" %>
<%
    if (session.getAttribute("rol") == null || !session.getAttribute("rol").equals("admin")) {
        response.sendRedirect("../index.jsp");
        return;
    }
    String usuario = (String) session.getAttribute("usuario");
    Connection con = ConexionBD.Conexion();

    String sql = "SELECT u.nombre AS estudiante, c.nombre AS curso "
            + "FROM usuario u "
            + "JOIN curso_estudiante ce ON u.id = ce.id_estudiante "
            + "JOIN curso c ON ce.id_curso = c.id "
            + "WHERE u.rol = 'estudiante'";

    PreparedStatement ps = con.prepareStatement(sql);
    ResultSet rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Listado de Matriculados</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <style>
            body {
                background-color: #001f3f; /* Fondo azul oscuro */
                color: #ffffff; /* Texto blanco */
                font-family: Arial, sans-serif;
            }
            .container {
                max-width: 800px; /* Ancho máximo del contenedor */
                margin: 50px auto; /* Centrar vertical y horizontalmente */
                padding: 20px;
                border-radius: 8px;
                background-color: #ffffff; /* Fondo blanco */
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                color: #001f3f; /* Texto azul oscuro */
                position: relative; /* Para posicionar el botón de regreso */
            }
            .back-button {
                position: absolute;
                top: 20px;
                right: 20px;
            }
            h1 {
                text-align: center;
                margin-bottom: 20px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            table, th, td {
                border: 1px solid #001f3f; /* Bordes de la tabla */
            }
            th, td {
                padding: 12px; /* Espaciado dentro de las celdas */
                text-align: center; /* Texto centrado */
                font-size: 1.1em; /* Tamaño de letra más grande */
            }
            th {
                background-color: #001f3f; /* Fondo azul oscuro para el encabezado */
                color: #ffffff; /* Texto blanco para el encabezado */
            }
            tr:nth-child(even) {
                background-color: #f2f2f2; /* Fondo gris claro para filas pares */
            }
        </style>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <div class="container">
            <h1>Listado de Matriculados</h1>
            <table>
                <thead>
                    <tr>
                        <th>Estudiante</th>
                        <th>Curso</th>
                    </tr>
                </thead>
                <tbody>
                    <% while (rs.next()) {%>
                    <tr>
                        <td><%= rs.getString("estudiante")%></td>
                        <td><%= rs.getString("curso")%></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>
<%
    if (rs != null) {
        rs.close();
    }
    if (ps != null) {
        ps.close();
    }
    if (con != null)
        con.close();
%>
