<%-- 
    Document   : registration
    Created on : Nov 19, 2024, 12:50:43 PM
    Author     : hp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/style.css">

    </head>
    <body>
        <%@ include file="jsp/header.jsp"%>
        <br>
        <br>
        <main class="login-form">
            <div class="cotainer">
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                User Registration

                            </div>
                            <div class="card-body">
                                <form action="/JavaWebApp/RegistrationCTL" method="post">
                                    <input type="hidden" name="uri" value=""> <input
                                        type="hidden" name="id" value=""> <input
                                        type="hidden" name="createdBy" value="">
                                    <input type="hidden" name="modifiedBy"
                                           value=""> <input type="hidden"
                                           name="createdDatetime"
                                           value="">
                                    <input type="hidden" name="modifiedDatetime"
                                           value="">
                                    <div class="form-group row">
                                        <label for="email_address" 
                                               class="col-md-4 col-form-label text-md-right">First Name<font color="red"></font></label>
                                        <div class="col-md-6">
                                            <input type="text"   class="form-control" placeholder="Enter First Name"
                                                   name="firstName" value="" >
                                            <font  color="red"></font>
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label for="email_address" 
                                               class="col-md-4 col-form-label text-md-right">Last Name<font color="red"></font></label>
                                        <div class="col-md-6">
                                            <input type="text"   class="form-control" placeholder="Enter Last Name"
                                                   name="lastName" value="" >
                                            <font  color="red"></font>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="email_address" 
                                               class="col-md-4 col-form-label text-md-right">Email Adress<font color="red"></font></label>
                                        <div class="col-md-6">
                                            <input type="text" id="email_address"  class="form-control" placeholder="Enter email adress"
                                                   name="login" value="" >
                                            <font  color="red"></font>
                                        </div>
                                    </div>


                                    <div class="form-group row">
                                        <label for="email_address" 
                                               class="col-md-4 col-form-label text-md-right">Password<font color="red"></font></label>
                                        <div class="col-md-6">
                                            <input type="password" id="email_address"  class="form-control" placeholder="Enter password"
                                                   name="password" value="" >
                                            <font  color="red"></font>
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label for="email_address" 
                                               class="col-md-4 col-form-label text-md-right">Confirm Password<font color="red"></font></label>
                                        <div class="col-md-6">
                                            <input type="text"  id="datepicker" class="form-control" placeholder="Confirm password"
                                                   name="dob" value="" >
                                            <font  color="red"></font>
                                        </div>
                                    </div>



                                    <div class="form-group row">
                                        <label for="email_address" 
                                               class="col-md-4 col-form-label text-md-right">Mobile No.<font color="red"></font></label>
                                        <div class="col-md-6">
                                            <input type="text" id="email_address"  class="form-control" placeholder="Enter Mobile No"
                                                   name="mobile" value="" >
                                            <font  color="red"></font>
                                        </div>
                                    </div>
                                    <div class="col-md-6 offset-md-4">
                                        <input type="submit" class="btn btn-primary" name="operation" value="Register">

                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <div style="margin-top: 120px">
            <%@ include file="jsp/footer.jsp"%>
        </div>
    </body>
</html>
