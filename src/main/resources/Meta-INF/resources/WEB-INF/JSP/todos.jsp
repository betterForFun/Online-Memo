<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>${name}'s Memos</title>
    <link href="webjars/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }
        .container {
            max-width: 800px;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.1);
            margin-top: 50px;
        }
        h1 {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }
        .welcome-message {
            font-size: 20px;
            font-weight: bold;
            color: #555;
            text-align: center;
            margin-bottom: 15px;
        }
        .table th {
            background-color: #007bff;
            color: white;
            text-align: center;
        }
        .table td {
            text-align: center;
            vertical-align: middle;
        }
        .btn-group {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        .btn-custom {
            width: 48%;
            padding: 8px;
            font-size: 14px;
            border-radius: 5px;
        }
    </style>
</head>
<body>

    <%@include file="common/navigation.jsp" %>

    <div class="container">
        <div class="welcome-message">Welcome, ${name}!</div>
        <hr>

        <h1>Your Todos</h1>

        <table class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th>Description</th>
                    <th>Target Date</th>
                    <th>Is Done?</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${todos}" var="todo">
                    <tr>
                        <td>${todo.description}</td>
                        <td>${todo.date}</td>
                        <td>${todo.done ? "Yes" : "No"}</td>
                        <td class="btn-group">
                            <a href="update-todo?id=${todo.id}" class="btn btn-warning btn-sm">Edit</a>
                            <a href="delete-todo?id=${todo.id}" class="btn btn-danger btn-sm">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Add Todo Button -->
        <div class="text-center">
            <a href="add-todo" class="btn btn-primary mt-3">Add Todo</a>
        </div>
    </div>

    <script src="webjars/jquery/3.6.0/jquery.min.js"></script>
    <script src="webjars/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>

</body>
</html>
