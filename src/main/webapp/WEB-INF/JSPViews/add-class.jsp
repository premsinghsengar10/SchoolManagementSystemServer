<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>Add Class</title></head>
<body>
<h2>Add New Class</h2>
<form action="/admin/classes/add" method="post">
    Class Name: <input type="text" name="className"/><br><br>
    Section: <input type="text" name="section"/><br><br>

    Class Teacher:
    <select name="classTeacher.id">
        <option value="">-- Select Teacher --</option>
        <c:forEach var="t" items="${teachers}">
            <option value="${t.id}">${t.fullName}</option>
        </c:forEach>
    </select><br><br>

    <input type="submit" value="Save"/>
    <a href="/admin/classes">Cancel</a>
</form>
</body>
</html>
