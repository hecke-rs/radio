from passlib.context import CryptContext
from flask_jwt_extended import create_access_token
from ..extensions import db, jwt
from ..exceptions import APIError

hash_ctx = CryptContext(schemes=['argon2'])

class User(db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(32), unique=True, nullable=False)
    password = db.Column(db.String(128), nullable=False)

    def __init__(self, username, password):
        self.username = username
        self.password = hash_ctx.hash(password)

    def __repr__(self) -> str:
        return f'<User {self.id}: {self.username!r}>'

    def check_password(self, password: str) -> bool:
        return hash_ctx.verify(password, self.password)

    @property
    def token(self):
        return create_access_token(identity=self)

@jwt.user_identity_loader
def user_identity_lookup(user):
    return user.username

@jwt.user_loader_error_loader
def user_loader_error(identity):
    raise APIError.user_not_found()

@jwt.user_loader_callback_loader
def user_loader_callback(identity):
    return User.query.filter_by(username=username).first()
