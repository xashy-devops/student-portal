<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Xashy Tech University Student Portal</title>
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
                        <a class="nav-link active" href="<c:url value='/students/dashboard'/>">
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
        <!-- Header -->
        <div class="row mb-4">
            <div class="col-12">
                <h1 class="display-4">
                    <i class="fas fa-tachometer-alt text-primary me-3"></i>
                    Student Portal Dashboard
                </h1>
                <p class="lead text-muted">Welcome to Xashy Tech University Student Management System</p>
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

        <!-- Statistics Cards -->
        <div class="row mb-5">
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-body">
                        <div class="d-flex align-items-center">
                            <div class="flex-shrink-0">
                                <i class="fas fa-users fa-2x text-primary"></i>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <div class="text-muted small">Total Students</div>
                                <div class="h4 mb-0">${totalStudents != null ? totalStudents : 0}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-body">
                        <div class="d-flex align-items-center">
                            <div class="flex-shrink-0">
                                <i class="fas fa-user-check fa-2x text-success"></i>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <div class="text-muted small">Active Students</div>
                                <div class="h4 mb-0">${activeStudents != null ? activeStudents : 0}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-body">
                        <div class="d-flex align-items-center">
                            <div class="flex-shrink-0">
                                <i class="fas fa-chart-line fa-2x text-info"></i>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <div class="text-muted small">Average GPA</div>
                                <div class="h4 mb-0">
                                    <fmt:formatNumber value="${averageGpa != null ? averageGpa : 0}" 
                                                    maxFractionDigits="2" minFractionDigits="2"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-body">
                        <div class="d-flex align-items-center">
                            <div class="flex-shrink-0">
                                <i class="fas fa-graduation-cap fa-2x text-warning"></i>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <div class="text-muted small">Programs</div>
                                <div class="h4 mb-0">5</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="row mb-5">
            <div class="col-12">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white">
                        <h5 class="card-title mb-0">
                            <i class="fas fa-bolt text-warning me-2"></i>
                            Quick Actions
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <a href="<c:url value='/students/add'/>" class="btn btn-primary btn-lg w-100">
                                    <i class="fas fa-user-plus me-2"></i>
                                    Add New Student
                                </a>
                            </div>
                            <div class="col-md-4 mb-3">
                                <a href="<c:url value='/students/list'/>" class="btn btn-outline-primary btn-lg w-100">
                                    <i class="fas fa-list me-2"></i>
                                    View All Students
                                </a>
                            </div>
                            <div class="col-md-4 mb-3">
                                <a href="<c:url value='/students/api/students'/>" class="btn btn-outline-secondary btn-lg w-100" target="_blank">
                                    <i class="fas fa-code me-2"></i>
                                    API Endpoint
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Students -->
        <div class="row">
            <div class="col-12">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white">
                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="card-title mb-0">
                                <i class="fas fa-clock text-info me-2"></i>
                                Recent Students
                            </h5>
                            <a href="<c:url value='/students/list'/>" class="btn btn-sm btn-outline-primary">
                                View All <i class="fas fa-arrow-right ms-1"></i>
                            </a>
                        </div>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty students}">
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Student ID</th>
                                                <th>Name</th>
                                                <th>Program</th>
                                                <th>Year</th>
                                                <th>GPA</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${students}" var="student" varStatus="status">
                                                <c:if test="${status.index < 5}">
                                                    <tr>
                                                        <td>
                                                            <span class="badge bg-secondary">${student.studentId}</span>
                                                        </td>
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <i class="fas fa-user-circle fa-lg text-muted me-2"></i>
                                                                <strong>${student.fullName}</strong>
                                                            </div>
                                                        </td>
                                                        <td>${student.program}</td>
                                                        <td>${student.yearSuffix}</td>
                                                        <td>
                                                            <fmt:formatNumber value="${student.gpa}" 
                                                                            maxFractionDigits="2" minFractionDigits="2"/>
                                                        </td>
                                                        <td>
                                                            <span class="badge ${student.active ? 'bg-success' : 'bg-danger'}">
                                                                ${student.status}
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <a href="<c:url value='/students/${student.id}'/>" 
                                                               class="btn btn-sm btn-outline-primary" title="View Details">
                                                                <i class="fas fa-eye"></i>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-5">
                                    <i class="fas fa-users fa-3x text-muted mb-3"></i>
                                    <h5 class="text-muted">No students found</h5>
                                    <p class="text-muted">Start by adding your first student to the system.</p>
                                    <a href="<c:url value='/students/add'/>" class="btn btn-primary">
                                        <i class="fas fa-plus me-2"></i>Add First Student
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
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
    <script src="<c:url value='/static/js/app.js'/>"></script>
</body>
</html>
