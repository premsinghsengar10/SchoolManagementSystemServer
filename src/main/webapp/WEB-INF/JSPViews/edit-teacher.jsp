<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>Edit Teacher</title></head>
<body>
<h2>Edit Teacher</h2>
<form action="/admin/teachers/update/${teacher.id}" method="post">
    Full Name: <input type="text" name="fullName" value="${teacher.fullName}"/><br><br>
    DOB: <input type="date" name="dob" value="${teacher.dob}"/><br><br>
    Phone No: <input type="text" name="phoneNo" value="${teacher.phoneNo}"/><br><br>
    Teacher Admin No: <input type="text" name="teacherAdminNo" value="${teacher.teacherAdminNo}"/><br><br>

    <input type="submit" value="Update"/>
    <a href="/admin">Cancel</a>
</form>
</body>
</html>
