package com.xashytech.university.service;

import com.xashytech.university.dao.StudentDAO;
import com.xashytech.university.model.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * Student Service Layer
 * Contains business logic for student operations
 */
@Service
public class StudentService {

    @Autowired
    private StudentDAO studentDAO;

    /**
     * Get all students
     */
    public List<Student> getAllStudents() {
        return studentDAO.findAll();
    }

    /**
     * Get student by ID
     */
    public Student getStudentById(Long id) {
        return studentDAO.findById(id);
    }

    /**
     * Get student by student ID
     */
    public Student getStudentByStudentId(String studentId) {
        return studentDAO.findByStudentId(studentId);
    }

    /**
     * Save new student
     */
    public Student saveStudent(Student student) {
        // Validate student data
        if (!student.isValid()) {
            throw new IllegalArgumentException("Student data is invalid");
        }

        // Check if student ID already exists
        if (studentDAO.findByStudentId(student.getStudentId()) != null) {
            throw new IllegalArgumentException("Student ID already exists: " + student.getStudentId());
        }

        // Check if email already exists
        if (studentDAO.findByEmail(student.getEmail()) != null) {
            throw new IllegalArgumentException("Email already exists: " + student.getEmail());
        }

        // Generate student ID if not provided
        if (student.getStudentId() == null || student.getStudentId().trim().isEmpty()) {
            student.setStudentId(generateStudentId());
        }

        return studentDAO.save(student);
    }

    /**
     * Update existing student
     */
    public Student updateStudent(Student student) {
        if (!student.isValid()) {
            throw new IllegalArgumentException("Student data is invalid");
        }

        Student existingStudent = studentDAO.findById(student.getId());
        if (existingStudent == null) {
            throw new IllegalArgumentException("Student not found with ID: " + student.getId());
        }

        // Check if email is being changed and if it conflicts with another student
        if (!existingStudent.getEmail().equals(student.getEmail())) {
            Student emailConflict = studentDAO.findByEmail(student.getEmail());
            if (emailConflict != null && !emailConflict.getId().equals(student.getId())) {
                throw new IllegalArgumentException("Email already exists: " + student.getEmail());
            }
        }

        return studentDAO.update(student);
    }

    /**
     * Delete student
     */
    public boolean deleteStudent(Long id) {
        Student student = studentDAO.findById(id);
        if (student == null) {
            throw new IllegalArgumentException("Student not found with ID: " + id);
        }
        return studentDAO.delete(id);
    }

    /**
     * Search students by name
     */
    public List<Student> searchStudentsByName(String searchTerm) {
        return getAllStudents().stream()
                .filter(student -> 
                    student.getFirstName().toLowerCase().contains(searchTerm.toLowerCase()) ||
                    student.getLastName().toLowerCase().contains(searchTerm.toLowerCase()) ||
                    student.getFullName().toLowerCase().contains(searchTerm.toLowerCase())
                )
                .collect(Collectors.toList());
    }

    /**
     * Get students by program
     */
    public List<Student> getStudentsByProgram(String program) {
        return getAllStudents().stream()
                .filter(student -> student.getProgram().equalsIgnoreCase(program))
                .collect(Collectors.toList());
    }

    /**
     * Get students by year
     */
    public List<Student> getStudentsByYear(String year) {
        return getAllStudents().stream()
                .filter(student -> student.getYear().equals(year))
                .collect(Collectors.toList());
    }

    /**
     * Get active students only
     */
    public List<Student> getActiveStudents() {
        return getAllStudents().stream()
                .filter(Student::isActive)
                .collect(Collectors.toList());
    }

    /**
     * Get student statistics
     */
    public StudentStatistics getStatistics() {
        List<Student> allStudents = getAllStudents();
        
        long totalStudents = allStudents.size();
        long activeStudents = allStudents.stream().filter(Student::isActive).count();
        long inactiveStudents = totalStudents - activeStudents;
        
        double averageGpa = allStudents.stream()
                .filter(s -> s.getGpa() != null && s.getGpa() > 0)
                .mapToDouble(Student::getGpa)
                .average()
                .orElse(0.0);

        return new StudentStatistics(totalStudents, activeStudents, inactiveStudents, averageGpa);
    }

    /**
     * Generate a unique student ID
     */
    private String generateStudentId() {
        String prefix = "XTU";
        int year = java.time.LocalDate.now().getYear();
        int sequence = getAllStudents().size() + 1;
        return String.format("%s%d%04d", prefix, year, sequence);
    }

    /**
     * Inner class for student statistics
     */
    public static class StudentStatistics {
        private final long totalStudents;
        private final long activeStudents;
        private final long inactiveStudents;
        private final double averageGpa;

        public StudentStatistics(long totalStudents, long activeStudents, long inactiveStudents, double averageGpa) {
            this.totalStudents = totalStudents;
            this.activeStudents = activeStudents;
            this.inactiveStudents = inactiveStudents;
            this.averageGpa = averageGpa;
        }

        // Getters
        public long getTotalStudents() { return totalStudents; }
        public long getActiveStudents() { return activeStudents; }
        public long getInactiveStudents() { return inactiveStudents; }
        public double getAverageGpa() { return averageGpa; }
    }
}