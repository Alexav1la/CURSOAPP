/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package conexion;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class Login extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");
        System.out.println("ingreso correo:" + correo);
        System.out.println("ingreso contrasena:" + contrasena);

        Connection con = ConexionBD.Conexion();
        String sql = "SELECT * FROM usuario WHERE correo = ? AND contrasena = ?";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, correo);
            ps.setString(2, contrasena);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("usuario", rs.getString("nombre"));
                session.setAttribute("rol", rs.getString("rol"));
                session.setAttribute("idUsuario", rs.getInt("id"));

                switch (rs.getString("rol")) {
                    case "docente":
                        response.sendRedirect(request.getContextPath() + "/docente/indexdocente.jsp");
                        System.out.println("redirigiendo a docente");
                        break;
                    case "estudiante":
                        response.sendRedirect(request.getContextPath() + "/estudiante/indexestudiante.jsp");
                        System.out.println("redirigiendo a estudiante");
                        break;
                    default:
                        response.sendRedirect(request.getContextPath() + "/admin/indexadmin.jsp");
                        System.out.println("redirigiendo a admin");
                        break;
                }

            } else {
                response.sendRedirect("index.jsp?error=1");
            }
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
