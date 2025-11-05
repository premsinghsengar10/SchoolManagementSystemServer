<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>Edit Student</title></head>
<body>
<h2>Edit Student</h2>
<form action="/admin/students/update/${student.id}" method="post">
    Admin No: <input type="text" name="adminNo" value="${student.adminNo}"/><br><br>
    Full Name: <input type="text" name="fullName" value="${student.fullName}"/><br><br>
    DOB: <input type="date" name="dob" value="${student.dob}"/><br><br>
    Standard: <input type="text" name="standard" value="${student.standard}"/><br><br>
    Phone No: <input type="text" name="phoneNo" value="${student.phoneNo}"/><br><br>
    Father Name: <input type="text" name="fatherName" value="${student.fatherName}"/><br><br>
    Mother Name: <input type="text" name="motherName" value="${student.motherName}"/><br><br>
    Address: <input type="text" name="address" value="${student.address}"/><br><br>
    Teacher Admin No: <input type="text" name="teacherAdminNo" value="${student.teacherAdminNo}"/><br><br>

    <input type="submit" value="Update"/>
    <a href="/admin">Cancel</a>
</form>
</body>
</html>
