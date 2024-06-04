/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package conexion;

/**
 *
 * @author SMS
 */

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/RealizarActividad")
public class RealizarActividad extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idActividad = Integer.parseInt(request.getParameter("idActividad"));
        String respuesta = request.getParameter("respuesta");

        HttpSession session = request.getSession();
        int idEstudiante = (Integer) session.getAttribute("idUsuario");

        Connection con = ConexionBD.Conexion();
        String sql = "INSERT INTO actividad_estudiante (id_actividad, id_estudiante, respuesta) VALUES (?, ?, ?)";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, idActividad);
            ps.setInt(2, idEstudiante);
            ps.setString(3, respuesta);
            ps.executeUpdate();
            response.sendRedirect("estudiante/cursos.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } finally {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
