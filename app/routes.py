from flask import request, jsonify
from . import app, db, limiter
from .models import Student
from .schemas import student_schema
from .logging_config import logger
import json
from marshmallow import ValidationError

@app.errorhandler(ValidationError)
def handle_validation_error(error):
    return jsonify({"error": error.messages}), 400

@app.route("/api/v1/students", methods=["POST"])
@limiter.limit("10 per minute")
def add_student():
    data = request.get_json()
    student_schema.load(data)
    new_student = Student(name=data['name'], age=data['age'], grade=data['grade'])
    db.session.add(new_student)
    db.session.commit()
    logger.info(json.dumps({"action": "add_student", "student": data}))
    return jsonify({"message": "Student added successfully!", "student": data}), 201

@app.route("/api/v1/students", methods=["GET"])
@limiter.limit("50 per minute")
def get_students():
    students = Student.query.all()
    response = [{ "id": s.id, "name": s.name, "age": s.age, "grade": s.grade } for s in students]
    logger.info(json.dumps({"action": "get_students", "count": len(response)}))
    return jsonify(response)

@app.route("/api/v1/students/<int:id>", methods=["GET"])
@limiter.limit("20 per minute")
def get_student(id):
    student = Student.query.get_or_404(id)
    logger.info(json.dumps({"action": "get_student", "id": id}))
    return jsonify({"id": student.id, "name": student.name, "age": student.age, "grade": student.grade})

@app.route("/api/v1/students/<int:id>", methods=["PUT"])
@limiter.limit("10 per minute")
def update_student(id):
    student = Student.query.get_or_404(id)
    data = request.get_json()
    student_schema.load(data)
    student.name = data.get("name", student.name)
    student.age = data.get("age", student.age)
    student.grade = data.get("grade", student.grade)
    db.session.commit()
    logger.info(json.dumps({"action": "update_student", "id": id, "updated_data": data}))
    return jsonify({"message": "Student updated successfully!"})

@app.route("/api/v1/students/<int:id>", methods=["DELETE"])
@limiter.limit("5 per minute")
def delete_student(id):
    student = Student.query.get_or_404(id)
    db.session.delete(student)
    db.session.commit()
    logger.info(json.dumps({"action": "delete_student", "id": id}))
    return jsonify({"message": "Student deleted successfully!"})

@app.route("/healthcheck", methods=["GET"])
def healthcheck():
    return jsonify({"status": "OK"}), 200


@app.route("/", methods=["GET"])
def home():
    return jsonify({"message": "Welcome to the Student API! Use /api/v1/students"}), 200

