<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>Attendance List</title></head>
<body>
<h2>Student Attendance Records</h2>

<a href="/teacher/attendance/add">Add New Attendance</a><br><br>

<table border="1" cellpadding="8">
    <tr>
        <th>ID</th>
        <th>Admin No</th>
        <th>Days Attended</th>
        <th>Total Working Days</th>
        <th>Percentage</th>
        <th>Month</th>
        <th>Status</th>
        <th>Action</th>
    </tr>

    <c:forEach var="att" items="${attendanceList}">
        <tr>
            <td>${att.id}</td>
            <td>${att.adminNo}</td>
            <td>${att.noOfDaysAttended}</td>
            <td>${att.totalNoOfWorkingDays}</td>
            <td>${att.percentage}</td>
            <td>${att.month}</td>
            <td>${att.status}</td>
            <td>
                <a href="/teacher/attendance/edit/${att.id}">Edit</a>
            </td>
        </tr>
    </c:forEach>
</table>

<br>
<a href="/teacher/dashboard">Back to Dashboard</a>
</body>
</html>
