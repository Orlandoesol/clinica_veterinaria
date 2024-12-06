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
    console.log("Conexión Exitosa!!");
} catch (error) {
    console.log(error);
}

//Como probar la conexión
//node database/conexion_db.js