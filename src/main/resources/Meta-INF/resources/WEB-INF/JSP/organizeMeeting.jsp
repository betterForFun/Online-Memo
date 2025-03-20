<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>${name}'s Meetings</title>
    <link href="webjars/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

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
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <%@include file="common/navigation.jsp" %>

<form action="/calculate-meeting-time" method="post">
    <div class="container">
        <div class="welcome-message">Welcome, ${name}!</div>
        <hr>

        <h1>Calculate Meeting time</h1>

        <table class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th>Start Time</th>
                    <th>End Time</th>
                    <th>Time Zone</th>
                    <th>Date</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${meetings}" var="meeting">
                    <tr class="meeting-row">
                        <td class="startTime">${meeting.startTime}</td>
                        <td class="endTime">${meeting.endTime}</td>
                        <td class="timeZone">${meeting.timeZone}</td>
                        <td class="date">${meeting.date}</td>
                        <td class="btn-group">
                            <button class="btn btn-danger btn-sm remove-btn">Remove</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <script>
        $(document).ready(function () {
            $("#calculateButton").click(function (event) {
                event.preventDefault();

                let meetings = [];
                $(".meeting-row").each(function () {
                    let startTime = $(this).find(".startTime").text();
                    let endTime = $(this).find(".endTime").text();
                    let timeZone = $(this).find(".timeZone").text();
                    let date = $(this).find(".date").text();
                    console.log(startTime);
                    console.log(endTime);
                    meetings.push({ startTime, endTime, timeZone, date});
                });

                $.ajax({
                    url: "/calculate-meeting-time",
                    type: "POST",
                    contentType: "application/json",
                    data: JSON.stringify(meetings),
                    success: function (response) {
                        Swal.fire({
                            title: "Suggested Meeting Time",
                            text: response.meetingTime,
                            icon: "success",
                            confirmButtonText: "Add to TodoList",
                            showCancelButton: true,
                            cancelButtonText: "Close",
                        }).then((result) => {
                            if (result.isConfirmed) {
                                console.log("Confirmed! Calling addToTodoList...");
                                addToTodoList(response);
                            }
                        });
                    },
                    error: function () {
                        Swal.fire({
                            title: "Error!",
                            text: "Failed to calculate meeting time.",
                            icon: "error",
                            confirmButtonText: "OK"
                        });
                    }
                });
            });
        });
        // Function to call backend /add-todo
        function addToTodoList(meetingTime) {
            meetingTime = JSON.stringify(meetingTime);
            let match = meetingTime.match(/(\d{1,2}:\d{2} [APM]{2}) - (\d{1,2}:\d{2} [APM]{2}) \/ ([A-Za-z_\/]+), (\d{4}-\d{2}-\d{2})/);

            console.log("Inside addToTodoList, meetingTime:", meetingTime);

            if (!match) {
                console.error("Invalid meetingTime format");
                return;
            }

            let startTime = match[1];
            let endTime = match[2];
            let timeZone = match[3];
            let date = match[4];

            console.log(startTime + " " + endTime + " " + timeZone + " " + date);

            let todo = {
                username: username, // Replace with the actual username (maybe fetch from session)
                description: "Meeting from " + startTime + " to " + endTime + " / " + timeZone,
                date: date, // "YYYY-MM-DD"
                done: false
            };

            $.ajax({
                url: "/add-todo",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(todo),
                success: function () {
                    Swal.fire({
                        title: "Added!",
                        text: "Meeting time added to your TodoList.",
                        icon: "success",
                        confirmButtonText: "OK"
                    }).then(() => {
                        window.location.href = "/todos"; // Redirect to todo list
                    });
                },
                error: function () {
                    Swal.fire({
                        title: "Error!",
                        text: "Failed to add meeting time to TodoList.",
                        icon: "error",
                        confirmButtonText: "OK"
                    });
                }
            });
        }
        // Convert "11:11 AM" to "HH:mm" (24-hour format)
        function convertTo24Hour(time) {
            let [hours, minutes, period] = time.match(/(\d{1,2}):(\d{2}) ([APM]{2})/).slice(1);
            hours = period === "PM" && hours !== "12" ? parseInt(hours) + 12 : hours;
            hours = period === "AM" && hours === "12" ? "00" : hours; // Handle midnight
            return `${hours}:${minutes}`;
        }
        </script>
        <!-- Add Meeting Button -->
        <div class="text-center">
            <a href="add-meetings" class="btn btn-primary mt-3">Add Meeting</a>
        </div>
        <div class="text-center mt-3">
            <button id="calculateButton" class="btn btn-success">Calculate</button>
        </div>
    </div>
</form>

    <script src="webjars/jquery/3.6.0/jquery.min.js"></script>
    <script src="webjars/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
    <script src="webjars/jquery/3.6.0/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            $(".remove-btn").click(function() {
                $(this).closest("tr").remove(); // Remove the clicked row
            });
        });
    </script>
    <script>
        let username = "${name}"; // Injects the session attribute
        console.log("Logged-in username:", username); // Debugging
    </script>

</body>
</html>
