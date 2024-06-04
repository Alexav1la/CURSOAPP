<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="conexion.ConexionBD" %>
<%@ page session="true" %>
<%
    // Verificar si el usuario tiene rol de admin
    if (session.getAttribute("rol") == null || !session.getAttribute("rol").equals("admin")) {
        response.sendRedirect("../index.jsp");
        return;
    } 
      String usuario = (String) session.getAttribute("usuario");

    Connection con = null;
    PreparedStatement psCursos = null;
    ResultSet rsCursos = null;
    PreparedStatement psEstudiantes = null;
    ResultSet rsEstudiantes = null;

    try {
        con = ConexionBD.Conexion();

        // Consultar todos los cursos
        String sqlCursos = "SELECT * FROM curso";
        psCursos = con.prepareStatement(sqlCursos);
        rsCursos = psCursos.executeQuery();

        // Consultar todos los estudiantes
        String sqlEstudiantes = "SELECT * FROM usuario WHERE rol = 'estudiante'";
        psEstudiantes = con.prepareStatement(sqlEstudiantes);
        rsEstudiantes = psEstudiantes.executeQuery();
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Inscribir Estudiantes</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <style>
            body {
                background-color: #001f3f; /* Fondo azul oscuro */
                color: #ffffff; /* Texto blanco */
                font-family: 'Montserrat', sans-serif;
            }
            .container {
                max-width: 600px; /* Ancho máximo del formulario */
                margin: 100px auto; /* Centrar vertical y horizontalmente */
                padding: 30px;
                border-radius: 8px;
                background-color: #ffffff;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
                color: #001f3f; /* Texto azul oscuro */
                position: relative;
            }
            .container:hover {
                box-shadow: 0 0 25px rgba(0, 0, 0, 0.3); /* Sutil efecto de sombra al pasar el mouse */
            }
            .btn-primary {
                background-color: #0069d9; /* Azul */
                border-color: #0069d9;
                transition: background-color 0.3s ease, border-color 0.3s ease;
            }
            .btn-primary:hover {
                background-color: #0056b3; /* Azul más oscuro al pasar el mouse */
                border-color: #0056b3;
            }
            h1 {
                text-align: center;
                margin-bottom: 20px;
                font-weight: 700;
            }
            .form-label {
                font-weight: 600;
            }
            .form-select {
                padding: 10px;
                border-radius: 5px;
                border: 2px solid #001f3f;
            }
            .back-button-container {
                position: absolute;
                top: 20px;
                right: 20px;
            }
            .back-button {
                background-color: #0056b3; /* Azul más oscuro */
                border-color: #0056b3;
                color: white;
                transition: background-color 0.3s ease, border-color 0.3s ease;
            }
            .back-button:hover {
                background-color: #003d7a;
                border-color: #003d7a;
            }
        </style>
    </head>
    <body>
        <%@include file="navbar.jsp" %>

        <div class="container mt-5">

            <h1>Inscribir Estudiantes</h1>
            <form id="inscripcionForm" action="../inscribirCurso" method="post">
                <div class="mb-3">
                    <label for="cursoSelect" class="form-label">Seleccionar Curso:</label>
                    <select name="idCurso" id="cursoSelect" class="form-select" required>
                        <option value="">Seleccione un curso</option>
                        <% while (rsCursos.next()) {%>
                        <option value="<%= rsCursos.getInt("id")%>"><%= rsCursos.getString("nombre")%></option>
                        <% } %>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="estudianteSelect" class="form-label">Seleccionar Estudiante:</label>
                    <select name="idEstudiante" id="estudianteSelect" class="form-select" required>
                        <option value="">Seleccione un estudiante</option>
                        <% while (rsEstudiantes.next()) {%>
                        <option value="<%= rsEstudiantes.getInt("id")%>"><%= rsEstudiantes.getString("nombre")%></option>
                        <% } %>
                    </select>
                </div>
                <button type="button" class="btn btn-primary w-100" data-bs-toggle="modal" data-bs-target="#confirmModal">Inscribir Estudiante</button>
            </form>
        </div>

        <!-- Modal de Confirmación -->
        <div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" style="color: black" id="confirmModalLabel">Confirmar Inscripción</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <span style="color: black">¿Estás seguro de que deseas inscribir al estudiante en este curso?</span>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-primary" id="confirmButton">Confirmar</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script>
            document.getElementById('confirmButton').addEventListener('click', function () {
                document.getElementById('inscripcionForm').submit();
            });
        </script>
    </body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rsCursos != null) {
            rsCursos.close();
        }
        if (psCursos != null) {
            psCursos.close();
        }
        if (rsEstudiantes != null) {
            rsEstudiantes.close();
        }
        if (psEstudiantes != null) {
            psEstudiantes.close();
        }
        if (con != null) {
            con.close();
        }
    }
%>
