from flask import Blueprint
from sqlalchemy.exc import IntegrityError
from webargs.flaskparser import use_kwargs

from .models import User
from .serde import UserSchema
from ..exceptions import APIError
from ..extensions import db
from ..decorators import serializes_to

bp = Blueprint('auth', __name__)

@bp.route('/api/auth/users', methods=['POST'])
@use_kwargs(UserSchema())
@serializes_to(UserSchema())
def register_user(**kwargs):
    user = User(**kwargs)
    try:
        db.session.add(user)
        db.session.commit()
    except IntegrityError:
        db.session.rollback()
        raise APIError.user_already_registered()

    return user

@bp.route('/api/auth/signin', methods=['POST'])
@use_kwargs(UserSchema())
@serializes_to(UserSchema())
def signin_user(username, password):
    user = User.query.filter_by(username=username).first()
    if user is not None and user.check_password(password):
        return user
    else:
        raise APIError.user_not_found()
