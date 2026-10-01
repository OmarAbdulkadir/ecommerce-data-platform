import psycopg2
from psycopg2.extras import RealDictCursor


def get_connection():
    return psycopg2.connect(
        host="localhost", database="ecommerce", user="HP", password=""
    )


def run_query(query):
    conn = get_connection()
    cursor = conn.cursor(cursor_factory=RealDictCursor)
    cursor.execute(query)
    results = cursor.fetchall()
    cursor.close()
    conn.close()
    return results
