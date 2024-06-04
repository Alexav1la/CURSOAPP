import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import conexion.ConexionBD;

@WebServlet("/CalificarActividad")
public class CalificarActividad extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idEstudiante = Integer.parseInt(request.getParameter("idEstudiante"));
        int idActividad = Integer.parseInt(request.getParameter("idActividad"));
        int calificacion = Integer.parseInt(request.getParameter("calificacion"));

        try {
            Connection con = ConexionBD.Conexion();
            String sql = "UPDATE actividad_estudiante SET calificacion = ? WHERE id_estudiante = ? AND id_actividad = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, calificacion);
            ps.setInt(2, idEstudiante);
            ps.setInt(3, idActividad);
            ps.executeUpdate();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("docente/calificar.jsp");
    }
}
