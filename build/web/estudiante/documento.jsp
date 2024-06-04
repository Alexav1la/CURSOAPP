<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Documentos</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .container {
                max-width: 1200px;
                margin: auto;
                margin-top: 100px; /* Aumentar para asegurar espacio debajo del encabezado */
                padding: 20px;
                background: white;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            header {
                background-color: #344c77;
                color: white;
                padding: 10px 0;
                text-align: center;
                position: fixed;
                width: 100%;
                top: 0;
                z-index: 1000;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 10px 20px;
            }
            header .logo {
                font-size: 1.5rem;
                font-weight: bold;
            }
            header .logo a {
                color: white;
                text-decoration: none;
            }
            footer {
                background-color: #344c77;
                color: white;
                text-align: center;
                padding: 10px 0;
                position: fixed;
                width: 100%;
                bottom: 0;
            }
            .content {
                margin-top: 20px;
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
            }
            .content .item {
                flex: 1 1 calc(33.333% - 40px); /* Tres elementos por fila con márgenes */
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                text-align: center;
            }
            .content .item img {
                max-width: 100%;
                height: auto;
                border-radius: 8px;
            }
        </style>
    </head>
    <body>
        <header>
            <div class="logo">
                <a href="index.html"><em>Small</em> School</a>
            </div>
            <div>
                <a href="indexestudiante.jsp" class="btn btn-primary">Volver al Inicio</a>
            </div>
        </header>

        <div class="container">
            <h1 class="text-center">Documentos</h1>
            <div class="content">
                <div class="item">
                    <img src="../imagenes/razonamiento1.png" alt="Image 1">
                    <p>Ejercicios Razonamiento Logico</p>
                    <a href="https://www.youtube.com/watch?v=QyNMZ0JVTzA" target="_blank">Ver video</a>
                </div>
                <div class="item">
                    <img src="../imagenes/lectura1.png" alt="Image 2">
                    <p>Caracteristicas de la lectura critica</p>
                    <a href="https://www.youtube.com/watch?v=Gc0LVdAW9c8" target="_blank">Ver video</a>
                </div>
                <div class="item">
                    <img src="../imagenes/naturales1.png" alt="Image 3">
                    <p>Partes de las plantas</p>
                    <a href="https://www.youtube.com/watch?v=wBjaQuyMr18" target="_blank">Ver video</a>
                </div>
                <div class="item">
                    <img src="https://via.placeholder.com/150" alt="Image 4">
                    <p>Descripción corta 4</p>
                    <a href="https://www.youtube.com/watch?v=video4" target="_blank">Ver video</a>
                </div>
                <div class="item">
                    <img src="https://via.placeholder.com/150" alt="Image 5">
                    <p>Descripción corta 5</p>
                    <a href="https://www.youtube.com/watch?v=video5" target="_blank">Ver video</a>
                </div>
                <div class="item">
                    <img src="https://via.placeholder.com/150" alt="Image 6">
                    <p>Descripción corta 6</p>
                    <a href="https://www.youtube.com/watch?v=video6" target="_blank">Ver video</a>
                </div>
            </div>
        </div>

        <footer>
            <p>&copy; 2024 by Small School</p>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz4fnFO9gybH0E5ytA6MCeCfeYk8FIqOaOGxVx1TBGK0SB6QW0o0fj72k3" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-ho+j7jyWK8fNQe+A1+P9e9Bbc6egJP7HrbNf1BjEzPIeyp0IIefyGh8Js80a45lT" crossorigin="anonymous"></script>
    </body>
</html>
