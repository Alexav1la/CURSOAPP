<%-- 
    Document   : cursos
    Created on : 19/05/2024, 11:26:33 p. m.
    Author     : SMS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="conexion.ConexionBD" %>
<%@ page session="true" %>
<%
    if (session.getAttribute("rol") == null || !session.getAttribute("rol").equals("admin")) {
        response.sendRedirect("../index.jsp");
        return;
    }
    String usuario = (String) session.getAttribute("usuario");
    Connection con = null;
    PreparedStatement psCursos = null;
    ResultSet rsCursos = null;
    PreparedStatement psDocentes = null;
    ResultSet rsDocentes = null;

    try {
        con = ConexionBD.Conexion();

        // Consultar todos los cursos
        String sqlCursos = "SELECT * FROM curso";
        psCursos = con.prepareStatement(sqlCursos);
        rsCursos = psCursos.executeQuery();

        // Consultar todos los docentes
        String sqlDocentes = "SELECT * FROM usuario WHERE rol = 'docente'";
        psDocentes = con.prepareStatement(sqlDocentes);
        rsDocentes = psDocentes.executeQuery();
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Mis Cursos</title>
        <script src="https://kit.fontawesome.com/465418070e.js" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <style>
            body {
                background-color: #001f3f; /* Fondo azul oscuro */
                color: #ffffff; /* Texto blanco */
                font-family: 'Montserrat', sans-serif;
            }
            .container {
                max-width: 800px;
                margin: 50px auto;
                padding: 20px;
                border-radius: 8px;
                background-color: #ffffff;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            h1 {
                text-align: center;
                margin-bottom: 20px;
            }
            form {
                text-align: center;
            }
            .back-button {
                position: absolute;
                top: 20px;
                right: 20px;
            }
            .course-details {
                padding: 10px;
                margin-top: 10px;
                background-color: #f1f1f1;
                border-radius: 5px;
            }
            .course-link {
                cursor: pointer;
                text-decoration: none;
                color: #007bff;
            }
            .course-link:hover {
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <div class="container">
         
            <h1 style="color: black">Mis Cursos</h1>
            <form id="createCourseForm" action="../CrearCurso" method="post">
                <input type="text" name="nombre" placeholder="Nombre del curso" required class="form-control mb-3">
                <select name="idDocente" class="form-select mb-3" required>
                    <option value="">Seleccione un docente</option>
                    <%                        while (rsDocentes.next()) {
                    %>
                    <option value="<%= rsDocentes.getInt("id")%>"><%= rsDocentes.getString("nombre")%></option>
                    <%
                        }
                    %>
                </select>
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#confirmModal">Crear Curso</button>
            </form>

            <!-- Modal de confirmación -->
            <div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" style="color: black" id="confirmModalLabel">Confirmar Creación</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">

                            <span style="color: black">¿Está seguro de que desea crear este curso?</span>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="button" class="btn btn-primary" id="confirmCreateCourse">Confirmar</button>
                        </div>
                    </div>
                </div>
            </div>

            <ul class="list-group mt-4">
                <%
                    while (rsCursos.next()) {
                        int cursoId = rsCursos.getInt("id");
                        String cursoNombre = rsCursos.getString("nombre");
                %>
                <li class="list-group-item">
                    <a style="color: #006666; font-family: fantasy; font-size: 20px" href="#" class="course-link" data-course-id="<%= cursoId%>"><%= cursoNombre%> <i class="fa-solid fa-circle-down"></i></a>
                    <div class="course-details" id="course-<%= cursoId%>" style="display:none;">
                        <form action="../CrearAsignatura" method="post" class="mt-2">
                            <input type="hidden" name="idCurso" value="<%= cursoId%>">
                            <input type="text" name="nombre" placeholder="Nombre de la asignatura" required class="form-control mb-3">
                            <button type="submit" class="btn btn-secondary">Crear Asignatura</button>
                        </form>
                        <ul class="list-group mt-2">
                            <%
                                PreparedStatement psAsig = null;
                                ResultSet rsAsig = null;
                                try {
                                    String sqlAsig = "SELECT * FROM asignatura WHERE id_curso = ?";
                                    psAsig = con.prepareStatement(sqlAsig);
                                    psAsig.setInt(1, cursoId);
                                    rsAsig = psAsig.executeQuery();
                                    while (rsAsig.next()) {
                            %>
                            <li class="list-group-item"><%= rsAsig.getString("nombre")%></li>
                                <%
                                        }
                                    } finally {
                                        if (rsAsig != null) {
                                            rsAsig.close();
                                        }
                                        if (psAsig != null) {
                                            psAsig.close();
                                        }
                                    }
                                %>
                        </ul>
                    </div>
                </li>
                <%
                    }
                %>
            </ul>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script>
            document.querySelectorAll('.course-link').forEach(link => {
                link.addEventListener('click', function (e) {
                    e.preventDefault();
                    const courseId = this.dataset.courseId;
                    const courseDetails = document.getElementById('course-' + courseId);
                    if (courseDetails.style.display === 'none') {
                        courseDetails.style.display = 'block';
                    } else {
                        courseDetails.style.display = 'none';
                    }
                });
            });

            document.getElementById('confirmCreateCourse').addEventListener('click', function () {
                document.getElementById('createCourseForm').submit();
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
        if (rsDocentes != null) {
            rsDocentes.close();
        }
        if (psDocentes != null) {
            psDocentes.close();
        }
        if (con != null) {
            con.close();
        }
    }
%>
