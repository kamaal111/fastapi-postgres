from typing import Literal
from pydantic import PostgresDsn
from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    database_url: PostgresDsn
    run_mode: Literal["DEBUG", "RELEASE"] = "DEBUG"

    @property
    def database_url_string(self):
        return str(self.database_url)

    @property
    def is_in_debug_mode(self):
        return self.run_mode == "DEBUG"


settings = Settings()  # type: ignore
