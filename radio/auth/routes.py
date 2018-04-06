from flask import Blueprint
from sqlalchemy.exc import IntegrityError
from webargs.flaskparser import use_args

from .models import User
from .serde import UserSchema
from ..exceptions import APIError
from ..extensions import db
from ..decorators import serializes_to

bp = Blueprint('auth', __name__)

@bp.route('/api/auth/users', methods=['POST'])
@use_args(UserSchema())
@serializes_to(UserSchema())
def register_user(args):
    u = User(**args)
    try:
        db.session.add(u)
        db.session.commit()
    except IntegrityError:
        db.session.rollback()
        raise APIError.user_already_registered()

    return u
