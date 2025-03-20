<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
    <title>Select Availability</title>
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
        .text-danger {
            font-size: 14px;
        }
    </style>
</head>
<body>

    <%@include file="common/navigation.jsp" %>

    <div class="container">
        <h1>Select Your Availability</h1>

        <form:form method="post" modelAttribute="timeSlot">
            <div class="mb-3">
                <form:label path="startTime" class="form-label">Start Time</form:label>
                <form:input type="time" path="startTime" class="form-control" required="required"/>
                <form:errors path="startTime" cssClass="text-danger"/>
            </div>

            <div class="mb-3">
                <form:label path="endTime" class="form-label">End Time</form:label>
                <form:input type="time" path="endTime" class="form-control" required="required"/>
                <form:errors path="endTime" cssClass="text-danger"/>
            </div>
            <div class="mb-3">
                <form:label path="date" class="form-label">Target Date</form:label>
                <form:input type="text" path="date" class="form-control" id="date" placeholder="YYYY-MM-DD" required="required"/>
                <form:errors path="date" cssClass="text-danger"/>
            </div>
            <div class="mb-3">
                            <form:label path="timeZone" class="form-label">Time Zone</form:label>
                            <form:select path="timeZone" class="form-control">
                                <form:option value="UTC" label="UTC"/>
                                <form:option value="America/New_York" label="New York (EST)"/>
                                <form:option value="America/Chicago" label="Chicago (CST)"/>
                                <form:option value="America/Denver" label="Denver (MST)"/>
                                <form:option value="America/Los_Angeles" label="Los Angeles (PST)"/>
                                <form:option value="Europe/London" label="London (GMT)"/>
                                <form:option value="Europe/Paris" label="Paris (CET)"/>
                                <form:option value="Asia/Tokyo" label="Tokyo (JST)"/>
                            </form:select>
                            <form:errors path="timeZone" cssClass="text-danger"/>
                        </div>

            <div class="btn-group">
                <button type="submit" class="btn btn-success btn-custom">Add Availability</button>
                <button type="button" class="btn btn-secondary btn-custom" onclick="window.location.href='/meetings'">Cancel</button>
            </div>
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
