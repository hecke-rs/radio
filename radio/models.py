from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.ext.hybrid import hybrid_property
from flask_migrate import Migrate
from passlib.context import CryptContext
db = SQLAlchemy()
migrate = Migrate(db=db)
hash_ctx = CryptContext(schemes=['argon2'])

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(32), unique=True, nullable=False)
    password = db.Column(db.String(128), nullable=False)

    def __init__(self, username, password):
        self.username = username
        self.password = hash_ctx.hash(password)

    def __repr__(self) -> str:
        return f'<User {self.id}: {self.username!r}>'

    def check_password(self, password: str) -> bool:
        hash_ctx.verify(password, self.password)

