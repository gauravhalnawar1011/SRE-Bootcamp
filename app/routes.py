from flask import Blueprint, request, jsonify
from app import db
from app.models import Student

student_bp = Blueprint("student_bp", __name__)  # ✅ Define Blueprint

# 🟢 POST API - Add a new student
@student_bp.route("/api/v1/students", methods=["POST"])
def add_student():
    try:
        data = request.get_json()
        if not data or not all(k in data for k in ["name", "age", "grade"]):
            return jsonify({"error": "Missing required fields"}), 400

        new_student = Student(name=data["name"], age=data["age"], grade=data["grade"])
        db.session.add(new_student)
        db.session.commit()

        return jsonify({"message": "Student added successfully!", "student": {
            "id": new_student.id, "name": new_student.name, "age": new_student.age, "grade": new_student.grade
        }}), 201

    except Exception as e:
        db.session.rollback()
        return jsonify({"error": str(e)}), 500


# 🟢 GET API - Fetch all students
@student_bp.route("/api/v1/students", methods=["GET"])
def get_students():
    try:
        students = Student.query.all()
        students_list = [{"id": s.id, "name": s.name, "age": s.age, "grade": s.grade} for s in students]
        return jsonify({"students": students_list}), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500


# 🟢 GET API - Fetch a student by ID
@student_bp.route("/api/v1/students/<int:student_id>", methods=["GET"])
def get_student_by_id(student_id):
    try:
        student = Student.query.get(student_id)
        if not student:
            return jsonify({"error": "Student not found"}), 404

        return jsonify({"id": student.id, "name": student.name, "age": student.age, "grade": student.grade}), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500
