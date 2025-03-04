from marshmallow import Schema, fields

class StudentSchema(Schema):
    name = fields.String(required=True)
    age = fields.Integer(required=True)
    grade = fields.String(required=True)

student_schema = StudentSchema()