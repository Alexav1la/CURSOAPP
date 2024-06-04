<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page session="true" %>    
<%
    // Verificamos si el usuario está logueado y tiene el rol de estudiante
    if (session.getAttribute("rol") == null || !session.getAttribute("rol").equals("estudiante")) {
        response.sendRedirect("../index.jsp");
        return;
    }

    String usuario = (String) session.getAttribute("usuario");
%>


<!doctype html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="Plataforma educativa para niños">
        <meta name="author" content="SMS">
        <link href="https://fonts.googleapis.com/css?family=Montserrat:100,200,300,400,500,600,700,800,900" rel="stylesheet">
        <title>SMALL SCHOOL</title>
        <link rel="shortcut icon" type="image/png" href="logo.png" />

        <style>
            body {
                font-family: 'Montserrat', sans-serif;
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                overflow-x: hidden; /* Prevenir scroll horizontal */
            }
            * {
                box-sizing: border-box; /* Asegurar que el box-sizing sea aplicado a todos los elementos */
            }
            .main-header {
                background: rgba(0, 0, 0, 0.7);
                color: white;
                padding: 10px 20px;
                position: fixed;
                width: 100%;
                z-index: 1000;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .logo a {
                color: white;
                font-size: 24px;
                text-decoration: none;
            }
            .main-nav {
                display: flex;
                align-items: center;
                flex-grow: 1; /* Permitir que el nav ocupe todo el espacio disponible */
                justify-content: center; /* Centrar los elementos del nav */
            }
            .main-nav ul {
                list-style: none;
                display: flex;
                margin: 0;
                padding: 0;
                align-items: center;
            }
            .main-nav ul li {
                margin-right: 30px;
                position: relative;
            }
            .main-nav ul li a {
                color: white;
                text-decoration: none;
                padding: 5px 10px;
            }
            .main-nav .user-menu {
                margin-left: auto; /* Mantener el menú de usuario a la derecha */
            }
            .dropdown-menu {
                display: none;
                position: absolute;
                background: white;
                color: black;
                top: 100%;
                right: 0;
                min-width: 150px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 4px;
                text-align: left;
            }
            .dropdown-menu a {
                color: black;
                padding: 10px;
                display: block;
                text-decoration: none;
            }
            .dropdown-menu a:hover {
                background: #f0f0f0;
            }
            .main-nav ul li:hover .dropdown-menu {
                display: block;
            }
            .main-banner {
                position: relative;
                height: 100vh;
                overflow: hidden; /* Prevenir desbordamiento en el banner */
            }
            .main-banner video {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                object-fit: cover;
                z-index: -1;
            }
            .video-overlay {
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(0, 0, 0, 0.5);
                display: flex;
                justify-content: center;
                align-items: flex-end;
                color: white;
                text-align: center;
                padding: 20px;
            }
            .video-overlay .text {
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                height: 100%;
            }
            .features {
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 20px;
                position: absolute;
                bottom: 20px;
                width: 100%;
                z-index: 1;
            }
            .features .feature-item {
                text-align: center;
                padding: 20px;
                background: white;
                margin: 0 10px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                position: relative;
                transition: transform 0.3s;
                color: black;

            }
            .features .feature-item:hover {
                transform: scale(1.05);
            }
            .features .feature-item h4 {
                margin-bottom: 15px;
            }
            .feature-description {
                opacity: 0;
                visibility: hidden;
                position: absolute;
                bottom: -10px;
                left: 50%;
                transform: translateX(-50%);
                background: rgba(0, 0, 0, 0.7);
                color: white;
                padding: 10px;
                border-radius: 5px;
                transition: opacity 0.3s, visibility 0.3s, bottom 0.3s;
            }
            .features .feature-item:hover .feature-description {
                opacity: 1;
                visibility: visible;
                bottom: -20px;
            }
            .contact {
                text-align: center;
            }
            .contact a {
                display: inline-block;
                margin-top: 10px;
                color: #007bff;
                text-decoration: none;
            }
            footer {
                background: #333;
                color: white;
                text-align: center;
                padding: 20px 0;
            }
            .menu-toggle {
                display: none;
                flex-direction: column;
                cursor: pointer;
            }
            .menu-toggle span {
                background: white;
                width: 25px;
                height: 2px;
                margin: 4px 0;
            }
            .main-nav.responsive ul {
                flex-direction: column;
                display: none;
            }
            .main-nav.responsive ul.active {
                display: flex;
            }
            .main-nav.responsive .user-menu {
                margin-left: 0;
            }
            @media (max-width: 768px) {
                .menu-toggle {
                    display: flex;
                }
                .main-nav {
                    justify-content: flex-end; /* Alinear el nav a la derecha en móviles */
                }
                .main-nav ul {
                    flex-direction: column;
                    width: 100%;
                    text-align: center;
                    display: none;
                }
                .main-nav ul.active {
                    display: flex;
                }
                .main-nav ul li {
                    margin: 10px 0;
                }
                .main-nav ul li a {
                    padding: 10px 20px;
                }
                .main-nav .user-menu {
                    margin-left: 0;
                }
            }
        </style>
    </head>
    <body>


        <header class="main-header">
            <div class="logo">
                <a href="indexestudiante.jsp">Small School</a>
            </div>
            <div class="menu-toggle" id="menu-toggle">
                <span></span>
                <span></span>
                <span></span>
            </div>
            <nav class="main-nav" id="main-nav">
                <ul>
                    <li><a href="indexestudiante.jsp">Inicio</a></li>
                    <li><a href="cursos.jsp">Cursos</a></li>
                    <li><a href="recursos.jsp">Recursos</a></li>
                    <li class="user-menu">
                        <a href="#" id="user-dropdown"><%= usuario%></a>
                        <div class="dropdown-menu">
                            <a style="color: black;border-radius: 5px" href="perfil.jsp">Perfil</a>
                            <a style="color: black;border-radius: 5px" href="logout.jsp">Cerrar Sesión</a>
                        </div>
                    </li>
                </ul>
            </nav>
        </header>

        <section class="main-banner" id="top">
            <video autoplay muted loop id="bg-video">
                <source src="../video/course-video.mp4" type="video/mp4" />
            </video>
            <div class="video-overlay">
                <div class="text">
                    <h6>Plataforma educativa para niños</h6>
                    <h2><em>TU</em> Clase</h2>
                </div>
                <div class="features">
                    <div class="feature-item">
                        <h4><i class="fa fa-pencil"></i> Cursos</h4>
                        <p>Aquí estarán los distintos cursos que estarás viendo en tu grado cursado.</p>
                        <div class="feature-description"><a href="cursos.jsp">Ver Cursos</a></div>
                    </div>
                    <div class="feature-item">
                        <h4><i class="fa fa-graduation-cap"></i> Mision y Vision</h4>
                        <p>Mantente al día con cualquier actividad subida por el profesor.</p>
                        <div class="feature-description"><a href="mv.jsp">Ver Mision y Vision</a></div>
                    </div>
                    <div class="feature-item">
                        <h4><i class="fa fa-book"></i> Recursos</h4>
                        <p>Distintos libros, videos y material didáctico para complementar tu aprendizaje.</p>
                        <div class="feature-description"><a href="recursos.jsp">Ver Recursos</a></div>
                    </div>
                </div>
            </div>
        </section>
        <br><br><br><br>
        <section class="section contact" id="documents">
            <div class="container">
                <h2>Extra Recurso</h2>
            
                <a href="https://www.youtube.com/watch?v=_X-BTbwj3xUD" target="_blank">Ver el video en YouTube</a>
                <div class="down-content">
                    <p>¡Descubre más recursos y documentos para complementar tu aprendizaje!</p>
                    <a href="recursos.jsp">¡Descubre más recursos! <i class="fa fa-angle-double-right"></i></a>
                </div>
            </div>
        </section>

        <footer>
            <p><i class="fa fa-copyright"></i> Copyright 2024 by Small School</p>
        </footer>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const navLinks = document.querySelectorAll('.main-nav ul li a');
                navLinks.forEach(link => {
                    link.addEventListener('click', function (e) {
                        if (this.getAttribute('href').charAt(0) === '#') {
                            e.preventDefault();
                            const targetId = this.getAttribute('href').substring(1);
                            const targetSection = document.getElementById(targetId);
                            targetSection.scrollIntoView({behavior: 'smooth'});
                        }
                    });
                });

                window.addEventListener('scroll', function () {
                    const sections = document.querySelectorAll('.section');
                    const scrollPosition = document.documentElement.scrollTop || document.body.scrollTop;

                    sections.forEach(section => {
                        if (scrollPosition >= section.offsetTop - 80 && scrollPosition < section.offsetTop + section.offsetHeight) {
                            const currentId = section.getAttribute('id');
                            const activeLink = document.querySelector(`.main-nav ul li a[href="#${currentId}"]`);
                            navLinks.forEach(link => link.parentElement.classList.remove('active'));
                            if (activeLink) {
                                activeLink.parentElement.classList.add('active');
                            }
                        }
                    });
                });

                const menuToggle = document.getElementById('menu-toggle');
                const mainNav = document.getElementById('main-nav');

                menuToggle.addEventListener('click', function () {
                    mainNav.classList.toggle('responsive');
                    mainNav.querySelector('ul').classList.toggle('active');
                });
            });
        </script>

    </body>
</html>
