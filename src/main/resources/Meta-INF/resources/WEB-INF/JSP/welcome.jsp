<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome Page</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(45deg, #4CAF50, #81C784);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            padding: 40px 50px;
            width: 100%;
            max-width: 600px;
            text-align: center;
            transform: scale(1);
            transition: transform 0.3s ease-in-out;
        }

        .container:hover {
            transform: scale(1.05);
        }

        h1 {
            font-size: 48px;
            color: #4CAF50;
            margin-bottom: 20px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        div {
            font-size: 20px;
            color: #333;
            margin: 15px 0;
            line-height: 1.6;
        }

        .name {
            font-weight: bold;
            color: #2e7d32;
        }

        a {
            text-decoration: none;
            color: #ffffff;
            font-weight: bold;
            background: #007BFF;
            padding: 12px 25px;
            border-radius: 25px;
            transition: all 0.3s ease;
            display: inline-block;
            margin-top: 20px;
        }

        a:hover {
            background: #0056b3;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
            transform: translateY(-2px);
        }

        .footer {
            margin-top: 30px;
            font-size: 14px;
            color: #757575;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome</h1>
        <div>Your Name: <span class="name">${name}</span></div>
        <div>
            <a href="todos">Manage your todos</a>
        </div>
        <div class="footer">
            <p>Make your life easier!</p>
        </div>
    </div>
</body>
</html>
