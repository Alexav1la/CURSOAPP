<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Login</title>
        <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <style>
            body, html {
                margin: 0;
                padding: 0;
                height: 100%;
                font-family: Arial, sans-serif;
                background: #f8f9fa;
            }

            .section {
                position: relative;
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                color: #fff;
                text-align: center;
            }

            .main-banner {
                background-color: #000;
            }

            .video-container {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                overflow: hidden;
            }

            #bg-video {
                min-width: 100%;
                min-height: 100%;
                width: auto;
                height: auto;
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                opacity: 0.7; /* Ajusta la opacidad del video */
            }

            .login-form {
                position: relative;
                z-index: 1;
                width: 350px;
                background-color: rgba(0, 0, 0, 0.7); /* Fondo del formulario con transparencia */
                padding: 20px;
                border-radius: 10px;
                color: white;
            }

            .login-form h2 {
                margin-top: 0;
            }

            .login-form .input-group {
                margin-bottom: 15px;
            }

            .login-form .input-group-text {
                background-color: #343a40;
                border: none;
                color: white;
            }

            .login-form input {
                background-color: #495057;
                border: none;
                color: white;
            }

            .login-form input:focus {
                box-shadow: none;
                background-color: #495057;
                border: none;
            }

            .login-form button {
                width: 100%;
                padding: 10px;
                border: none;
                border-radius: 5px;
                background-color: #fcb040;
                color: #fff;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .login-form button:hover {
                background-color: #e69a2e;
            }

            .login-form p {
                margin: 10px 0 0;
            }

            .login-form .link-secondary {
                color: #fcb040;
            }

            .login-form .link-secondary:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <section class="section main-banner" id="top" data-section="section1">
            <div class="video-container">
                <video autoplay muted loop id="bg-video">
                    <source src="video/course-video.mp4" type="video/mp4" />
                </video>
            </div>
            <div class="login-form">
                <form action="./login" method="post">
                    <h2>Login</h2>
                    <div class="row gy-3 gy-md-4 overflow-hidden">
                        <div class="col-12">
                            <label for="correo" class="form-label">Email <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
                                        <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4Zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1H2Zm13 2.383-4.708 2.825L15 11.105V5.383Zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741ZM1 11.105l4.708-2.897L1 5.383v5.722Z" />
                                    </svg>
                                </span>
                                <input type="email" class="form-control" name="correo" id="correo" required>
                            </div>
                        </div>
                        <div class="col-12">
                            <label for="contrasena" class="form-label">Password <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-key" viewBox="0 0 16 16">
                                        <path d="M0 8a4 4 0 0 1 7.465-2H14a.5.5 0 0 1 .354.146l1.5 1.5a.5.5 0 0 1 0 .708l-1.5 1.5a.5.5 0 0 1-.708 0L13 9.207l-.646.647a.5.5 0 0 1-.708 0L11 9.207l-.646.647a.5.5 0 0 1-.708 0L9 9.207l-.646.647A.5.5 0 0 1 8 10h-.535A4 4 0 0 1 0 8zm4-3a3 3 0 1 0 2.712 4.285A.5.5 0 0 1 7.163 9h.63l.853-.854a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.793-.793-1-1h-6.63a.5.5 0 0 1-.451-.285A3 3 0 0 0 4 5z" />
                                        <path d="M4 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
                                    </svg>
                                </span>
                                <input type="password" class="form-control" name="contrasena" id="contrasena" required>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="d-grid">
                                <button class="btn btn-primary btn-lg" type="submit">Log In</button>
                            </div>
                        </div>
                    </div>
                </form>
                <c:if test="${param.error != null}">
                    <p style="color:red;">Correo o contraseña incorrectos.</p>
                </c:if>
                <div class="row">
                    <div class="col-12">
                        <hr class="mt-5 mb-4 border-secondary-subtle">
                        <div class="d-flex gap-2 gap-md-4 flex-column flex-md-row justify-content-md-center">
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>
