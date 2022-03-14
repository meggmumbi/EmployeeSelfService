<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPass.aspx.cs" Inherits="HRPortal.ForgotPass" %>

<%@ Import Namespace="System.Globalization" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Login - KEMRI</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
    <link href="css/font-awesome.css" rel="stylesheet">
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet" type="text/css">
    <link href="css/pages/signin.css" rel="stylesheet" type="text/css">
</head>
<body style="background-image: url('images/background.jpg'); background-repeat:no-repeat;background-size:cover;">
    <div>
        <form id="form1" runat="server">
            <div class="navbar navbar-fixed-top">
                <div class="navbar-inner">
                    <div class="container">
                        <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </a>
                        <div class="header">
                            <img class="pull-left" src="images/logo.png" alt="logo" />
                            <h2 style="color: white; text-align: center;">Kenya Medical Research Institute<br />
                                <h3 style="color: orangered; text-align: center;"><u><i>In Search of Better Health</i></u></h3>
                            </h2>
                        </div>
                    </div>
                </div>
            </div>
            <div class="navbar navbar-fixed-top" >
                <div class="navbar-inner" style="background-color: white !important">
                    <div class="container" style="color: white !important;padding-top:20px">
                    </div>
                </div>
            </div>
            <div class="account-container">
                <div class="content clearfix">
                    <h1>Reset Password/First time use</h1>
                    <div runat="server" id="feedback"></div>
                    <div class="login-fields">
                        <div class="field">
                            <label for="username">Employee Number/ID Number</label>
                            <asp:TextBox runat="server" type="text" ID="username" name="username" value="" placeholder="Employee Number/ID Number" CssClass="login username-field" required />
                        </div>
                        <div class="field">
                            Prove you are not a robot <sup>*</sup>
                            <div class="g-recaptcha" data-sitekey="6LdcwEQdAAAAABeu__sHnvP94BfP3CavMsOIrstp" style="display: block; margin: auto;"></div>
                        </div>
                    </div>
                    <hr />
                    <div>
                        <asp:Button runat="server" class="btn btn-success pull-right" Text="Reset Password" OnClick="Unnamed1_Click" />
                        <a class="btn btn-warning pull-left" href="Login.aspx">Login</a>
                    </div>
                </div>
            </div>
            </form>
          <div class="navbar navbar-fixed-bottom">
            <div class="navbar-inner">
                <div class="container">
                    <footer class="main-footer">
                        <div class="pull-right hidden-xs">
                            <b style="color: white !important">Kenya Medical Research Institute</b>
                        </div>
                        <div class="pull-left hidden-xs">
                            <b style="color: white !important">Copyright&copy; <%: DateTime.Now.Year %>  <a href="https://dynasoft.co.ke" style="color: white !important">Powered By Dynasoft Business Solutions. All rights
                Reserved.</b>
                        </div>

                    </footer>
                </div>
            </div>
        </div>
    </div>
    <script src="js/jquery-1.7.2.min.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/signin.js"></script>
    <script src="https://www.google.com/recaptcha/api.js"></script>
</body>
</html>
