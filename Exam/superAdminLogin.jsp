<%-- 
    Document   : superAdminLogin
    Created on : 27 Nov, 2021, 10:43:32 AM
    Author     : SIVASANKAR
--%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>SuperAdmin Login</title>
    <meta name="description" content="BEC Exam Portal">
    <link rel="stylesheet" href="assets\bootstrap\css\bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i">
    <link rel="stylesheet" href="assets\css\Animation-Cards-1.css">
    <link rel="stylesheet" href="assets\css\Animation-Cards.css">
    <link rel="stylesheet" href="assets\css\Card-Deck.css">
    <link rel="stylesheet" href="assets\css\Material-Card.css">
    <link rel="icon" type="text/css" href="images/test.png">
</head>

<body class="bg-gradient-primary" style="background: var(--bs-success);">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-9 col-lg-12 col-xl-10">
                <div class="card shadow-lg o-hidden border-0 my-5">
                    <div class="card-body p-0">
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-flex">
                                <div class="flex-grow-1 bg-login-image" style="background: url(&quot;assets/img/adminLogin.png&quot;) center / auto no-repeat;"></div>
                            </div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h4 class="text-dark mb-4">Welcome Back SuperAdmin!</h4>
                                    </div>
                                    <form class="user" action="superAdminValidation" method="post">
                                        <div class="mb-3"><input class="form-control form-control-user" type="email" id="exampleInputEmail" aria-describedby="emailHelp" placeholder="Enter Email Address..." name="superAdminEmail"></div>
                                        <div class="mb-3"><input class="form-control form-control-user" type="password" id="exampleInputPassword" placeholder="Password" name="superAdminPassword"></div>
                                        <div class="mb-3">
                                            <div class="custom-control custom-checkbox small">
                                                <div class="form-check"><input class="form-check-input custom-control-input" type="checkbox" id="formCheck-1"><label class="form-check-label custom-control-label" for="formCheck-1">Remember Me</label></div>
                                            </div>
                                        </div><button class="btn btn-primary d-block btn-user w-100" type="submit">Login</button>
                                        <hr>
                                    </form>
                                    <div class="text-center"><a class="small" href="superAdminForgotPassword.jsp">Forgot Password?</a></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="assets\bootstrap\js\bootstrap.min.js"></script>
    <script src="assets\js\theme.js"></script>
    <script type="text/javascript" src="assets\js\noBack.js"></script>
</body>

</html>





