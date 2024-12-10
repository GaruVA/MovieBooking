/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.moviebooking.controller;

 import com.mycompany.moviebooking.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.paypal.base.rest.PayPalRESTException;

@WebServlet("/authorize_payment")
public class AuthorizePaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String movieName = request.getParameter("movieName");
        String subtotal = request.getParameter("subtotal");
        String tax = request.getParameter("tax");
        String total = request.getParameter("total");

        // Validate input
        if (movieName == null || subtotal == null || tax == null || total == null) {
            request.setAttribute("errorMessage", "Invalid input data.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // Create order details
        OrderDetails orderDetail = new OrderDetails(movieName, Float.parseFloat(subtotal),
                Float.parseFloat(tax), Float.parseFloat(total));

        try {
            PaymentServices paymentServices = new PaymentServices();
            String approvalLink = paymentServices.authorizePayment(orderDetail);

            // Redirect to PayPal for approval
            response.sendRedirect(approvalLink);

        } catch (PayPalRESTException ex) {
            request.setAttribute("errorMessage", ex.getMessage());
            ex.printStackTrace();
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
