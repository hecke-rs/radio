import os

class Config:
    DEBUG = False
    SQLALCHEMY_DATABASE_URI = os.environ.get("DATABASE_URL", "postgres://localhost/heckersradio")
    SQLALCHEMY_TRACK_MODIFICATIONS = False

class ProdConfig(Config):
    JWT_SECRET_KEY = os.environ.get('JWT_SECRET_KEY')

class DevConfig(Config):
    DEBUG = True
    JWT_SECRET_KEY='d3v3lopm3nt'
