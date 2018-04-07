from marshmallow import Schema, fields

class UserSchema(Schema):
    username = fields.Str(required=True)
    password = fields.Str(required=True, load_only=True)
    token = fields.Str(dump_only=True)

    class Meta:
        strict = True
