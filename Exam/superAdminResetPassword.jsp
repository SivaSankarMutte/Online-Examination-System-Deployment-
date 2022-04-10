<%-- 
    Document   : superAdminResetPassword
    Created on : 23 Feb, 2022, 4:20:32 PM
    Author     : SIVASANKAR
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Forgotten Password - BEC</title>
    <meta name="description" content="BEC Exam Portal">
    <link rel="stylesheet" href="assets\bootstrap\css\bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i">
    <link rel="stylesheet" href="assets\fonts\fontawesome-all.min.css">
    <link rel="stylesheet" href="assets\fonts\font-awesome.min.css">
    <link rel="stylesheet" href="assets\fonts\ionicons.min.css">
    <link rel="stylesheet" href="assets\fonts\typicons.min.css">
    <link rel="stylesheet" href="assets\fonts\fontawesome5-overrides.min.css">
    <link rel="stylesheet" href="assets\css\styles.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css">
    <link rel="icon" type="text/css" href="images/test.png">
    </head>
    <body>
        <div class="card">
                    <div class="card shadow mb-3">
                        <div class="card-header py-3" style="background: var(--bs-success); height: 100px;">
                            <p class="text-primary m-0 fw-bold">SuperAdmin Reset Password</p>
                        </div>
                        <div class="card-body">
                        <form action="saveSuperAdminPassword.jsp" method="post" class="form-control">
                             <div class="row">
                                    <div class="col">
                                        <div class="mb-3"><label class="form-label" for="formOtp"><strong>OTP</strong></label><input class="form-control" type="text" id="formOtp" placeholder="Enter OTP which is sent to your mail" name="formOtp"></div>
                                    </div>
                                    
                                    <div class="col">
                                        <div class="mb-3"><label class="form-label" for="formPassword"><strong>New Password</strong></label><input class="form-control" type="text" id="formPassword" placeholder="Enter New Password" name="formPassword"></div>
                                    </div>
                                </div>
                                <div class="mb-3"><input class="btn btn-primary btn-sm" type="submit" value="Save Password"></div>
                        </form>
                        </div>
                    </div>
                </div>
        <script src="assets\bootstrap\js\bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
        <script src="assets\js\script.min.js"></script>
        <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>
