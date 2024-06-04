<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page session="true" %>
<%
    // Verificamos si el usuario está logueado y tiene el rol de estudiante
    if (session.getAttribute("rol") == null || !session.getAttribute("rol").equals("estudiante")) {
        response.sendRedirect("../index.jsp");
        return;
    }

    String usuario = (String) session.getAttribute("usuario");
%>

<header class="main-header">
    <div class="logo">
        <a href="#">Small School</a>
    </div>
    <div class="menu-toggle" id="menu-toggle">
        <span></span>
        <span></span>
        <span></span>
    </div>
    <nav class="main-nav" id="main-nav">
        <ul>
            <li><a href="#top">Inicio</a></li>
            <li><a href="cursos.jsp">Cursos</a></li>
            <li><a href="Actividades.jsp">Actividades</a></li>
            <li><a href="documento.jsp">Recursos</a></li>
            <li class="user-menu">
                <a href="#" id="user-dropdown"><%= usuario%></a>
                <div class="dropdown-menu">
                    <a href="profile.jsp">Perfil</a>
                    <a href="logout.jsp">Cerrar Sesión</a>
                </div>
            </li>
        </ul>
    </nav>
</header>

<style>
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
        flex-grow: 1;
        justify-content: center;
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
        margin-left: auto;
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
            justify-content: flex-end;
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

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const navLinks = document.querySelectorAll('.main-nav ul li a');
        navLinks.forEach(link => {
            link.addEventListener('click', function (e) {
                if (this.getAttribute('href').charAt(0) === '#') {
                    e.preventDefault();
                    const targetId = this.getAttribute('href').substring(1);
                    const targetSection = document.getElementById(targetId);
                    targetSection.scrollIntoView({ behavior: 'smooth' });
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
