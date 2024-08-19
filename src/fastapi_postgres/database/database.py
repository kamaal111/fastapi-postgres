from typing import TYPE_CHECKING
from sqlmodel import SQLModel, create_engine

from .settings import settings
from fastapi_postgres.hero import database_models  # type: ignore # noqa: F401

if TYPE_CHECKING:
    from sqlalchemy import Engine


class Database:
    engine: "Engine"

    def __init__(self) -> None:
        self.engine = create_engine(
            settings.database_url_string, echo=settings.is_in_debug_mode
        )

    def create_db_and_tables(self):
        SQLModel.metadata.create_all(self.engine)


database = Database()
