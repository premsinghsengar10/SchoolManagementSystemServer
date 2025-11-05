<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Parent Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .navbar {
            background-color: #000 !important;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .navbar-brand {
            font-weight: 600;
            font-size: 1.3rem;
        }

        .page-header {
            background-color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .content-card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
            padding: 1.5rem;
        }

        .section-title {
            color: #212529;
            font-weight: 600;
            font-size: 1.25rem;
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #dee2e6;
        }

        .table {
            margin-bottom: 0;
        }

        .table thead {
            background-color: #212529;
            color: white;
        }

        .table thead th {
            border: none;
            font-weight: 500;
        }

        .info-table td:first-child {
            font-weight: 600;
            color: #495057;
            width: 180px;
        }

        .btn-download {
            background-color: #212529;
            color: white;
            padding: 10px 25px;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
            transition: background-color 0.3s;
        }

        .btn-download:hover {
            background-color: #000;
            color: white;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">
                <i class="bi bi-building me-2"></i>Manhattan Associates
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="#">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/logout">
                            <i class="bi bi-box-arrow-right me-1"></i>Logout
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <h2 class="mb-0">Welcome, ${sessionScope.loggedInUser}</h2>
            <p class="text-muted mb-0">Parent Dashboard</p>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container">
        <c:if test="${not empty student}">
            <!-- Student Information -->
            <div class="content-card">
                <h3 class="section-title">Student Information</h3>
                <div class="table-responsive">
                    <table class="table table-borderless info-table">
                        <tbody>
                            <tr>
                                <td>Admin No</td>
                                <td>${student.adminNo}</td>
                            </tr>
                            <tr>
                                <td>Name</td>
                                <td>${student.fullName}</td>
                            </tr>
                            <tr>
                                <td>Class</td>
                                <td>${student.standard}</td>
                            </tr>
                            <tr>
                                <td>Teacher</td>
                                <td>${student.teacherAdminNo}</td>
                            </tr>
                            <tr>
                                <td>Phone</td>
                                <td>${student.phoneNo}</td>
                            </tr>
                            <tr>
                                <td>Address</td>
                                <td>${student.address}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Attendance -->
            <div class="content-card">
                <h3 class="section-title">Attendance</h3>
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Month</th>
                                <th>Attended</th>
                                <th>Total</th>
                                <th>Percentage</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="a" items="${attendanceList}">
                                <tr>
                                    <td>${a.month}</td>
                                    <td>${a.noOfDaysAttended}</td>
                                    <td>${a.totalNoOfWorkingDays}</td>
                                    <td>${a.percentage}%</td>
                                    <td>${a.status}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Marks -->
            <div class="content-card">
                <h3 class="section-title">Marks</h3>
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Exam</th>
                                <th>Standard</th>
                                <th>Year</th>
                                <th>English</th>
                                <th>Maths</th>
                                <th>Science</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="m" items="${marksList}">
                                <tr>
                                    <td>${m.pfSelect}</td>
                                    <td>${m.standard}</td>
                                    <td>${m.year}</td>
                                    <td>${m.english}</td>
                                    <td>${m.maths}</td>
                                    <td>${m.science}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Download Button -->
            <div class="text-center mb-4">
                <a href="/parent/report/${student.adminNo}" class="btn-download" target="_blank">
                    <i class="bi bi-file-earmark-pdf me-2"></i>Download Student Report (PDF)
                </a>
            </div>
        </c:if>

        <c:if test="${empty student}">
            <div class="content-card">
                <div class="alert alert-danger mb-0" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    <strong>No Record Found:</strong> No student record found for this parent account.
                </div>
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>