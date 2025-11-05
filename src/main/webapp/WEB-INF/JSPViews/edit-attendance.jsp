<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>Edit Attendance</title></head>
<body>
<h2>Edit Attendance</h2>

<form action="/teacher/attendance/update/${attendance.id}" method="post">
    <label>Admin No:</label><br>
    <input type="text" name="adminNo" value="${attendance.adminNo}" required><br><br>

    <label>No of Days Attended:</label><br>
    <input type="number" name="noOfDaysAttended" value="${attendance.noOfDaysAttended}" required><br><br>

    <label>Total Working Days:</label><br>
    <input type="number" name="totalNoOfWorkingDays" value="${attendance.totalNoOfWorkingDays}" required><br><br>

    <label>Month:</label><br>
    <input type="text" name="month" value="${attendance.month}" required><br><br>

    <button type="submit">Update</button>
</form>

<br>
<a href="/teacher/attendance/list">Back to Attendance List</a>
</body>
</html>
