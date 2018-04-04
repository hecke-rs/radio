class Config:
	DEBUG = False

class ProdConfig(Config):
	pass

class DevConfig(Config):
	DEBUG = True
