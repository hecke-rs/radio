from flask import Flask, jsonify

# this is an 'app factory'.
# you might want to check out [http://flask.pocoo.org/docs/0.12/patterns/appfactories/]
# if you're confused.
def create_app(config_object):
    app = Flask(__name__)
    app.config.from_object(config_object)

    register_extensions(app)
    register_exceptions(app)
    register_blueprints(app)

    return app

def register_extensions(app):
    from .extensions import db, migrate, jwt

    db.init_app(app)
    migrate.init_app(app)
    jwt.init_app(app)

def register_exceptions(app):
    from .exceptions import APIError
    @app.errorhandler(APIError)
    def apierror_handler(error):
        response = error.to_json()
        response.status_code = error.status_code
        return response

    @app.errorhandler(422)
    def handle_unprocessable_entity(err):
        exc = getattr(err, 'exc')
        if exc:
            messages = exc.messages
        else:
            messages = ['Invalid request']

        return jsonify({'messages': messages}), 422

def register_blueprints(app):
    from .auth.routes import bp as auth
    app.register_blueprint(auth)
