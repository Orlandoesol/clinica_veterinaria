import {db} from '../database/conexion_db.js';

const create = async (id_cliente, nombre, primer_apellido, segundo_apellido, telefono_1, telefono_2, email) => {
    const query = {
        text: `
        INSERT INTO clientes (id_cliente, nombre, primer_apellido, segundo_apellido, telefono_1, telefono_2, email)
        VALUES ($1, $2, $3, $4, $5, $6, $7)
        RETURNING *
        `,
        values: [id_cliente, nombre, primer_apellido, segundo_apellido, telefono_1, telefono_2, email]
    }

    const {} = await db.query(query);
    return rows;
}

//Mostrar datos de los cleintes
const show = async (req, res) => {
    const result = await db.query('SELECT * FROM clientes');
    res.json(result.rows);
}

const findOneByEmail = async (email) => {
    const query = {
        text: `
        SELECT * FROM clientes WHERE email = $1
        `
    }
    const {rows} = await db.query(query, [email]);
    return rows[0];
}


export const ClientModel = {
    create,
    show,
    findOneByEmail
}