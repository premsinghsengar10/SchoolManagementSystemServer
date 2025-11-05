<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>Add Student Marks</title></head>
<body>
<h2>Add Student Marks</h2>

<form action="/teacher/marks/add" method="post">
    <label>Admin No:</label><br>
    <input type="text" name="adminNo" required><br><br>

    <label>Standard:</label><br>
    <input type="text" name="standard" required><br><br>

    <label>Year:</label><br>
    <input type="number" name="year" required><br><br>

    <label>Preferred Subject:</label><br>
    <input type="text" name="pfSelect" required><br><br>

    <label>English:</label><br>
    <input type="number" name="english" required><br><br>

    <label>Maths:</label><br>
    <input type="number" name="maths" required><br><br>

    <label>Science:</label><br>
    <input type="number" name="science" required><br><br>

    <button type="submit">Save</button>
</form>

<br>
<a href="/teacher/marks/list">Back to Marks List</a>
</body>
</html>
