<!DOCTYPE html>
<html lang="en">
<head>
    <title>Start Page</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    
</head>
<body>
    <section class="text-bg-light p-3">
        <div class="container py-5 h-100">
            <div class="row d-flex justify-content-center align-items-center h-100">
                <div class="col-12 col-md-8 col-lg-6 col-xl-5">
                    <div class="text-light bg-dark" style="border-radius: 1rem;">
                        <div class="card-body p-5 text-center">
                            <h1 class="fw-bold mb-2 text-uppercase">Login Here</h1>
                            <form action="User" method="POST">
                                <table class="table">
                                    <tr class="text-secondary" >
                                        <td><input type="text" name="username" placeholder="Username" class="form-control form-control-lg" /></td>
                                    </tr>
                                    <tr>
                                        <td><input type="password" name="password" placeholder="Password" class="form-control form-control-lg" /></td>
                                    </tr>
                                    <tr>
                                        <td><input type="email" name="email" placeholder="Email" class="form-control form-control-lg" /></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" class="text-center">
                                            <input type="submit" name="submit" value="Submit" class= "btn btn-outline-dark btn-lg px-5" />
                                        </td>
                                    </tr>
                                </table>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>