/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

/**
 *
 * @author Shiraz
 */
 
public class User extends HttpServlet {
          @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter pw=response.getWriter();
        String username = request.getParameter("username");
        String password = request.getParameter ("password");
        String email = request.getParameter("email");
        String submit = request.getParameter("submit");
    
         try{
             Class.forName("com.mysql.cj.jdbc.Driver");
             Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/userauth?zeroDateTimeBehavior=CONVERT_TO_NULL","root","password");
              PreparedStatement ps = con.prepareStatement("INSERT INTO users (username, password,email) VALUES (?,?,?)");
             ps.setString(1,username);
             ps.setString(2,password);
             ps.setString(3,email);
             
             int i =ps.executeUpdate();
            response.sendRedirect("welcome.jsp");
            con.close();
         }
            catch(Exception e){
               pw.println("error "+e.getMessage());
            }
        
        
              
        }
}
    

     

