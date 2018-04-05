import os

class Config:
    DEBUG = False
    SQLALCHEMY_DATABASE_URI = os.environ.get("DATABASE_URL", "postgres://localhost/heckersradio")
    SQLALCHEMY_TRACK_MODIFICATIONS = False

class ProdConfig(Config):
    pass

class DevConfig(Config):
    DEBUG = True
