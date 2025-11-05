<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>Add Attendance</title></head>
<body>
<h2>Add Student Attendance</h2>

<form action="/teacher/attendance/add" method="post">
    <label>Admin No:</label><br>
    <input type="text" name="adminNo" required><br><br>

    <label>No of Days Attended:</label><br>
    <input type="number" name="noOfDaysAttended" required><br><br>

    <label>Total Working Days:</label><br>
    <input type="number" name="totalNoOfWorkingDays" required><br><br>

    <label>Month:</label><br>
    <input type="text" name="month" required><br><br>

    <button type="submit">Save</button>
</form>

<br>
<a href="/teacher/attendance/list">Back to Attendance List</a>
</body>
</html>
