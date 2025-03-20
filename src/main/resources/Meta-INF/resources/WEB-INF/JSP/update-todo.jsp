<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
    <title>Add Todo</title>
    <link href="webjars/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
    <link href="webjars/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.standalone.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #667eea, #764ba2);
            font-family: 'Arial', sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            max-width: 500px;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 10px 20px rgba(0,0,0,0.2);
            margin-top: 80px;
            text-align: center;
        }
        .navbar {
            width: 100%;
        }
        h1 {
            font-size: 26px;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
        }
        .form-label {
            font-weight: bold;
            text-align: left;
            display: block;
        }
        .btn-group {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .btn-custom {
            width: 48%;
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
        }
        .btn-group button {
             margin-right: 10px; /* Add space between buttons */
        }

        .btn-group button:last-child {
            margin-right: 0;
        }
        .text-danger {
            font-size: 14px;
        }
    </style>
</head>
<body>

    <%@include file="common/navigation.jsp" %>

    <div class="container">
        <h1>update Todo</h1>

        <form:form method="post" modelAttribute="todo">
            <div class="mb-3">
                <form:label path="description" class="form-label">Description</form:label>
                <form:input type="text" path="description" class="form-control" placeholder="Enter description" required="required"/>
                <form:errors path="description" cssClass="text-danger"/>
            </div>

            <div class="mb-3">
                <form:label path="date" class="form-label">Target Date</form:label>
                <form:input type="text" path="date" class="form-control" id="date" placeholder="YYYY-MM-DD" required="required"/>
                <form:errors path="date" cssClass="text-danger"/>
            </div>

            <!-- Buttons -->
            <div class="btn-group">
                <button type="submit" class="btn btn-success btn-custom">update Todo</button>
                <button type="button" class="btn btn-secondary btn-custom" onclick="window.location.href='/todos'">Back</button>
            </div>

            <!-- Hidden fields -->
            <form:input type="hidden" path="id"/>
            <form:input type="hidden" path="done"/>
        </form:form>
    </div>

    <script src="webjars/jquery/3.6.0/jquery.min.js"></script>
    <script src="webjars/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
    <script src="webjars/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#date').datepicker({
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayHighlight: true
            });
        });
    </script>
</body>
</html>
