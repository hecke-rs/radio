from functools import wraps
from flask import jsonify

def serializes_to(schema):
    def decorator(f):
        @wraps(f)
        def decorated(*args, **kwargs):
            res = f(*args, **kwargs)
            return jsonify(schema.dump(res))
        return decorated
    return decorator
