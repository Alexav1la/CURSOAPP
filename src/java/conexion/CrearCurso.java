package  conexion;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import conexion.ConexionBD;

@WebServlet("/CrearCurso")
public class CrearCurso extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombreCurso = request.getParameter("nombre");
        int idDocente = Integer.parseInt(request.getParameter("idDocente"));
        
        try {
            try (Connection con = ConexionBD.Conexion()) {
                String sql = "INSERT INTO curso (nombre, id_docente) VALUES (?, ?)";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, nombreCurso);
                ps.setInt(2, idDocente);
                ps.executeUpdate();
                ps.close();
            }
            response.sendRedirect("admin/cursos.jsp"); // Redirigir a la página de cursos
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirigir a una página de error
        }
    }
}
