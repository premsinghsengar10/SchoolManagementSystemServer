<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Dashboard</title>
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

        .table thead {
            background-color: #212529;
            color: white;
        }

        .table thead th {
            border: none;
            font-weight: 500;
        }

        .nav-tabs .nav-link {
            color: #495057;
        }

        .nav-tabs .nav-link.active {
            color: #000;
            font-weight: 600;
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
                        <a class="nav-link" href="/">
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
            <h2 class="mb-0">Teacher Dashboard</h2>
            <p class="text-muted mb-0">Admin No: ${teacherAdminNo}</p>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container">
        <!-- Error/Success Messages -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i>${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Search Section -->
        <div class="content-card">
            <h3 class="section-title">
                <i class="bi bi-search me-2"></i>Search Student
            </h3>
            <form action="/teacher/search" method="get" class="row g-3">
                <div class="col-md-8">
                    <input type="text" name="keyword" class="form-control" placeholder="Enter Student Name or Admin No" required>
                </div>
                <div class="col-md-4">
                    <button type="submit" class="btn btn-dark w-100">
                        <i class="bi bi-search me-2"></i>Search
                    </button>
                </div>
            </form>

            <!-- Search Result -->
            <c:if test="${not empty searchResult}">
                <div class="alert alert-info mt-3" role="alert">
                    <h5 class="alert-heading">Search Result</h5>
                    <hr>
                    <p class="mb-1"><strong>Full Name:</strong> ${searchResult.fullName}</p>
                    <p class="mb-1"><strong>Admin No:</strong> ${searchResult.adminNo}</p>
                    <p class="mb-3"><strong>Standard:</strong> ${searchResult.standard}</p>
                    <a href="/teacher/report/${searchResult.adminNo}" class="btn btn-success btn-sm">
                        <i class="bi bi-file-earmark-pdf me-1"></i>Download Report
                    </a>
                </div>
            </c:if>
        </div>

        <!-- Tabs for Students, Attendance, and Marks -->
        <div class="content-card">
            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="students-tab" data-bs-toggle="tab" data-bs-target="#students" type="button">
                        <i class="bi bi-people me-2"></i>Students
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="attendance-tab" data-bs-toggle="tab" data-bs-target="#attendance" type="button">
                        <i class="bi bi-calendar-check me-2"></i>Attendance
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="marks-tab" data-bs-toggle="tab" data-bs-target="#marks" type="button">
                        <i class="bi bi-trophy me-2"></i>Marks
                    </button>
                </li>
            </ul>

            <div class="tab-content" id="myTabContent">
                <!-- Students Tab -->
                <div class="tab-pane fade show active" id="students" role="tabpanel">
                    <div class="table-responsive mt-3">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Admin No</th>
                                    <th>Full Name</th>
                                    <th>Standard</th>
                                    <th>Phone</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="student" items="${students}">
                                    <tr>
                                        <td>${student.id}</td>
                                        <td>${student.adminNo}</td>
                                        <td>${student.fullName}</td>
                                        <td>${student.standard}</td>
                                        <td>${student.phoneNo}</td>
                                        <td>
                                            <a href="/teacher/report/${student.adminNo}" class="btn btn-dark btn-sm">
                                                <i class="bi bi-download me-1"></i>Report
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Attendance Tab -->
                <div class="tab-pane fade" id="attendance" role="tabpanel">
                    <div class="d-flex justify-content-between align-items-center mt-3 mb-3">
                        <h5 class="mb-0">Attendance Records</h5>
                        <button class="btn btn-dark btn-sm" data-bs-toggle="modal" data-bs-target="#addAttendanceModal">
                            <i class="bi bi-plus-circle me-1"></i>Add Attendance
                        </button>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Admin No</th>
                                    <th>Month</th>
                                    <th>Days Attended</th>
                                    <th>Total Days</th>
                                    <th>Percentage</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="att" items="${attendanceList}">
                                    <tr>
                                        <td>${att.id}</td>
                                        <td>${att.adminNo}</td>
                                        <td>${att.month}</td>
                                        <td>${att.noOfDaysAttended}</td>
                                        <td>${att.totalNoOfWorkingDays}</td>
                                        <td>${att.percentage}%</td>
                                        <td>
                                            <button class="btn btn-sm btn-outline-primary" onclick="editAttendance(${att.id}, '${att.adminNo}', ${att.noOfDaysAttended}, ${att.totalNoOfWorkingDays}, '${att.month}')">
                                                <i class="bi bi-pencil"></i>
                                            </button>
                                            <a href="/teacher/attendance/delete/${att.id}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Are you sure?')">
                                                <i class="bi bi-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Marks Tab -->
                <div class="tab-pane fade" id="marks" role="tabpanel">
                    <div class="d-flex justify-content-between align-items-center mt-3 mb-3">
                        <h5 class="mb-0">Marks Records</h5>
                        <button class="btn btn-dark btn-sm" data-bs-toggle="modal" data-bs-target="#addMarksModal">
                            <i class="bi bi-plus-circle me-1"></i>Add Marks
                        </button>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Admin No</th>
                                    <th>Standard</th>
                                    <th>Year</th>
                                    <th>Exam</th>
                                    <th>English</th>
                                    <th>Maths</th>
                                    <th>Science</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="m" items="${marksList}">
                                    <tr>
                                        <td>${m.id}</td>
                                        <td>${m.adminNo}</td>
                                        <td>${m.standard}</td>
                                        <td>${m.year}</td>
                                        <td>${m.pfSelect}</td>
                                        <td>${m.english}</td>
                                        <td>${m.maths}</td>
                                        <td>${m.science}</td>
                                        <td>
                                            <button class="btn btn-sm btn-outline-primary" onclick="editMarks(${m.id}, '${m.adminNo}', '${m.standard}', ${m.year}, '${m.pfSelect}', ${m.english}, ${m.maths}, ${m.science})">
                                                <i class="bi bi-pencil"></i>
                                            </button>
                                            <a href="/teacher/marks/delete/${m.id}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Are you sure?')">
                                                <i class="bi bi-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Add Attendance Modal -->
    <div class="modal fade" id="addAttendanceModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add Student Attendance</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="/teacher/attendance/add" method="post">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Admin No</label>
                            <input type="text" name="adminNo" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">No of Days Attended</label>
                            <input type="number" name="noOfDaysAttended" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Total Working Days</label>
                            <input type="number" name="totalNoOfWorkingDays" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Month</label>
                            <input type="text" name="month" class="form-control" placeholder="e.g., January 2024" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-dark">Save</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Attendance Modal -->
    <div class="modal fade" id="editAttendanceModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Attendance</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form id="editAttendanceForm" method="post">
                    <div class="modal-body">
                        <input type="hidden" id="editAttId" name="id">
                        <div class="mb-3">
                            <label class="form-label">Admin No</label>
                            <input type="text" id="editAttAdminNo" name="adminNo" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">No of Days Attended</label>
                            <input type="number" id="editAttDaysAttended" name="noOfDaysAttended" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Total Working Days</label>
                            <input type="number" id="editAttTotalDays" name="totalNoOfWorkingDays" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Month</label>
                            <input type="text" id="editAttMonth" name="month" class="form-control" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-dark">Update</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Add Marks Modal -->
    <div class="modal fade" id="addMarksModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add Student Marks</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="/teacher/marks/add" method="post">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Admin No</label>
                            <input type="text" name="adminNo" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Standard</label>
                            <input type="text" name="standard" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Year</label>
                            <input type="number" name="year" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Exam Type</label>
                            <input type="text" name="pfSelect" class="form-control" placeholder="e.g., Mid-term, Final" required>
                        </div>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">English</label>
                                <input type="number" name="english" class="form-control" min="0" max="100" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Maths</label>
                                <input type="number" name="maths" class="form-control" min="0" max="100" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Science</label>
                                <input type="number" name="science" class="form-control" min="0" max="100" required>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-dark">Save</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Marks Modal -->
    <div class="modal fade" id="editMarksModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Marks</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form id="editMarksForm" method="post">
                    <div class="modal-body">
                        <input type="hidden" id="editMarksId" name="id">
                        <div class="mb-3">
                            <label class="form-label">Admin No</label>
                            <input type="text" id="editMarksAdminNo" name="adminNo" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Standard</label>
                            <input type="text" id="editMarksStandard" name="standard" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Year</label>
                            <input type="number" id="editMarksYear" name="year" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Exam Type</label>
                            <input type="text" id="editMarksPfSelect" name="pfSelect" class="form-control" required>
                        </div>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">English</label>
                                <input type="number" id="editMarksEnglish" name="english" class="form-control" min="0" max="100" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Maths</label>
                                <input type="number" id="editMarksMaths" name="maths" class="form-control" min="0" max="100" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Science</label>
                                <input type="number" id="editMarksScience" name="science" class="form-control" min="0" max="100" required>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-dark">Update</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function editAttendance(id, adminNo, daysAttended, totalDays, month) {
            document.getElementById('editAttId').value = id;
            document.getElementById('editAttAdminNo').value = adminNo;
            document.getElementById('editAttDaysAttended').value = daysAttended;
            document.getElementById('editAttTotalDays').value = totalDays;
            document.getElementById('editAttMonth').value = month;
            document.getElementById('editAttendanceForm').action = '/teacher/attendance/update/' + id;
            new bootstrap.Modal(document.getElementById('editAttendanceModal')).show();
        }

        function editMarks(id, adminNo, standard, year, pfSelect, english, maths, science) {
            document.getElementById('editMarksId').value = id;
            document.getElementById('editMarksAdminNo').value = adminNo;
            document.getElementById('editMarksStandard').value = standard;
            document.getElementById('editMarksYear').value = year;
            document.getElementById('editMarksPfSelect').value = pfSelect;
            document.getElementById('editMarksEnglish').value = english;
            document.getElementById('editMarksMaths').value = maths;
            document.getElementById('editMarksScience').value = science;
            document.getElementById('editMarksForm').action = '/teacher/marks/update/' + id;
            new bootstrap.Modal(document.getElementById('editMarksModal')).show();
        }
    </script>
</body>
</html>