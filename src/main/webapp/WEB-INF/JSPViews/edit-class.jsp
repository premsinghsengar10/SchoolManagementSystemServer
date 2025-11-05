<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>Edit Class</title></head>
<body>
<h2>Edit Class</h2>
<form action="/admin/classes/update/${classDetails.id}" method="post">
    Class Name: <input type="text" name="className" value="${classDetails.className}"/><br><br>
    Section: <input type="text" name="section" value="${classDetails.section}"/><br><br>

    Class Teacher:
    <select name="classTeacher.id">
        <option value="">-- Select Teacher --</option>
        <c:forEach var="t" items="${teachers}">
            <option value="${t.id}" <c:if test="${classDetails.classTeacher != null && t.id == classDetails.classTeacher.id}">selected</c:if>>
                ${t.fullName}
            </option>
        </c:forEach>
    </select><br><br>

    <input type="submit" value="Update"/>
    <a href="/admin/classes">Cancel</a>
</form>
</body>
</html>
