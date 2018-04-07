"""empty message

Revision ID: d807dcc3b3ba
Revises: fffd5e733e9d
Create Date: 2018-04-07 11:26:41.357777

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = 'd807dcc3b3ba'
down_revision = 'fffd5e733e9d'
branch_labels = None
depends_on = None


ENUM = postgresql.ENUM('NORMAL', 'DJ', 'ADMIN', name='role')

def upgrade():
    ENUM.create(op.get_bind(), checkfirst=False)
    op.add_column('users', sa.Column('role', ENUM, nullable=False))


def downgrade():
    op.drop_column('users', 'role')
    ENUM.drop(op.get_bind(), checkfirst=False)
