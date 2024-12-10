<%-- 
    Document   : payment_success
    Created on : Dec 6, 2024, 2:23:40 PM
    Author     : M S I
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="jsp/header.jsp">
    <jsp:param name="logo" value="./images/logotab.png" />
    <jsp:param name="title" value="ABC Cinema" />
    <jsp:param name="css" value="payment.css" />
    <jsp:param name="activePage" value="home" />   
</jsp:include>



    <h1>Payment Authorized Successfully</h1>
    

<jsp:include page="jsp/footer.jsp">
    <jsp:param name="js" value="booking-selection.js" />
</jsp:include>