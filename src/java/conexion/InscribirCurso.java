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
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/inscribirCurso")
public class InscribirCurso extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idCurso = Integer.parseInt(request.getParameter("idCurso"));

        // Obtener la sesión
        HttpSession session = request.getSession();

        // Variable para almacenar el ID del estudiante
        int idEstudiante = -1; // Valor predeterminado en caso de que no se encuentre ningún estudiante con el rol adecuado

        // Establecer la conexión
        Connection con = ConexionBD.Conexion();
        
        try {
            // Consulta SQL para obtener el ID del estudiante con el rol "estudiante"
            String sqlEstudiante = "SELECT id FROM usuario WHERE rol = 'estudiante'";
            PreparedStatement psEstudiante = con.prepareStatement(sqlEstudiante);
            ResultSet rsEstudiante = psEstudiante.executeQuery();

            // Si se encuentra un estudiante con el rol adecuado, obtener su ID
            if (rsEstudiante.next()) {
                idEstudiante = rsEstudiante.getInt("id");
            }

            // Cerrar ResultSet y PreparedStatement
            rsEstudiante.close();
            psEstudiante.close();

            // Si se encontró un estudiante con el rol adecuado, proceder con la inserción
            if (idEstudiante != -1) {
                // Consulta SQL para insertar la inscripción del estudiante en el curso
                String sql = "INSERT INTO curso_estudiante (id_curso, id_estudiante) VALUES (?, ?)";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, idCurso);
                ps.setInt(2, idEstudiante);
                ps.executeUpdate();
                response.sendRedirect("admin/listadoMatriculados.jsp");
            } else {
                // Si no se encontró un estudiante con el rol adecuado, redirigir a una página de error
                response.sendRedirect("error.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } finally {
            try {
                // Cerrar conexión
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
