<%@ page import="java.sql.*" %>
<%@ page import="conexion.ConexionBD" %>
<%@ page session="true" %>
<%
    // Verificamos si el usuario está logueado y tiene el rol de docente
    if (session.getAttribute("rol") == null || !session.getAttribute("rol").equals("docente")) {
        response.sendRedirect("../index.jsp");
        return;
    }

    String usuario = (String) session.getAttribute("usuario");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Mis Cursos</title>
        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <style>
            body {
                background-image: url('../imagenes/choosing-bg.jpg'); /* Ruta de la imagen de fondo */
                background-size: cover;
                background-repeat: no-repeat;
                background-attachment: fixed;
            }
            .container {
                max-width: 800px;
                margin: 140px auto 20px; /* Adjusted margin to account for fixed navbar */
                padding: 20px;
                background-color: #fff;
                border-radius: 8px;
               
            }
            h1 {
                text-align: center;
            }
            form {
                margin-bottom: 20px;
            }
            input[type="text"], textarea {
                width: 100%;
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
            }
            button {
                padding: 10px 20px;
                background-color: #007bff;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            button:hover {
                background-color: #0056b3;
            }
            .ulclass {
                list-style-type: none;
                padding: 0;
            }
            .liclass {
                background-color: #f9f9f9;
                border: 1px solid #ddd;
                margin-bottom: 10px;
                border-radius: 5px;
                padding: 10px;
            }
            .liclass:last-child {
                margin-bottom: 0;
            }
            .liclass:hover {
                background-color: #e9e9e9;
            }
            ul.sublist {
                padding-left: 20px;
            }
     
        

        
            
        </style>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        
        <div class="container">
            <h1 >Mis Cursos</h1>
            <ul class="ulclass">
                <%
                    try {
                        int idDocente = (Integer) session.getAttribute("idUsuario");
                        Connection con = ConexionBD.Conexion();
                        String sql = "SELECT * FROM curso WHERE id_docente = ?";
                        PreparedStatement ps = con.prepareStatement(sql);
                        ps.setInt(1, idDocente);
                        ResultSet rs = ps.executeQuery();

                        while (rs.next()) {
                %>
                <li class="liclass" >
                    <span style="color: blue; font-family: fantasy; font-size: 30px"><%= rs.getString("nombre") %></span> 
                    <ul class="sublist">
                        <%
                            String sqlAsig = "SELECT * FROM asignatura WHERE id_curso = ?";
                            PreparedStatement psAsig = con.prepareStatement(sqlAsig);
                            psAsig.setInt(1, rs.getInt("id"));
                            ResultSet rsAsig = psAsig.executeQuery();

                            while (rsAsig.next()) {
                        %>
                        <li class="liclass">
                            <span style="color: red; font-family: monospace; font-size: 15px"><%= rsAsig.getString("nombre") %></span> 
                            
                            <form action="../CrearActividad" method="post">
                                <input type="hidden" name="idAsignatura" value="<%= rsAsig.getInt("id") %>">
                                <input type="text" name="nombre" placeholder="Nombre de la actividad" required>
                                <textarea name="descripcion" placeholder="Descripción de la actividad" required></textarea>
                                <button type="submit">Crear Actividad</button>
                            </form>
                        </li>
                        <%
                            }
                            rsAsig.close();
                            psAsig.close();
                        %>
                    </ul>
                </li>
                <%
                        }
                        rs.close();
                        ps.close();
                        con.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </ul>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>
