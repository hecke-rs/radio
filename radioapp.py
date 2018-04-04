from flask.helpers import get_debug_flag
from radio import create_app
from radio.settings import DevConfig, ProdConfig


config = DevConfig() if get_debug_flag else ProdConfig() 
app = create_app(config)