<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="conexion.ConexionBD"%>
<%@page session="true"%>
<%
    // Verificamos si el usuario está logueado y tiene el rol de docente
    if (session.getAttribute("rol") == null || !session.getAttribute("rol").equals("docente")) {
        response.sendRedirect("../index.jsp");
        return;
    }

    String usuario = (String) session.getAttribute("usuario");

    int idDocente = (Integer) session.getAttribute("idUsuario");
    Connection con = ConexionBD.Conexion();

    String sqlCursos = "SELECT * FROM curso WHERE id_docente = ?";
    PreparedStatement psCursos = con.prepareStatement(sqlCursos);
    psCursos.setInt(1, idDocente);
    ResultSet rsCursos = psCursos.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Calificar Actividades</title>
    <script src="https://kit.fontawesome.com/465418070e.js" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        body {
            background-image: url('../imagenes/choosing-bg.jpg'); /* Ruta de la imagen de fondo */
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }
        
        .container-fluid {
            display: flex;
      
        }
        .left-panel {
            flex: 1;
            padding: 20px;
        }
        .right-panel {
            flex: 2;
            padding: 20px;
        }
        .list-group-item {
            cursor: pointer;
            color: #555;
            font-size: 1.2rem;
        }
        ::selection {
            background: none;
        } 
        .navbar {
                background-color: rgba(255, 255, 255, 0.8) !important;
        }
                
    </style>
</head>
<body>
    <%@include file="navbar2.jsp" %>
    <br>
    <div class="container-fluid">
        <div class="left-panel">
            <h1 style="color: white" >Mis Cursos</h1>
            <ul class="list-group">
                <% while (rsCursos.next()) { %>
                <li class="list-group-item">
                    <a style="color: blue; font-family: fantasy; font-size: 20px; text-decoration: none"  href="#" class="course-link" data-course-id="<%= rsCursos.getInt("id") %>"><%= rsCursos.getString("nombre") %>.                   <i class="fa-solid fa-down-long"></i></a>
                    <ul class="list-group mt-2 d-none" id="course-<%= rsCursos.getInt("id") %>-subjects">
                        <%
                            Connection conAsig = ConexionBD.Conexion();
                            String sqlAsig = "SELECT * FROM asignatura WHERE id_curso = ?";
                            PreparedStatement psAsig = conAsig.prepareStatement(sqlAsig);
                            psAsig.setInt(1, rsCursos.getInt("id"));
                            ResultSet rsAsig = psAsig.executeQuery();
                            while (rsAsig.next()) {
                        %>
                        <li class="list-group-item">
                            <a style="color: #00cccc; font-family: fantasy; font-size: 14px; text-decoration: none" href="#" class="subject-link" data-subject-id="<%= rsAsig.getInt("id") %>"><%= rsAsig.getString("nombre") %>.          <i class="fa-solid fa-circle-down"></i></a>
                            <ul class="list-group mt-2 d-none" id="subject-<%= rsAsig.getInt("id") %>-activities">
                                <%
                                    Connection conAct = ConexionBD.Conexion();
                                    String sqlAct = "SELECT * FROM actividad WHERE id_asignatura = ?";
                                    PreparedStatement psAct = conAct.prepareStatement(sqlAct);
                                    psAct.setInt(1, rsAsig.getInt("id"));
                                    ResultSet rsAct = psAct.executeQuery();
                                    while (rsAct.next()) {
                                %>
                                <li class="list-group-item">
                                    <a style="color: #006666; font-family: fantasy; font-size: 14px; text-decoration: none" href="#" class="activity-link" data-activity-id="<%= rsAct.getInt("id") %>"><%= rsAct.getString("nombre") %>.       <i class="fa-solid fa-arrow-right"></i></a>
                                </li>
                                <%
                                    }
                                    rsAct.close();
                                    psAct.close();
                                    conAct.close();
                                %>
                            </ul>
                        </li>
                        <%
                            }
                            rsAsig.close();
                            psAsig.close();
                            conAsig.close();
                        %>
                    </ul>
                </li>
                <% } %>
            </ul>
        </div>
        <div class="right-panel">
            <div id="activity-details" class="d-none">
                <h2 style="color: white"  id="activity-name"></h2>
                <ul class="list-group" id="student-list"></ul>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelectorAll('.course-link').forEach(function(courseLink) {
                courseLink.addEventListener('click', function(event) {
                    event.preventDefault();
                    var courseId = courseLink.getAttribute('data-course-id');
                    var subjectsList = document.getElementById('course-' + courseId + '-subjects');
                    subjectsList.classList.toggle('d-none');
                });
            });

            document.querySelectorAll('.subject-link').forEach(function(subjectLink) {
                subjectLink.addEventListener('click', function(event) {
                    event.preventDefault();
                    var subjectId = subjectLink.getAttribute('data-subject-id');
                    var activitiesList = document.getElementById('subject-' + subjectId + '-activities');
                    activitiesList.classList.toggle('d-none');
                });
            });

            document.querySelectorAll('.activity-link').forEach(function(activityLink) {
                activityLink.addEventListener('click', function(event) {
                    event.preventDefault();
                    var activityId = activityLink.getAttribute('data-activity-id');
                    var activityName = activityLink.textContent;
                    document.getElementById('activity-name').textContent = activityName;
                    document.getElementById('activity-details').classList.remove('d-none');

                    fetch('GetEstudiantesActividad.jsp?idActividad=' + activityId)
                        .then(response => response.text())
                        .then(data => {
                            var studentList = document.getElementById('student-list');
                            studentList.innerHTML = data;
                        });
                });
            });
        });
    </script>
</body>
</html>
