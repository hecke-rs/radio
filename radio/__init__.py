from flask import Flask

# this is an 'app factory'.
# you might want to check out [http://flask.pocoo.org/docs/0.12/patterns/appfactories/]
# if you're confused.
def create_app(config_object):
    app = Flask(__name__)
    app.config.from_object(config_object)

    register_extensions(app)

    return app

def register_extensions(app):
    from .models import db, migrate
    db.init_app(app)
    migrate.init_app(app)
