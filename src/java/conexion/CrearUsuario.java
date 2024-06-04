/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package conexion;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import conexion.ConexionBD;

@WebServlet("/CrearUsuario")
public class CrearUsuario extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");
        String rol = request.getParameter("rol");
        
        try {
            try (Connection con = ConexionBD.Conexion()) {
                String sql = "INSERT INTO usuario (nombre, correo, contrasena, rol) VALUES (?, ?, ?, ?)";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, nombre);
                ps.setString(2, correo);
                ps.setString(3, contrasena);
                ps.setString(4, rol);
                ps.executeUpdate();
                ps.close();
            }
            response.sendRedirect("admin/indexadmin.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin/indexadmin.jsp");
        } 
        
    }
}

