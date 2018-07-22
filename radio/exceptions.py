from flask import jsonify

class APIError(Exception):
    status_code = 500

    def __init__(self, message, status_code=None, payload=None):
        super().__init__()
        self.message = message
        if status_code is not None:
            self.status_code = status_code
        self.payload = payload

    def to_json(self):
        rv = self.payload or {}
        rv['message'] = self.message
        return jsonify(rv)

    @classmethod
    def user_already_registered(cls):
        return cls("User already registered", status_code=422)

    @classmethod
    def user_not_found(cls):
        return cls("User not found", status_code=401)
