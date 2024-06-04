/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package conexion;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {
  /* Declaramos 4 variables con el driver, la bbdd, usuario y contraseña*/
    private static final String driver="com.mysql.cj.jdbc.Driver";
    private static final String bbdd="jdbc:mysql://127.0.0.1:3306/gestion_cursos";
    private static final String usuario ="root";
    private static final String clave="";
     
    /* Creamos el método para conectarnos a la base de datos. Este método
    devolverá un objeto de tipo Connection.*/
    public static Connection Conexion(){
        /*Declaramos una variable para almacenar la cadena de conexión.
        Primero la iniciamos en null.*/
        Connection conex = null;
         
        //Controlamos la excepciones que puedan surgir al conectarnos a la BBDD
        try {
            //Registrar el driver
            Class.forName(driver);
            //Creamos una conexión a la Base de Datos
            conex = DriverManager.getConnection(bbdd, usuario, clave);
         
        // Si hay errores informamos al usuario. 
        } catch (Exception e) {
            System.out.println("Error al conectar con la base de datos.\n"
                    + e.getMessage().toString());
        }
        // Devolvemos la conexión.
        return conex;
    }
}
