<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>Edit Student Marks</title></head>
<body>
<h2>Edit Marks</h2>

<form action="/teacher/marks/update/${marks.id}" method="post">
    <label>Admin No:</label><br>
    <input type="text" name="adminNo" value="${marks.adminNo}" required><br><br>

    <label>Standard:</label><br>
    <input type="text" name="standard" value="${marks.standard}" required><br><br>

    <label>Year:</label><br>
    <input type="number" name="year" value="${marks.year}" required><br><br>

    <label>Preferred Subject:</label><br>
    <input type="text" name="pfSelect" value="${marks.pfSelect}" required><br><br>

    <label>English:</label><br>
    <input type="number" name="english" value="${marks.english}" required><br><br>

    <label>Maths:</label><br>
    <input type="number" name="maths" value="${marks.maths}" required><br><br>

    <label>Science:</label><br>
    <input type="number" name="science" value="${marks.science}" required><br><br>

    <button type="submit">Update</button>
</form>

<br>
<a href="/teacher/marks/list">Back to Marks List</a>
</body>
</html>
