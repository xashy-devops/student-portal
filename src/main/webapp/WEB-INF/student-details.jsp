<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Details - Xashy Tech University Student Portal</title>
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
        <!-- Header with Actions -->
        <div class="row mb-4">
            <div class="col-md-6">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="<c:url value='/students/dashboard'/>">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="<c:url value='/students/list'/>">Students</a></li>
                        <li class="breadcrumb-item active">Student Details</li>
                    </ol>
                </nav>
            </div>
            <div class="col-md-6 text-end">
                <div class="btn-group" role="group">
                    <a href="<c:url value='/students/list'/>" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Back to List
                    </a>
                    <a href="<c:url value='/students/${student.id}/edit'/>" class="btn btn-warning">
                        <i class="fas fa-edit me-2"></i>Edit Student
                    </a>
                    <button type="button" class="btn btn-danger" onclick="confirmDelete(${student.id}, '${student.fullName}')">
                        <i class="fas fa-trash me-2"></i>Delete
                    </button>
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

        <c:choose>
            <c:when test="${not empty student}">
                <div class="row">
                    <!-- Student Profile Card -->
                    <div class="col-lg-4 mb-4">
                        <div class="card border-0 shadow-sm h-100">
                            <div class="card-header bg-primary text-white text-center">
                                <div class="avatar-circle bg-white text-primary mx-auto mb-3" style="width: 80px; height: 80px; font-size: 2rem;">
                                    ${student.firstName.substring(0,1)}${student.lastName.substring(0,1)}
                                </div>
                                <h5 class="card-title mb-1">${student.fullName}</h5>
                                <p class="mb-0 opacity-75">
                                    <i class="fas fa-id-card me-1"></i>${student.studentId}
                                </p>
                            </div>
                            <div class="card-body">
                                <div class="text-center mb-3">
                                    <span class="badge ${student.active ? 'bg-success' : 'bg-danger'} fs-6">
                                        <i class="fas ${student.active ? 'fa-check' : 'fa-times'} me-1"></i>
                                        ${student.status}
                                    </span>
                                </div>
                                
                                <div class="row text-center">
                                    <div class="col-6">
                                        <div class="border-end">
                                            <div class="h4 mb-0 text-primary">
                                                <fmt:formatNumber value="${student.gpa}" maxFractionDigits="2" minFractionDigits="2"/>
                                            </div>
                                            <small class="text-muted">GPA</small>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="h4 mb-0 text-info">${student.yearSuffix}</div>
                                        <small class="text-muted">Academic Year</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Student Information -->
                    <div class="col-lg-8">
                        <div class="row">
                            <!-- Personal Information -->
                            <div class="col-12 mb-4">
                                <div class="card border-0 shadow-sm">
                                    <div class="card-header">
                                        <h6 class="card-title mb-0">
                                            <i class="fas fa-user text-primary me-2"></i>
                                            Personal Information
                                        </h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label text-muted small">Full Name</label>
                                                <div class="fw-bold">${student.fullName}</div>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label text-muted small">Email Address</label>
                                                <div>
                                                    <a href="mailto:${student.email}" class="text-decoration-none">
                                                        <i class="fas fa-envelope me-1"></i>${student.email}
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label text-muted small">Phone Number</label>
                                                <div>
                                                    <c:choose>
                                                        <c:when test="${not empty student.phoneNumber}">
                                                            <i class="fas fa-phone me-1"></i>${student.phoneNumber}
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">Not provided</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label text-muted small">Date of Birth</label>
                                                <div>
                                                    <c:choose>
                                                        <c:when test="${not empty student.dateOfBirth}">
                                                            <i class="fas fa-calendar me-1"></i>
                                                            <fmt:formatDate value="${student.dateOfBirth}" pattern="MMMM dd, yyyy"/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">Not provided</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Academic Information -->
                            <div class="col-12 mb-4">
                                <div class="card border-0 shadow-sm">
                                    <div class="card-header">
                                        <h6 class="card-title mb-0">
                                            <i class="fas fa-graduation-cap text-primary me-2"></i>
                                            Academic Information
                                        </h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label text-muted small">Program</label>
                                                <div>
                                                    <span class="badge bg-info fs-6">${student.program}</span>
                                                </div>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label text-muted small">Academic Year</label>
                                                <div class="fw-bold">${student.yearSuffix}</div>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label text-muted small">Grade Point Average</label>
                                                <div>
                                                    <span class="h5 mb-0 ${student.gpa >= 3.5 ? 'text-success' : student.gpa >= 3.0 ? 'text-warning' : 'text-danger'}">
                                                        <fmt:formatNumber value="${student.gpa}" maxFractionDigits="2" minFractionDigits="2"/>
                                                    </span>
                                                    <small class="text-muted">/ 4.00</small>
                                                </div>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label text-muted small">Enrollment Date</label>
                                                <div>
                                                    <i class="fas fa-calendar-plus me-1"></i>
                                                    <fmt:formatDate value="${student.enrollmentDate}" pattern="MMMM dd, yyyy"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Academic Progress -->
                            <div class="col-12">
                                <div class="card border-0 shadow-sm">
                                    <div class="card-header">
                                        <h6 class="card-title mb-0">
                                            <i class="fas fa-chart-line text-primary me-2"></i>
                                            Academic Progress
                                        </h6>
                                    </div>
                                    <div class="card-body">
                                        <!-- GPA Progress Bar -->
                                        <div class="mb-4">
                                            <div class="d-flex justify-content-between align-items-center mb-2">
                                                <span class="fw-bold">Overall GPA</span>
                                                <span class="badge ${student.gpa >= 3.5 ? 'bg-success' : student.gpa >= 3.0 ? 'bg-warning' : 'bg-danger'}">
                                                    <fmt:formatNumber value="${student.gpa}" maxFractionDigits="2" minFractionDigits="2"/>
                                                </span>
                                            </div>
                                            <div class="progress" style="height: 10px;">
                                                <div class="progress-bar ${student.gpa >= 3.5 ? 'bg-success' : student.gpa >= 3.0 ? 'bg-warning' : 'bg-danger'}" 
                                                     role="progressbar" 
                                                     style="width: ${(student.gpa / 4.0) * 100}%">
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Academic Standing -->
                                        <div class="row text-center">
                                            <div class="col-4">
                                                <div class="border-end">
                                                    <div class="h6 mb-0">
                                                        <c:choose>
                                                            <c:when test="${student.gpa >= 3.75}">Dean's List</c:when>
                                                            <c:when test="${student.gpa >= 3.5}">Honors</c:when>
                                                            <c:when test="${student.gpa >= 3.0}">Good Standing</c:when>
                                                            <c:when test="${student.gpa >= 2.0}">Probation</c:when>
                                                            <c:otherwise>At Risk</c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <small class="text-muted">Academic Standing</small>
                                                </div>
                                            </div>
                                            <div class="col-4">
                                                <div class="border-end">
                                                    <div class="h6 mb-0">
                                                        <fmt:formatDate value="${student.enrollmentDate}" pattern="yyyy"/>
                                                    </div>
                                                    <small class="text-muted">Enrollment Year</small>
                                                </div>
                                            </div>
                                            <div class="col-4">
                                                <div class="h6 mb-0">
                                                    <c:choose>
                                                        <c:when test="${student.year == '4'}">2025</c:when>
                                                        <c:when test="${student.year == '3'}">2026</c:when>
                                                        <c:when test="${student.year == '2'}">2027</c:when>
                                                        <c:otherwise>2028</c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <small class="text-muted">Expected Graduation</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="row mt-4">
                    <div class="col-12">
                        <div class="card border-0 shadow-sm">
                            <div class="card-header">
                                <h6 class="card-title mb-0">
                                    <i class="fas fa-bolt text-warning me-2"></i>
                                    Quick Actions
                                </h6>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-3 mb-2">
                                        <a href="<c:url value='/students/${student.id}/edit'/>" class="btn btn-warning w-100">
                                            <i class="fas fa-edit me-2"></i>Edit Profile
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-2">
                                        <a href="mailto:${student.email}" class="btn btn-info w-100">
                                            <i class="fas fa-envelope me-2"></i>Send Email
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-2">
                                        <button class="btn btn-secondary w-100" onclick="window.print()">
                                            <i class="fas fa-print me-2"></i>Print Details
                                        </button>
                                    </div>
                                    <div class="col-md-3 mb-2">
                                        <a href="<c:url value='/students/api/students/${student.id}'/>" target="_blank" class="btn btn-outline-primary w-100">
                                            <i class="fas fa-code me-2"></i>JSON Data
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Student Not Found -->
                <div class="text-center py-5">
                    <i class="fas fa-user-slash fa-4x text-muted mb-4"></i>
                    <h3 class="text-muted">Student Not Found</h3>
                    <p class="text-muted">The requested student could not be found in the system.</p>
                    <a href="<c:url value='/students/list'/>" class="btn btn-primary">
                        <i class="fas fa-arrow-left me-2"></i>Back to Student List
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
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
        function confirmDelete(studentId, studentName) {
            document.getElementById('studentName').textContent = studentName;
            document.getElementById('deleteForm').action = '/students/' + studentId + '/delete';
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }
    </script>
    <script src="<c:url value='/static/js/app.js'/>"></script>
</body>
</html>
