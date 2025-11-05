<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Add Student</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<!-- Bootstrap Icons -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" />
<style>
    body {
        background-color: #f8f9fa; /* Light background */
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    .container {
        margin-top: 40px;
        margin-bottom: 40px;
    }
    .card {
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        padding: 2rem;
    }
    .card-header {
        background-color: #ffffff; /* White background for header */
        border-bottom: 1px solid #dee2e6;
        margin-bottom: 1.5rem;
        padding-bottom: 1rem;
        text-align: center;
    }
    .card-header h2 {
        color: #343a40; /* Darker text for header */
        font-weight: 600;
        margin-top: 10px;
        margin-bottom: 0;
    }
    .card-header i {
        font-size: 2.5rem;
        color: #007bff; /* Primary blue for icon */
    }
    .form-label {
        font-weight: 500;
        color: #495057;
    }
    .form-control {
        border-radius: 5px;
        padding-left: 2.5rem; /* Space for icon */
    }
    .form-icon {
        position: absolute;
        top: 62%; /* Adjusted for label */
        left: 15px;
        transform: translateY(-50%);
        color: #6c757d;
        font-size: 1rem;
    }
    .form-control:focus {
        border-color: #80bdff;
        box-shadow: 0 0 0 0.25rem rgba(0, 123, 255, 0.25);
    }
    .btn-primary {
        background-color: #007bff;
        border-color: #007bff;
        border-radius: 5px;
        padding: 0.75rem 1.5rem;
        font-weight: 600;
    }
    .btn-primary:hover {
        background-color: #0056b3;
        border-color: #0056b3;
    }
    .cancel-link {
        color: #6c757d;
        text-decoration: none;
        padding: 0.75rem 1.5rem;
        border: 1px solid #dee2e6;
        border-radius: 5px;
        transition: all 0.2s ease-in-out;
    }
    .cancel-link:hover {
        color: #dc3545;
        border-color: #dc3545;
        background-color: #f8d7da;
    }
</style>
</head>
<body>
<div class="container">
    <div class="card">
        <div class="card-header">
            <i class="bi bi-person-plus"></i>
            <h2>Add New Student</h2>
        </div>
        <form action="/admin/students/add" method="post" class="needs-validation" novalidate>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="adminNo" class="form-label">Admin No</label>
                    <div class="position-relative">
                        <i class="bi bi-person-badge form-icon"></i>
                        <input type="text" id="adminNo" name="adminNo" class="form-control" placeholder="Enter Admin No" required>
                    </div>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="fullName" class="form-label">Full Name</label>
                    <div class="position-relative">
                        <i class="bi bi-file-person form-icon"></i>
                        <input type="text" id="fullName" name="fullName" class="form-control" placeholder="Enter Full Name" required>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="dob" class="form-label">Date of Birth</label>
                    <div class="position-relative">
                        <i class="bi bi-calendar-date form-icon"></i>
                        <input type="date" id="dob" name="dob" class="form-control" required>
                    </div>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="standard" class="form-label">Standard</label>
                    <div class="position-relative">
                        <i class="bi bi-book form-icon"></i>
                        <input type="text" id="standard" name="standard" class="form-control" placeholder="e.g., 10th Grade" required>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="phoneNo" class="form-label">Phone No</label>
                    <div class="position-relative">
                        <i class="bi bi-telephone form-icon"></i>
                        <input type="text" id="phoneNo" name="phoneNo" class="form-control" placeholder="Enter Phone No" required>
                    </div>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="teacherAdminNo" class="form-label">Teacher Admin No</label>
                    <div class="position-relative">
                        <i class="bi bi-person-badge form-icon"></i>
                        <input type="text" id="teacherAdminNo" name="teacherAdminNo" class="form-control" placeholder="Enter Teacher Admin No" required>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="fatherName" class="form-label">Father's Name</label>
                    <div class="position-relative">
                        <i class="bi bi-person form-icon"></i>
                        <input type="text" id="fatherName" name="fatherName" class="form-control" placeholder="Enter Father's Name" required>
                    </div>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="motherName" class="form-label">Mother's Name</label>
                    <div class="position-relative">
                        <i class="bi bi-person form-icon"></i>
                        <input type="text" id="motherName" name="motherName" class="form-control" placeholder="Enter Mother's Name" required>
                    </div>
                </div>
            </div>
            <div class="mb-3">
                <label for="address" class="form-label">Address</label>
                <div class="position-relative">
                    <i class="bi bi-geo-alt form-icon"></i>
                    <input type="text" id="address" name="address" class="form-control" placeholder="Enter Address" required>
                </div>
            </div>

            <div class="d-flex justify-content-end align-items-center gap-2 mt-4">
                <a href="/admin" class="cancel-link">Cancel</a>
                <button type="submit" class="btn btn-primary">Save Student</button>
            </div>
        </form>
    </div>
</div>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>