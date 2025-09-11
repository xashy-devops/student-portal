<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Student - Xashy Tech University Student Portal</title>
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
                        <a class="nav-link active" href="<c:url value='/students/add'/>">
                            <i class="fas fa-user-plus me-1"></i>Add Student
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <!-- Header -->
        <div class="row mb-4">
            <div class="col-md-8">
                <h1 class="display-5">
                    <i class="fas fa-user-plus text-primary me-3"></i>
                    Add New Student
                </h1>
                <p class="lead text-muted">Register a new student in the university system</p>
            </div>
            <div class="col-md-4 text-end">
                <a href="<c:url value='/students/list'/>" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Back to Students
                </a>
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

        <!-- Add Student Form -->
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card border-0 shadow-lg">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">
                            <i class="fas fa-form me-2"></i>
                            Student Registration Form
                        </h5>
                    </div>
                    <div class="card-body p-4">
                        <form action="<c:url value='/students/add'/>" method="POST" id="studentForm">
                            
                            <!-- Personal Information Section -->
                            <div class="mb-4">
                                <h6 class="text-primary mb-3">
                                    <i class="fas fa-user me-2"></i>Personal Information
                                </h6>
                                
                                <div class="row">
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

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="email" class="form-label">
                                            Email Address <span class="text-danger">*</span>
                                        </label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                            <input type="email" class="form-control" id="email" name="email" 
                                                   value="${student.email}" required 
                                                   placeholder="student@xashytech.edu">
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
                                               value="${student.dateOfBirth}">
                                    </div>
                                    
                                    <div class="col-md-6 mb-3">
                                        <label for="studentId" class="form-label">
                                            Student ID
                                            <small class="text-muted">(auto-generated if blank)</small>
                                        </label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-id-card"></i></span>
                                            <input type="text" class="form-control" id="studentId" name="studentId" 
                                                   value="${student.studentId}" placeholder="XTU20250001">
                                        </div>
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
                                        <label for="status" class="form-label">Status</label>
                                        <select class="form-select" id="status" name="status">
                                            <option value="ACTIVE" ${student.status == 'ACTIVE' ? 'selected' : ''}>
                                                Active
                                            </option>
                                            <option value="INACTIVE" ${student.status == 'INACTIVE' ? 'selected' : ''}>
                                                Inactive
                                            </option>
                                            <option value="SUSPENDED" ${student.status == 'SUSPENDED' ? 'selected' : ''}>
                                                Suspended
                                            </option>
                                            <option value="GRADUATED" ${student.status == 'GRADUATED' ? 'selected' : ''}>
                                                Graduated
                                            </option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <!-- Form Actions -->
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <a href="<c:url value='/students/list'/>" class="btn btn-outline-secondary me-md-2">
                                    <i class="fas fa-times me-2"></i>Cancel
                                </a>
                                <button type="reset" class="btn btn-outline-warning me-md-2">
                                    <i class="fas fa-redo me-2"></i>Reset Form
                                </button>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i>Add Student
                                </button>
                            </div>
                        </form>
                    </div>
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

        // Auto-generate email based on name
        document.getElementById('firstName').addEventListener('blur', generateEmail);
        document.getElementById('lastName').addEventListener('blur', generateEmail);

        function generateEmail() {
            const firstName = document.getElementById('firstName').value.toLowerCase();
            const lastName = document.getElementById('lastName').value.toLowerCase();
            const emailField = document.getElementById('email');
            
            if (firstName && lastName && !emailField.value) {
                emailField.value = `${firstName}.${lastName}@xashytech.edu`;
            }
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
    </script>
    <script src="<c:url value='/static/js/app.js'/>"></script>
</body>
</html>
