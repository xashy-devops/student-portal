<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Students - Xashy Tech University Student Portal</title>
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
                        <a class="nav-link active" href="<c:url value='/students/list'/>">
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
            <div class="col-md-8">
                <h1 class="display-5">
                    <i class="fas fa-users text-primary me-3"></i>
                    Student Directory
                </h1>
                <p class="lead text-muted">Manage and view all registered students</p>
            </div>
            <div class="col-md-4 text-end">
                <a href="<c:url value='/students/add'/>" class="btn btn-primary btn-lg">
                    <i class="fas fa-plus me-2"></i>Add New Student
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

        <!-- Search and Filter -->
        <div class="card border-0 shadow-sm mb-4">
            <div class="card-body">
                <form method="GET" action="<c:url value='/students/list'/>">
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label for="search" class="form-label">Search Students</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-search"></i></span>
                                <input type="text" class="form-control" id="search" name="search" 
                                       placeholder="Search by name..." value="${param.search}">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <label for="program" class="form-label">Program</label>
                            <select class="form-select" id="program" name="program">
                                <option value="">All Programs</option>
                                <option value="Computer Science" ${param.program == 'Computer Science' ? 'selected' : ''}>Computer Science</option>
                                <option value="Software Engineering" ${param.program == 'Software Engineering' ? 'selected' : ''}>Software Engineering</option>
                                <option value="Cybersecurity" ${param.program == 'Cybersecurity' ? 'selected' : ''}>Cybersecurity</option>
                                <option value="Data Science" ${param.program == 'Data Science' ? 'selected' : ''}>Data Science</option>
                                <option value="DevOps Engineering" ${param.program == 'DevOps Engineering' ? 'selected' : ''}>DevOps Engineering</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <label for="year" class="form-label">Year</label>
                            <select class="form-select" id="year" name="year">
                                <option value="">All Years</option>
                                <option value="1" ${param.year == '1' ? 'selected' : ''}>1st Year</option>
                                <option value="2" ${param.year == '2' ? 'selected' : ''}>2nd Year</option>
                                <option value="3" ${param.year == '3' ? 'selected' : ''}>3rd Year</option>
                                <option value="4" ${param.year == '4' ? 'selected' : ''}>4th Year</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">&nbsp;</label>
                            <div class="d-grid gap-2 d-md-flex">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-filter me-1"></i>Filter
                                </button>
                                <a href="<c:url value='/students/list'/>" class="btn btn-outline-secondary">
                                    <i class="fas fa-times me-1"></i>Clear
                                </a>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Students Table -->
        <div class="card border-0 shadow-sm">
            <div class="card-header bg-white">
                <div class="d-flex justify-content-between align-items-center">
                    <h5 class="card-title mb-0">
                        <i class="fas fa-table text-primary me-2"></i>
                        Students List
                        <span class="badge bg-primary ms-2">${students != null ? students.size() : 0} students</span>
                    </h5>
                    <div class="btn-group" role="group">
                        <button type="button" class="btn btn-sm btn-outline-secondary">
                            <i class="fas fa-download me-1"></i>Export
                        </button>
                        <a href="<c:url value='/students/api/students'/>" target="_blank" class="btn btn-sm btn-outline-info">
                            <i class="fas fa-code me-1"></i>JSON API
                        </a>
                    </div>
                </div>
            </div>
            <div class="card-body p-0">
                <c:choose>
                    <c:when test="${not empty students}">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th scope="col">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" id="selectAll">
                                            </div>
                                        </th>
                                        <th scope="col">Student ID</th>
                                        <th scope="col">Name</th>
                                        <th scope="col">Email</th>
                                        <th scope="col">Program</th>
                                        <th scope="col">Year</th>
                                        <th scope="col">GPA</th>
                                        <th scope="col">Status</th>
                                        <th scope="col">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${students}" var="student">
                                        <tr>
                                            <td>
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" value="${student.id}">
                                                </div>
                                            </td>
                                            <td>
                                                <span class="badge bg-secondary">${student.studentId}</span>
                                            </td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="avatar-circle bg-primary text-white me-2">
                                                        ${student.firstName.substring(0,1)}${student.lastName.substring(0,1)}
                                                    </div>
                                                    <div>
                                                        <div class="fw-bold">${student.fullName}</div>
                                                        <small class="text-muted">
                                                            <fmt:formatDate value="${student.enrollmentDate}" pattern="MMM yyyy"/>
                                                        </small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <a href="mailto:${student.email}" class="text-decoration-none">
                                                    ${student.email}
                                                </a>
                                            </td>
                                            <td>
                                                <span class="badge bg-info">${student.program}</span>
                                            </td>
                                            <td>${student.yearSuffix}</td>
                                            <td>
                                                <span class="badge ${student.gpa >= 3.5 ? 'bg-success' : student.gpa >= 3.0 ? 'bg-warning' : 'bg-danger'}">
                                                    <fmt:formatNumber value="${student.gpa}" maxFractionDigits="2" minFractionDigits="2"/>
                                                </span>
                                            </td>
                                            <td>
                                                <span class="badge ${student.active ? 'bg-success' : 'bg-danger'}">
                                                    <i class="fas ${student.active ? 'fa-check' : 'fa-times'} me-1"></i>
                                                    ${student.status}
                                                </span>
                                            </td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <a href="<c:url value='/students/${student.id}'/>" 
                                                       class="btn btn-sm btn-outline-primary" title="View Details">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <a href="<c:url value='/students/${student.id}/edit'/>" 
                                                       class="btn btn-sm btn-outline-warning" title="Edit">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <button type="button" class="btn btn-sm btn-outline-danger" 
                                                            title="Delete" onclick="confirmDelete(${student.id}, '${student.fullName}')">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <i class="fas fa-search fa-3x text-muted mb-3"></i>
                            <h5 class="text-muted">No students found</h5>
                            <p class="text-muted">
                                <c:choose>
                                    <c:when test="${not empty param.search or not empty param.program or not empty param.year}">
                                        Try adjusting your search criteria or
                                        <a href="<c:url value='/students/list'/>" class="text-decoration-none">clear filters</a>.
                                    </c:when>
                                    <c:otherwise>
                                        Start by adding your first student to the system.
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <a href="<c:url value='/students/add'/>" class="btn btn-primary">
                                <i class="fas fa-plus me-2"></i>Add First Student
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Pagination (if needed) -->
        <c:if test="${not empty students and students.size() > 10}">
            <nav aria-label="Students pagination" class="mt-4">
                <ul class="pagination justify-content-center">
                    <li class="page-item disabled">
                        <span class="page-link">Previous</span>
                    </li>
                    <li class="page-item active">
                        <span class="page-link">1</span>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#">2</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#">Next</a>
                    </li>
                </ul>
            </nav>
        </c:if>
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
                    <p>Are you sure you want to delete student <strong id="studentName"></strong>?</p>
                    <p class="text-muted small">This action cannot be undone.</p>
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

        // Select all checkbox functionality
        document.getElementById('selectAll').addEventListener('change', function() {
            const checkboxes = document.querySelectorAll('tbody input[type="checkbox"]');
            checkboxes.forEach(checkbox => {
                checkbox.checked = this.checked;
            });
        });
    </script>
    <script src="<c:url value='/static/js/app.js'/>"></script>
</body>
</html>
