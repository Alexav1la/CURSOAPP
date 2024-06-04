package conexion;


import conexion.ConexionBD;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import java.sql.SQLException;

@WebServlet("/GetActividades")
public class GetActividades extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idAsignatura = Integer.parseInt(request.getParameter("idAsignatura"));
        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = ConexionBD.Conexion();
            String sql = "SELECT * FROM actividad WHERE id_asignatura = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, idAsignatura);
            rs = ps.executeQuery();
            
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            while (rs.next()) {
                out.println("<li class='list-group-item'>" + rs.getString("nombre") + "</li>");
            }
        } catch (SQLException e) {
            throw new ServletException("Error al obtener actividades", e);
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
