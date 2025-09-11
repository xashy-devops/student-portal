<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Student - Xashy Tech University Student Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="<c:url value='/static/css/style.css'/>" rel="stylesheet">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="<c:url value='/students/dashboard'/>">
                <i class="fas fa-graduation-cap me-2"></i>
                Xashy Tech University
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/students/dashboard'/>">
                            <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/students/list'/>">
                            <i class="fas fa-users me-1"></i>Students
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/students/add'/>">
                            <i class="fas fa-user-plus me-1"></i>Add Student
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <!-- Header with Breadcrumb -->
        <div class="row mb-4">
            <div class="col-md-8">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="<c:url value='/students/dashboard'/>">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="<c:url value='/students/list'/>">Students</a></li>
                        <li class="breadcrumb-item"><a href="<c:url value='/students/${student.id}'/>">Student Details</a></li>
                        <li class="breadcrumb-item active">Edit</li>
                    </ol>
                </nav>
                <h1 class="display-5">
                    <i class="fas fa-user-edit text-primary me-3"></i>
                    Edit Student
                </h1>
                <p class="lead text-muted">Update student information in the university system</p>
            </div>
            <div class="col-md-4 text-end">
                <div class="btn-group" role="group">
                    <a href="<c:url value='/students/${student.id}'/>" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Back to Details
                    </a>
                    <a href="<c:url value='/students/list'/>" class="btn btn-outline-primary">
                        <i class="fas fa-list me-2"></i>All Students
                    </a>
                </div>
            </div>
        </div>

        <!-- Alert Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Edit Student Form -->
        <div class="row">
            <!-- Student Preview Card -->
            <div class="col-lg-4 mb-4">
                <div class="card border-0 shadow-sm sticky-top" style="top: 20px;">
                    <div class="card-header bg-primary text-white text-center">
                        <div class="avatar-circle bg-white text-primary mx-auto mb-3" style="width: 60px; height: 60px; font-size: 1.5rem;">
                            ${student.firstName.substring(0,1)}${student.lastName.substring(0,1)}
                        </div>
                        <h6 class="card-title mb-1">${student.fullName}</h6>
                        <small class="opacity-75">
                            <i class="fas fa-id-card me-1"></i>${student.studentId}
                        </small>
                    </div>
                    <div class="card-body">
                        <div class="text-center mb-3">
                            <span class="badge ${student.active ? 'bg-success' : 'bg-danger'} fs-6">
                                <i class="fas ${student.active ? 'fa-check' : 'fa-times'} me-1"></i>
                                ${student.status}
                            </span>
                        </div>
                        
                        <div class="mb-3">
                            <small class="text-muted">Current Program</small>
                            <div class="fw-bold">${student.program}</div>
                        </div>
                        
                        <div class="mb-3">
                            <small class="text-muted">Academic Year</small>
                            <div class="fw-bold">${student.yearSuffix}</div>
                        </div>
                        
                        <div class="mb-3">
                            <small class="text-muted">Current GPA</small>
                            <div class="fw-bold text-primary">
                                <fmt:formatNumber value="${student.gpa}" maxFractionDigits="2" minFractionDigits="2"/>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <small class="text-muted">Enrolled Since</small>
                            <div class="fw-bold">
                                <fmt:formatDate value="${student.enrollmentDate}" pattern="MMM yyyy"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Edit Form -->
            <div class="col-lg-8">
                <div class="card border-0 shadow-lg">
                    <div class="card-header bg-warning text-dark">
                        <h5 class="card-title mb-0">
                            <i class="fas fa-edit me-2"></i>
                            Update Student Information
                        </h5>
                    </div>
                    <div class="card-body p-4">
                        <form action="<c:url value='/students/${student.id}/edit'/>" method="POST" id="editStudentForm" class="needs-validation" novalidate>
                            
                            <!-- Personal Information Section -->
                            <div class="mb-4">
                                <h6 class="text-primary mb-3">
                                    <i class="fas fa-user me-2"></i>Personal Information
                                </h6>
                                
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="email" class="form-label">
                                            Email Address <span class="text-danger">*</span>
                                        </label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                            <input type="email" class="form-control" id="email" name="email" 
                                                   value="${student.email}" required>
                                        </div>
                                        <div class="invalid-feedback">
                                            Please provide a valid email address.
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6 mb-3">
                                        <label for="phoneNumber" class="form-label">Phone Number</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                            <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" 
                                                   value="${student.phoneNumber}" placeholder="(555) 123-4567">
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="dateOfBirth" class="form-label">Date of Birth</label>
                                        <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" 
                                               value="<fmt:formatDate value='${student.dateOfBirth}' pattern='yyyy-MM-dd'/>">
                                    </div>
                                    
                                    <div class="col-md-6 mb-3">
                                        <label for="studentId" class="form-label">
                                            Student ID <span class="text-danger">*</span>
                                        </label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-id-card"></i></span>
                                            <input type="text" class="form-control" id="studentId" name="studentId" 
                                                   value="${student.studentId}" required readonly>
                                        </div>
                                        <div class="form-text">Student ID cannot be changed</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Academic Information Section -->
                            <div class="mb-4">
                                <h6 class="text-primary mb-3">
                                    <i class="fas fa-graduation-cap me-2"></i>Academic Information
                                </h6>
                                
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="program" class="form-label">
                                            Program <span class="text-danger">*</span>
                                        </label>
                                        <select class="form-select" id="program" name="program" required>
                                            <option value="">Select a program...</option>
                                            <option value="Computer Science" ${student.program == 'Computer Science' ? 'selected' : ''}>
                                                Computer Science
                                            </option>
                                            <option value="Software Engineering" ${student.program == 'Software Engineering' ? 'selected' : ''}>
                                                Software Engineering
                                            </option>
                                            <option value="Cybersecurity" ${student.program == 'Cybersecurity' ? 'selected' : ''}>
                                                Cybersecurity
                                            </option>
                                            <option value="Data Science" ${student.program == 'Data Science' ? 'selected' : ''}>
                                                Data Science
                                            </option>
                                            <option value="DevOps Engineering" ${student.program == 'DevOps Engineering' ? 'selected' : ''}>
                                                DevOps Engineering
                                            </option>
                                        </select>
                                        <div class="invalid-feedback">
                                            Please select a program.
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6 mb-3">
                                        <label for="year" class="form-label">
                                            Academic Year <span class="text-danger">*</span>
                                        </label>
                                        <select class="form-select" id="year" name="year" required>
                                            <option value="">Select year...</option>
                                            <option value="1" ${student.year == '1' ? 'selected' : ''}>1st Year</option>
                                            <option value="2" ${student.year == '2' ? 'selected' : ''}>2nd Year</option>
                                            <option value="3" ${student.year == '3' ? 'selected' : ''}>3rd Year</option>
                                            <option value="4" ${student.year == '4' ? 'selected' : ''}>4th Year</option>
                                        </select>
                                        <div class="invalid-feedback">
                                            Please select an academic year.
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="gpa" class="form-label">GPA</label>
                                        <input type="number" class="form-control" id="gpa" name="gpa" 
                                               value="${student.gpa}" min="0" max="4" step="0.01" 
                                               placeholder="3.50">
                                        <div class="form-text">Enter GPA on a 4.0 scale</div>
                                    </div>
                                    
                                    <div class="col-md-6 mb-3">
                                        <label for="status" class="form-label">Status <span class="text-danger">*</span></label>
                                        <select class="form-select" id="status" name="status" required>
                                            <option value="ACTIVE" ${student.status == 'ACTIVE' ? 'selected' : ''}>
                                                <i class="fas fa-check text-success"></i> Active
                                            </option>
                                            <option value="INACTIVE" ${student.status == 'INACTIVE' ? 'selected' : ''}>
                                                <i class="fas fa-pause text-warning"></i> Inactive
                                            </option>
                                            <option value="SUSPENDED" ${student.status == 'SUSPENDED' ? 'selected' : ''}>
                                                <i class="fas fa-ban text-danger"></i> Suspended
                                            </option>
                                            <option value="GRADUATED" ${student.status == 'GRADUATED' ? 'selected' : ''}>
                                                <i class="fas fa-graduation-cap text-info"></i> Graduated
                                            </option>
                                        </select>
                                        <div class="invalid-feedback">
                                            Please select a status.
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- System Information (Read-only) -->
                            <div class="mb-4">
                                <h6 class="text-muted mb-3">
                                    <i class="fas fa-info-circle me-2"></i>System Information
                                </h6>
                                
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label text-muted">Enrollment Date</label>
                                        <input type="text" class="form-control" 
                                               value="<fmt:formatDate value='${student.enrollmentDate}' pattern='MMMM dd, yyyy'/>" 
                                               readonly>
                                        <div class="form-text">Enrollment date cannot be changed</div>
                                    </div>
                                    
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label text-muted">Last Updated</label>
                                        <input type="text" class="form-control" 
                                               value="<fmt:formatDate value='${now}' pattern='MMMM dd, yyyy - HH:mm'/>" 
                                               readonly>
                                        <div class="form-text">System generated timestamp</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Form Actions -->
                            <div class="border-top pt-4">
                                <div class="d-grid gap-2 d-md-flex justify-content-md-between">
                                    <div>
                                        <button type="button" class="btn btn-outline-danger" onclick="confirmDelete(${student.id}, '${student.fullName}')">
                                            <i class="fas fa-trash me-2"></i>Delete Student
                                        </button>
                                    </div>
                                    <div class="d-flex gap-2">
                                        <a href="<c:url value='/students/${student.id}'/>" class="btn btn-outline-secondary">
                                            <i class="fas fa-times me-2"></i>Cancel
                                        </a>
                                        <button type="reset" class="btn btn-outline-warning">
                                            <i class="fas fa-undo me-2"></i>Reset Changes
                                        </button>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save me-2"></i>Update Student
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Confirm Delete</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="text-center">
                        <i class="fas fa-exclamation-triangle fa-3x text-warning mb-3"></i>
                        <p>Are you sure you want to delete student <strong id="studentName"></strong>?</p>
                        <p class="text-muted small">This action cannot be undone and will permanently remove all student data.</p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <form id="deleteForm" method="POST" style="display: inline;">
                        <button type="submit" class="btn btn-danger">
                            <i class="fas fa-trash me-1"></i>Delete Student
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-light mt-5 py-4">
        <div class="container text-center">
            <div class="row">
                <div class="col-12">
                    <p class="text-muted mb-0">
                        © 2025 Xashy Tech University Student Portal | 
                        <a href="<c:url value='/students/health'/>" target="_blank">System Health</a> |
                        Built with ❤️ for DevOps Learning
                    </p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Form validation
        (function() {
            'use strict';
            window.addEventListener('load', function() {
                var forms = document.getElementsByClassName('needs-validation');
                var validation = Array.prototype.filter.call(forms, function(form) {
                    form.addEventListener('submit', function(event) {
                        if (form.checkValidity() === false) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    }, false);
                });
            }, false);
        })();

        // Delete confirmation function
        function confirmDelete(studentId, studentName) {
            document.getElementById('studentName').textContent = studentName;
            document.getElementById('deleteForm').action = '/students/' + studentId + '/delete';
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }

        // Phone number formatting
        document.getElementById('phoneNumber').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length >= 6) {
                value = value.replace(/(\d{3})(\d{3})(\d{4})/, '($1) $2-$3');
            } else if (value.length >= 3) {
                value = value.replace(/(\d{3})(\d{0,3})/, '($1) $2');
            }
            e.target.value = value;
        });

        // Unsaved changes warning
        let formChanged = false;
        const form = document.getElementById('editStudentForm');
        const originalData = new FormData(form);

        form.addEventListener('change', function() {
            formChanged = true;
        });

        window.addEventListener('beforeunload', function(e) {
            if (formChanged) {
                e.preventDefault();
                e.returnValue = '';
            }
        });

        form.addEventListener('submit', function() {
            formChanged = false;
        });
    </script>
    <script src="<c:url value='/static/js/app.js'/>"></script>
</body>
</html> class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="firstName" class="form-label">
                                            First Name <span class="text-danger">*</span>
                                        </label>
                                        <input type="text" class="form-control" id="firstName" name="firstName" 
                                               value="${student.firstName}" required>
                                        <div class="invalid-feedback">
                                            Please provide a valid first name.
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6 mb-3">
                                        <label for="lastName" class="form-label">
                                            Last Name <span class="text-danger">*</span>
                                        </label>
                                        <input type="text" class="form-control" id="lastName" name="lastName" 
                                               value="${student.lastName}" required>
                                        <div class="invalid-feedback">
                                            Please provide a valid last name.
                                        </div>
                                    </div>
                                </div>

                                <div
                                