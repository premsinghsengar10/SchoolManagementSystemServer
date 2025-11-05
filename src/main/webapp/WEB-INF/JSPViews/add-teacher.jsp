<html>
<head><title>Add Teacher</title></head>
<body>
<h2>Add Teacher</h2>
<form action="/admin/teachers/add" method="post">
    Full Name: <input type="text" name="fullName"/><br><br>
    DOB: <input type="date" name="dob"/><br><br>
    Phone No: <input type="text" name="phoneNo"/><br><br>
    Teacher Admin No: <input type="text" name="teacherAdminNo"/><br><br>

    <input type="submit" value="Save"/>
    <a href="/admin">Cancel</a>
</form>
</body>
</html>
