<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Admin Dashboard - Manhattan School</title>
    <style>
        body {
            font-family: "Segoe UI", Arial, sans-serif;
            background-color: #f4f7fa;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #2c3e50;
            color: white;
            text-align: center;
            padding: 20px;
        }

        h1 {
            margin: 0;
            font-size: 28px;
        }

        .dashboard-stats {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 25px;
            margin: 30px 0;
        }

        .stat-card {
            background: white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            border-radius: 10px;
            padding: 25px;
            text-align: center;
            width: 250px;
            transition: 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-title {
            font-size: 18px;
            color: #777;
        }

        .stat-value {
            font-size: 32px;
            color: #2c3e50;
            font-weight: bold;
        }

        section {
            background: white;
            margin: 40px auto;
            padding: 20px;
            border-radius: 10px;
            width: 90%;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        section h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 10px;
        }

        section .add-btn {
            display: block;
            margin: 10px auto;
            width: 200px;
            text-align: center;
            padding: 10px;
            background-color: #3498db;
            color: white;
            border-radius: 6px;
            text-decoration: none;
            transition: 0.3s;
        }

        section .add-btn:hover {
            background-color: #2980b9;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        th, td {
            border: 1px solid #ddd;
            text-align: center;
            padding: 10px;
        }

        th {
            background-color: #f2f2f2;
            color: #333;
        }

        a.button {
            display: inline-block;
            padding: 6px 12px;
            margin: 3px;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        a.edit {
            background-color: #27ae60;
        }

        a.delete {
            background-color: #e74c3c;
        }

        footer {
            text-align: center;
            padding: 15px;
            background: #2c3e50;
            color: white;
            margin-top: 30px;
        }

        /* Search Bar */
        .search-bar {
            text-align: center;
            margin-bottom: 20px;
        }

        .search-bar input {
            width: 300px;
            padding: 8px;
            border-radius: 6px;
            border: 1px solid #ccc;
            margin-right: 8px;
        }

        .search-bar button {
            padding: 8px 15px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .search-bar a {
            padding: 8px 15px;
            background-color: #95a5a6;
            color: white;
            border-radius: 6px;
            text-decoration: none;
        }

        .search-bar button:hover {
            background-color: #2980b9;
        }

        .search-bar a:hover {
            background-color: #7f8c8d;
        }

    </style>
</head>
<body>

<header>
    <h1>Admin Dashboard</h1>
</header>

<!-- ===== Dashboard Stats ===== -->
<div class="dashboard-stats">
    <div class="stat-card">
        <div class="stat-title">Total Students</div>
        <div class="stat-value">${studentCount}</div>
    </div>

    <div class="stat-card">
        <div class="stat-title">Total Teachers</div>
        <div class="stat-value">${teacherCount}</div>
    </div>

    <div class="stat-card">
        <div class="stat-title">Average Attendance</div>
        <div class="stat-value">${attendanceAverage}%</div>
    </div>

</div>

<!-- ===== Students Section ===== -->
<section>
    <h2>Students</h2>

    <!-- 🔍 Search Form -->
    <div class="search-bar">
        <form action="/admin/dashboard" method="get">
            <input type="text" name="keyword" value="${keyword}" placeholder="Search by Name or Admin No">
            <button type="submit">Search</button>
            <a href="/admin/dashboard">Reset</a>
        </form>
    </div>

    <a href="/admin/students/add" class="add-btn">+ Add Student</a>

    <table>
        <thead>
        <tr>
            <th>ID</th>
			<th>Full Name</th>
            <th>email</th>
            <th>DOB</th>
            <th>Standard</th>
            <th>Phone</th>
            <th>Father</th>
            <th>Mother</th>
            <th>Address</th>
            <th>Teacher email</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${not empty students}">
                <c:forEach var="student" items="${students}">
                    <tr>
                        <td>${student.id}</td>
						<td>${student.fullName}</td>
                        <td>${student.adminNo}</td>
                        <td>${student.dob}</td>
                        <td>${student.standard}</td>
                        <td>${student.phoneNo}</td>
                        <td>${student.fatherName}</td>
                        <td>${student.motherName}</td>
                        <td>${student.address}</td>
                        <td>${student.teacherAdminNo}</td>
                        <td>
                            <a href="/admin/students/edit/${student.id}" class="button edit">Edit</a>
                            <a href="/admin/students/delete/${student.id}" class="button delete" onclick="return confirm('Are you sure you want to delete this student?')">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="11" style="color: #888;">No students found.</td>
                </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
</section>


<!-- ===== Teachers Section ===== -->
<!-- ===== Teachers Section ===== -->
<section>
    <h2>Teachers</h2>
    <a href="/admin/teachers/add" class="add-btn">+ Add Teacher</a>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Full Name</th>
            <th>DOB</th>
            <th>Phone</th>
            <th>Teacher email</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${not empty teachers}">
                <c:forEach var="teacher" items="${teachers}">
                    <tr>
                        <td>${teacher.id}</td>
                        <td>${teacher.fullName}</td>
                        <td>${teacher.dob}</td>
                        <td>${teacher.phoneNo}</td>
                        <td>${teacher.teacherAdminNo}</td>
                        <td>
                            <a href="/admin/teachers/edit/${teacher.id}" class="button edit">Edit</a>
                            <a href="/admin/teachers/delete/${teacher.id}" class="button delete"
                               onclick="return confirm('Are you sure you want to delete this teacher?')">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr><td colspan="6" style="color:#777;">No teachers data available yet.</td></tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
</section>




<footer>
    © 2025 Manhattan School Management System
</footer>

</body>
</html>
