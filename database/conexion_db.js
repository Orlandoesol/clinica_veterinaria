import 'dotenv/config';
import pg from 'pg';

const { Pool } = pg;

const connectionString = process.env.DATABASE_URL;

export const db = new Pool({
    allowExitOnIdle: true,
    connectionString
});


//Probar conexion
try {
    await db.query('SELECT NOW()');
    console.log("Conexion Exitosa!!");
} catch (error) {
    console.log(error);
}