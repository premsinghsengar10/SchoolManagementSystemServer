<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>Marks List</title></head>
<body>
<h2>Student Marks Records</h2>

<a href="/teacher/marks/add">Add New Marks</a><br><br>

<table border="1" cellpadding="8">
    <tr>
        <th>ID</th>
        <th>Admin No</th>
        <th>Standard</th>
        <th>Year</th>
        <th>Preferred Subject</th>
        <th>English</th>
        <th>Maths</th>
        <th>Science</th>
        <th>Action</th>
    </tr>

    <c:forEach var="mark" items="${marksList}">
        <tr>
            <td>${mark.id}</td>
            <td>${mark.adminNo}</td>
            <td>${mark.standard}</td>
            <td>${mark.year}</td>
            <td>${mark.pfSelect}</td>
            <td>${mark.english}</td>
            <td>${mark.maths}</td>
            <td>${mark.science}</td>
            <td>
                <a href="/teacher/marks/edit/${mark.id}">Edit</a>
            </td>
        </tr>
    </c:forEach>
</table>

<br>
<a href="/teacher/dashboard">Back to Dashboard</a>
</body>
</html>
